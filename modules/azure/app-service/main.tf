# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-17T13:33:48

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

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name = format(module.defaults.resource_name_template, "law")

  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location
}

resource "azurerm_linux_web_app" "this" {
  name = var.app_service_name_override != "" ? var.app_service_name_override : module.defaults.resource_name

  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  virtual_network_subnet_id     = var.subnet_id
  client_affinity_enabled       = false
  client_certificate_enabled    = false
  client_certificate_mode       = "Required"
  enabled                       = true
  https_only                    = true
  public_network_access_enabled = true
  service_plan_id               = azurerm_service_plan.this.id

  app_settings = local.app_settings

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                               = false
    container_registry_use_managed_identity = false
    default_documents = [
      "Default.htm",
      "Default.html",
      "Default.asp",
      "index.htm",
      "index.html",
      "iisstart.htm",
      "default.aspx",
      "index.php",
      "hostingstart.html",
    ]
    ftps_state                  = "FtpsOnly"
    http2_enabled               = false
    load_balancing_mode         = "LeastRequests"
    local_mysql_enabled         = false
    managed_pipeline_mode       = "Integrated"
    minimum_tls_version         = "1.2"
    remote_debugging_enabled    = false
    remote_debugging_version    = "VS2019"
    scm_minimum_tls_version     = "1.2"
    scm_use_main_ip_restriction = false
    use_32_bit_worker           = true
    vnet_route_all_enabled      = true
    websockets_enabled          = false
    worker_count                = 1

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  tags = var.tags
}

resource "azurerm_service_plan" "this" {
  name                = "${var.org_code}-${var.instance}-${var.tier}-appsp"
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  os_type                  = "Linux"
  per_site_scaling_enabled = false
  sku_name                 = "B1"
  worker_count             = 1
  zone_balancing_enabled   = false

  tags = var.tags
}
