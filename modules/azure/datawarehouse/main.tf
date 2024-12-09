# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

data "azurerm_client_config" "current" {}

locals {
  resource_abbreviation = "sql"
  tenant_id             = var.tenant_id != "" ? var.tenant_id : data.azurerm_client_config.current.tenant_id
}

resource "azurerm_mssql_server" "this" {
  name                                 = var.sql_server_name_override == null ? module.defaults.resource_name : var.sql_server_name_override
  resource_group_name                  = var.resource_group_info.name
  location                             = var.resource_group_info.location
  version                              = var.mssql_version
  minimum_tls_version                  = "1.2"
  public_network_access_enabled        = true
  outbound_network_restriction_enabled = false
  connection_policy                    = "Proxy"

  connection {}

  identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    azuread_authentication_only = !var.allow_sql_login
    login_username              = var.ad_sql_admin_display_name
    object_id                   = var.ad_sql_admin_id
  }

  tags = local.tags
}

# Per-database assignments
locals {
  per_database_contributor_principal_ids = {
    for key, config in var.databases : key => config.contributor_principal_ids
  }
}

module "database" {
  for_each = var.databases

  source = "../mssql-database"

  server_id = azurerm_mssql_server.this.id
  tier      = var.tier
  org_code  = var.org_code
  instance  = each.key

  name_override = each.value.name_override
  max_size_gb   = each.value.max_size_gb
  min_capacity  = each.value.min_capacity
  collation     = each.value.collation
  sku_name      = each.value.sku_name

  auto_pause_delay_minutes = each.value.auto_pause_delay_minutes

  contributor_principal_ids = local.per_database_contributor_principal_ids[each.key]

  tags = local.tags
}

module "audit_store" {
  source = "../storage-account"

  org_code = var.org_code
  tier     = var.tier
  instance = "${var.instance}audit"

  resource_group_info = var.resource_group_info

  identity = {
    type = "SystemAssigned"
  }

  account_soft_delete_retention_days = 7
  public_network_access_enabled      = false

  storage_account_name_override = var.audit_storage_account_name_override

  tags = local.tags
}

resource "azurerm_storage_account_customer_managed_key" "audit" {
  storage_account_id = module.audit_store.storage_account_id
  key_vault_id       = var.key_vault_id
  key_name           = azurerm_key_vault_key.audit.name

  depends_on = [var.key_vault_id]
}

#checkov:skip=CKV_AZURE_112:We're not going with HSMs for this set up.
resource "azurerm_key_vault_key" "audit" {
  name         = var.keyvault_key_name_override == null ? format(module.defaults.resource_name_template, "kvk-audit") : var.keyvault_key_name_override
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["unwrapKey", "wrapKey"]
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {

  server_id                               = azurerm_mssql_server.this.id
  storage_endpoint                        = module.audit_store.primary_blob_endpoint
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 90

  depends_on = [
    azurerm_role_assignment.audit_contributor,
    azurerm_storage_account_customer_managed_key.audit
  ]
}

resource "azurerm_role_assignment" "audit_contributor" {
  scope                = module.audit_store.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.this.identity[0].principal_id
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = var.key_vault_id
  tenant_id    = local.tenant_id
  object_id    = module.audit_store.identity[0].principal_id

  secret_permissions = ["Get"]

  key_permissions = [
    "Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign",
    "Verify"
  ]

  depends_on = [
    var.key_vault_id
  ]
}

resource "azurerm_key_vault_access_policy" "db" {
  key_vault_id = var.key_vault_id
  tenant_id    = local.tenant_id
  object_id    = azurerm_mssql_server.this.identity[0].principal_id

  secret_permissions = ["Get"]

  key_permissions = [
    "Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign",
    "Verify", "Backup", "Delete", "GetRotationPolicy"
  ]

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    var.key_vault_id
  ]
}

resource "azurerm_mssql_firewall_rule" "whitelist" {
  for_each         = { for rule in var.warehouse_ip_whitelist : rule.name => rule }
  server_id        = azurerm_mssql_server.this.id
  name             = each.value.name
  start_ip_address = each.value.ip_address
  end_ip_address   = each.value.ip_address
}

# https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update?view=rest-sql-2021-11-01&tabs=HTTP
resource "azurerm_mssql_firewall_rule" "this" {
  count = var.allow_access_from_azure_services ? 1 : 0

  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_virtual_network_rule" "allow_subnet_access" {
  # TODO: This sort of thing crashes if the value is the output of an unapplied module / resource
  count     = var.warehouse_subnet_whitelist != null ? 1 : 0
  name      = "Allow_subnet_access"
  server_id = azurerm_mssql_server.this.id
  subnet_id = var.warehouse_subnet_whitelist
}

