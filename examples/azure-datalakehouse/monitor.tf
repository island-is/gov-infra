# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

# TODO: All of this needs to move to a module
module "defaults" {
  source                = "../../modules/skyvafnir/defaults"
  resource_abbreviation = "logs"
  tags                  = var.tags
  caller                = basename(path.module)
  org_code              = var.org_code
  tier                  = var.tier
  instance              = var.instance
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = module.defaults.resource_name
  resource_group_name = module.base_setup.resource_group_name
  location            = module.base_setup.resource_group_location

  tags = module.defaults.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.data_factory_enabled ? 1 : 0
  name  = format(module.defaults.resource_name_template, "diag")

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  target_resource_id         = module.datafactory[0].id

  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category_group = "allLogs"
  }
  metric {
    category = "AllMetrics"
  }
}
