# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "action_group_id" {
  description = "The ID of the Action Group."
  value       = azurerm_monitor_action_group.this.id
}
