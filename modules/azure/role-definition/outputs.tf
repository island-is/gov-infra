# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2023-08-09T13:38:32

output "role_name" {
  description = "The name of the role."
  value       = azurerm_role_definition.this.name
}

output "role_definition_resource_id" {
  description = "The ID of the role definition resource."
  value       = azurerm_role_definition.this.role_definition_resource_id
}

