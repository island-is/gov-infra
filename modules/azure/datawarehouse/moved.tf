# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
moved {
  from = module.contributor_access
  to   = module.server_contributor_access
}

moved {
  from = azurerm_monitor_action_group.this[0]
  to   = module.action_group[0].azurerm_monitor_action_group.this
}

moved {
  from = azurerm_storage_account.audit
  to   = module.audit_store.azurerm_storage_account.this
}
