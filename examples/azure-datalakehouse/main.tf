data "azurerm_client_config" "current" {}

locals {
  default_tags = {
    _iac-infra-module = basename(path.module)
  }
}

locals {
  tags = merge(local.default_tags, var.tags)

  # Feature flags. Be sure to add any new flags here.
  api_management_enabled = coalesce(var.features.api_management, true)
  warehouse_enabled      = coalesce(var.features.datawarehouse, true)
  data_factory_enabled   = coalesce(var.features.data_factory, true)
  datalake_enabled       = coalesce(var.features.datalake, true)
  keyvault_enabled       = coalesce(var.features.keyvault, true)
}

data "azurerm_subscription" "workload_subscription" {
  # This is the workload subscription. It needs to be created by hand.
  subscription_id = var.platform_config.workload_subscription_id
}

data "azurerm_management_group" "workload_mgtm_group" {
  # This is the workload management group, created by the azure-landing-zone infrastructure module.
  count = var.platform_config.workload_management_group_name != "" ? 1 : 0
  name  = var.platform_config.workload_management_group_name
}

resource "azurerm_management_group_subscription_association" "workload_subscription_association" {
  count               = var.platform_config.workload_management_group_name != "" ? 1 : 0
  management_group_id = data.azurerm_management_group.workload_mgtm_group[0].id
  subscription_id     = data.azurerm_subscription.workload_subscription.id
}

module "base_setup" {
  source = "../../modules/azure/base-setup"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  existing_resource_group_info = var.existing_resource_group_info

  budget_for_resource_group = var.budget_for_resource_group
  budget_contact_emails     = var.budget_contact_emails

  tags = local.tags
}

module "keyvault" {
  count  = local.keyvault_enabled ? 1 : 0
  source = "../../modules/azure/keyvault"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = module.base_setup.resource_group_info

  keyvault_admin_principal_id  = data.azurerm_client_config.current.object_id
  keyvault_admin_principal_ids = var.datalakehouse_admins
  keyvault_ip_whitelist        = var.keyvault_ip_whitelist
  keyvault_name_override       = try(var.name_overrides.keyvault, null)

  keyvault_secret_readers = {
    # This is the data factory service principal, if it exists.
    # It's used to allow the data factory to read secrets from the key vault.
    "Azure Data Factory" = module.datafactory[0].service_principal_object_id
  }

  keyvault_secret_contributors = var.datalakehouse_contributor_can_contribute_to_keyvault ? {
    "Data Engineer Group" = module.data_engineer_user_group[0].group_id
  } : {}

  tags = local.tags
}

module "datalake" {
  count  = local.datalake_enabled ? 1 : 0
  source = "../../modules/azure/datalake"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = module.base_setup.resource_group_info


  key_vault_id                  = module.keyvault[0].key_vault_id
  datalake_ip_whitelist         = var.datalake_whitelisted_cidrs
  provision_fileshare           = false
  keyvault_key_name_override    = try(var.name_overrides.datalake_keyvault_key, null)
  storage_account_name_override = try(var.name_overrides.datalake_storage_account, null)
  datalake_contributor_group_id = module.data_engineer_user_group[0].group_id

  private_link_access_endpoint_resource_ids = local.data_factory_enabled ? [
    module.datafactory[0].id
  ] : []

  tags = local.tags
}

module "datafactory" {
  count  = local.data_factory_enabled ? 1 : 0
  source = "../../modules/azure/datafactory"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = module.base_setup.resource_group_info

  datalake_id                      = local.datalake_enabled ? module.datalake[0].datalake_id : ""
  link_service_to_datalake         = false # TODO: This sits on the boundary of infrastructure and data engineering.
  grant_access_to_warehouse        = local.warehouse_enabled
  warehouse_id                     = local.warehouse_enabled ? module.datawarehouse[0].sql_server_id : null
  git_backend_config               = var.adf_git_backend_config
  datafactory_contributor_group_id = module.data_engineer_user_group[0].group_id
  name_override                    = try(var.name_overrides.datafactory, null)

  group_config = {
    purpose = "datafactory"
    owners  = var.datalakehouse_admins
  }

  tags = local.tags
}

module "datawarehouse" {
  count  = local.warehouse_enabled ? 1 : 0
  source = "../../modules/azure/datawarehouse"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info                 = module.base_setup.resource_group_info
  ad_sql_admin_id                     = module.warehouse_admin_group[0].group_id
  ad_sql_admin_display_name           = module.warehouse_admin_group[0].group_display_name
  key_vault_id                        = local.keyvault_enabled ? module.keyvault[0].key_vault_id : var.existing_audit_keyvault_id
  warehouse_ip_whitelist              = var.warehouse_config.ip_whitelist
  sql_server_name_override            = try(var.name_overrides.sql_server, null)
  keyvault_key_name_override          = try(var.name_overrides.warehouse_audit_keyvault_key, null)
  audit_storage_account_name_override = try(var.name_overrides.warehouse_audit_storage_account, null)
  monitor_alert_emails                = ["jonorri@skyvafnir.is"]
  enable_monitor_alerts               = true

  datawarehouse_contributor_principal_ids = {
    "Data Engineer Group" = module.data_engineer_user_group[0].group_id
  }

  databases = {
    "gogn" = {
      sku_name       = var.warehouse_config.sku_name
      zone_redundant = var.warehouse_config.zone_redundant
      max_size_gb    = var.warehouse_config.max_size_gb
      collation      = var.warehouse_config.collation
      name_override  = try(var.name_overrides.db, null)
    }
  }

  tags = local.tags
}

module "api_management" {
  count  = local.api_management_enabled ? 1 : 0
  source = "../../modules/azure/api-management"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  sku_capacity             = try(var.api_management_config.sku_capacity, null)
  sku_name                 = try(var.api_management_config.sku_name, null)
  publisher_email          = try(var.api_management_config.publisher_email, null)
  publisher_name           = try(var.api_management_config.publisher_name, null)
  resource_group_info      = module.base_setup.resource_group_info
  api_contributor_group_id = module.data_engineer_user_group[0].group_id

  tags = local.tags
}
