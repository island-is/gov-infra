moved { # 2023-11-09 - Add support for using an existing resource group
  from = azurerm_resource_group.this
  to   = azurerm_resource_group.this[0]
}

moved {
  from = data.external.git
  to   = data.external.git_sha
}

moved {
  from = azurerm_monitor_action_group.this[0]
  to   = module.cost_alarm_action_group[0].azurerm_monitor_action_group.this
}
