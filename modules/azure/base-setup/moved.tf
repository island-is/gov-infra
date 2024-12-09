# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
moved {
  from = azurerm_monitor_action_group.this[0]
  to   = module.cost_alarm_action_group[0].azurerm_monitor_action_group.this
}
