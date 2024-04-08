moved {
  from = module.contributor_access
  to   = module.server_contributor_access
}

moved {
  from = azurerm_monitor_action_group.this[0]
  to   = module.action_group[0].azurerm_monitor_action_group.this
}
