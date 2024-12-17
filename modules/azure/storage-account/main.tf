# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "sa"
}

module "naming_storage_account" {
  # If the storage account name is not provided, we will generate one
  count   = var.storage_account_name_override == null ? 1 : 0
  source  = "Azure/naming/azurerm"
  version = "0.2.0"

  prefix = [var.org_code]
  suffix = [var.tier, "sqlaud"]
}

resource "azurerm_storage_account" "this" {
  name                = var.storage_account_name_override == null ? module.naming_storage_account[0].storage_account.name_unique : var.storage_account_name_override
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type

  min_tls_version = var.min_tls_version
  # tfsec: https://aquasecurity.github.io/tfsec/v1.28.1/checks/azure/storage/use-secure-tls-policy/
  tags = module.defaults.tags

  public_network_access_enabled = var.public_network_access_enabled

  # TODO: This is overly permissive. We should be able to restrict this with proper configuration
  network_rules {
    default_action = "Allow"
  }
  dynamic "identity" {
    for_each = var.identity != null ? [1] : []
    content {
      type = var.identity.type
    }
  }
  dynamic "blob_properties" {
    for_each = var.account_soft_delete_retention_days > 0 ? [1] : []
    content {
      delete_retention_policy {
        days = var.account_soft_delete_retention_days
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.logging_properties != null ? [1] : []
    content {
      logging {
        delete  = var.logging_properties.delete
        read    = var.logging_properties.read
        version = var.logging_properties.version
        write   = var.logging_properties.write

        retention_policy_days = var.logging_properties.retention_policy_days
      }
    }
  }
  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}

resource "azurerm_storage_container" "this" {
  count                 = var.storage_container_config == null ? 0 : 1
  name                  = var.storage_container_config.name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.storage_container_config.container_access_type
  metadata = {
    for k, v in merge(module.defaults.tags, var.storage_container_config.metadata) : lower(replace(k, "-", "_")) => v
  }
}
