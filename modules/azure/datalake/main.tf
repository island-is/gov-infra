# Module scaffolded via skyvafnir-module-template by
# Author: jonorri
# Version: 0.1.0
# Timestamp: 2023-04-29T10:55:59

data "azurerm_client_config" "current" {}

locals {
  tenant_id             = var.tenant_id != "" ? var.tenant_id : data.azurerm_client_config.current.tenant_id
  resource_abbreviation = "sa"
}

module "naming_storage_account" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"

  prefix = [var.org_code]
  suffix = module.defaults.suffix
}

resource "azurerm_key_vault_key" "this" {
  name         = var.keyvault_key_name_override == null ? format(module.defaults.resource_name_template, "kvk") : var.keyvault_key_name_override
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]

  depends_on = [
    azurerm_key_vault_access_policy.storage,
  ]
}

resource "azurerm_storage_account" "this" {
  name = var.storage_account_name_override == null ? module.naming_storage_account.storage_account.name_unique : var.storage_account_name_override

  account_replication_type        = "GRS"
  account_tier                    = "Standard"
  location                        = var.resource_group_info.location
  resource_group_name             = var.resource_group_info.name
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true
  is_hns_enabled                  = true
  shared_access_key_enabled       = true

  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  network_rules {
    default_action = "Deny"
    ip_rules       = var.datalake_ip_whitelist
    bypass = [
      "AzureServices",
      "Logging",
      "Metrics"
    ]

    dynamic "private_link_access" {
      for_each = length(var.private_link_access_endpoint_resource_ids) == 0 ? [] : var.private_link_access_endpoint_resource_ids
      content {
        endpoint_resource_id = private_link_access.value
      }
    }
  }

  routing {
    choice = "MicrosoftRouting"
  }

  tags = module.defaults.tags

  lifecycle {
    # TF always wants to change this parameter since we're using
    # azurerm_storage_account_customer_managed_key
    ignore_changes = [customer_managed_key]
  }
}

resource "azurerm_storage_container" "this" {
  name                  = "ingest"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "this" {
  count                = var.provision_fileshare ? 1 : 0
  name                 = "ingest-fileshare"
  storage_account_name = azurerm_storage_account.this.name
  enabled_protocol     = "SMB"
  quota                = 50
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = var.key_vault_id
  tenant_id    = local.tenant_id
  object_id    = azurerm_storage_account.this.identity[0].principal_id

  secret_permissions = ["Get"]

  key_permissions = [
    "Get",
    "Create",
    "List",
    "Restore",
    "Recover",
    "UnwrapKey",
    "WrapKey",
    "Purge",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify"
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = var.key_vault_id
  key_name           = azurerm_key_vault_key.this.name
}
