# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2023-12-19T16:11:02

data "azurerm_resource_group" "this" {
  name = var.resource_group_name_override
}

module "base_setup" {
  source = "../../modules/azure/base-setup"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  existing_resource_group_info = {
    id       = data.azurerm_resource_group.this.id,
    name     = data.azurerm_resource_group.this.name,
    location = data.azurerm_resource_group.this.location
  }

  tags = var.tags
}

module "network_base" {
  source = "../../modules/azure/network/network-base"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  virtual_network_cidr = "10.0.0.0/16"
  subnet_cidr          = "10.0.0.0/24"
  service_endpoints    = ["Microsoft.Sql"]
  create_nat_gateway   = true
  create_delegation    = false

  vnet_name_override      = var.vnet_name_override
  public_ip_name_override = var.public_ip_name_override

  tags = var.tags
}

module "app_service" {
  source = "../../modules/azure/app-service"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  subnet_id                 = module.network_base.subnet_id
  app_settings              = var.app_service_configuration
  app_service_name_override = var.app_service_name_override

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  tags = var.tags
}

module "keyvault" {
  source = "../../modules/azure/keyvault"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  keyvault_secret_readers = {
    "App Service" : module.app_service.app_service_identity_principal_id
  }

  keyvault_admin_principal_ids = var.keyvault_admin_principal_ids

  tags = var.tags
}

module "sql_admin_group" {
  source = "../../modules/azure/ad-group"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  group_purpose = "${var.instance}_sql_admin"

  group_member_principal_ids = concat(var.sql_admin_group_owner_principal_ids, [
    module.app_service.app_service_identity_principal_id
  ])
  group_owner_principal_ids = var.sql_admin_group_owner_principal_ids
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secret_app_service_configuration

  key_vault_id = module.keyvault.key_vault_id
  name         = each.key
  value        = each.value
}

locals {
  databases = {
    for db_name, db_details in var.databases : db_name => {
      sku_name                  = db_details.sku_name
      max_size_gb               = db_details.max_size_gb
      contributor_principal_ids = [module.sql_admin_group.group_id]
    }
  }
}

module "database_server" {
  source = "../../modules/azure/datawarehouse"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  ad_sql_admin_id            = module.sql_admin_group.group_id
  ad_sql_admin_display_name  = module.sql_admin_group.group_display_name
  key_vault_id               = module.keyvault.key_vault_id
  tenant_id                  = var.tenant_id
  monitor_alert_emails       = var.sql_monitor_alert_emails
  warehouse_ip_whitelist     = var.warehouse_ip_whitelist
  warehouse_subnet_whitelist = module.network_base.subnet_id

  audit_storage_account_name_override = var.db_server_audit_storage_account_name_override

  databases = local.databases
}

provider "mssql" {
  hostname   = module.database_server.sql_server_fqdn
  azure_auth = {}
}

data "mssql_database" "databases" {
  for_each = module.database_server.db_info
  name     = each.value.name
}

module "group_sql_user" {
  for_each = data.mssql_database.databases

  source = "../../modules/mssql/external-user"

  entra_display_name = module.sql_admin_group.group_display_name

  mssql_db_info = {
    id   = each.value.id
    name = "DB_NAME"
  }
}
