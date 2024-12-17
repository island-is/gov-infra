# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "app"
  app_settings = merge(var.app_settings, {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.this.connection_string,
    "ASPNETCORE_HTTPS_PORT"                 = "7245",
    "XDT_MicrosoftApplicationInsights_Mode" = "Recommended"
  })
}

resource "azurerm_application_insights" "this" {
  name                = format(module.defaults.resource_name_template, "appi")
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  workspace_id                          = azurerm_log_analytics_workspace.this.id
  application_type                      = "web"
  daily_data_cap_in_gb                  = 100
  daily_data_cap_notifications_disabled = false
  disable_ip_masking                    = false
  force_customer_storage_for_profiler   = false
  internet_ingestion_enabled            = true
  internet_query_enabled                = true
  local_authentication_disabled         = false
  retention_in_days                     = 90
  sampling_percentage                   = 0

  tags = local.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name = format(module.defaults.resource_name_template, "law")

  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  tags = local.tags
}

resource "azurerm_app_service_environment_v3" "this" {
  count = var.app_service_environment_enabled ? 1 : 0

  name                         = format(module.defaults.resource_name_template, "ase")
  resource_group_name          = var.resource_group_info.name
  subnet_id                    = var.subnet_id
  internal_load_balancing_mode = "None"

  cluster_setting {
    name  = "DisableTls1.0"
    value = "1"
  }

  tags = local.tags
}

resource "azurerm_linux_web_app" "this" {
  name = var.app_service_name_override != "" ? var.app_service_name_override : module.defaults.resource_name

  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  client_affinity_enabled       = false
  client_certificate_enabled    = false
  client_certificate_mode       = "Required"
  enabled                       = var.enabled
  public_network_access_enabled = var.public_network_access_enabled
  service_plan_id               = var.existing_service_plan_id != "" ? var.existing_service_plan_id : azurerm_service_plan.this[0].id
  https_only                    = true

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.key
      type  = "SQLAzure"
      value = connection_string.value
    }
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                         = true
    ftps_state                        = "Disabled"
    health_check_path                 = var.enable_health_check ? var.health_check_path : null
    health_check_eviction_time_in_min = var.enable_health_check ? var.health_check_eviction_time_in_min : null

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions

      content {
        action     = ip_restriction.value.action
        ip_address = ip_restriction.value.ip_address_cidr
        priority   = ip_restriction.value.priority
        name       = ip_restriction.value.name
      }
    }

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [app_settings, connection_string]
  }
}

locals {
  contributor_principal_ids_map = { for idx, id in var.contributor_principal_ids : idx => id }
}

resource "azurerm_role_assignment" "this" {
  for_each = local.contributor_principal_ids_map

  scope                = azurerm_linux_web_app.this.id
  role_definition_name = "Contributor"
  principal_id         = each.value
}

resource "azurerm_service_plan" "this" {
  count = var.existing_service_plan_id != "" ? 0 : 1

  name = var.app_service_plan_name_override == "" ? format(module.defaults.resource_name_template, "appsp") : var.app_service_plan_name_override

  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  app_service_environment_id = var.app_service_environment_enabled ? azurerm_app_service_environment_v3.this[0].id : null
  os_type                    = var.os_type
  per_site_scaling_enabled   = false
  sku_name                   = var.sku_name
  worker_count               = var.worker_count
  zone_balancing_enabled     = false

  tags = local.tags
}
