# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2024-02-14T13:40:35

output "action_group_id" {
  description = "The ID of the Action Group."
  value       = azurerm_monitor_action_group.this.id
}
