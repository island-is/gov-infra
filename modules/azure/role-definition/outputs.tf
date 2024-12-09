# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "role_name" {
  description = "The name of the role."
  value       = azurerm_role_definition.this.name
}

output "role_definition_resource_id" {
  description = "The ID of the role definition resource."
  value       = azurerm_role_definition.this.role_definition_resource_id
}

