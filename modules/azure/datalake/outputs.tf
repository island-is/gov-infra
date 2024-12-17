# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "datalake_name" {
  description = "The name of the Data Lake"
  value       = azurerm_storage_account.this.name
}

output "datalake_id" {
  description = "The ID of the Data Lake"
  value       = azurerm_storage_account.this.id
}

output "datalake_location" {
  description = "The location of the Data Lake"
  value       = azurerm_storage_account.this.location
}

