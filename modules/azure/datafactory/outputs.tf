# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "service_principal_object_id" {
  description = "The Service Principal / Object ID that the Data Factory runs as."
  value       = azurerm_data_factory.this.identity[0].principal_id
}

output "id" {
  description = "The ID of the data factory."
  value       = azurerm_data_factory.this.id
}

output "name" {
  description = "The name of the data factory."
  value       = azurerm_data_factory.this.name
}

output "identity" {
  description = "The name of the data factory."
  value       = azurerm_data_factory.this.identity
}

output "group_name" {
  description = "The name of the Entra group to which the datafactory belongs."
  value       = var.group_config != null ? module.datafactory_group[0].group_display_name : ""
}

output "group_id" {
  description = "The ID the Entra group to which the datafactory belongs."
  value       = var.group_config != null ? module.datafactory_group[0].group_id : ""
}
