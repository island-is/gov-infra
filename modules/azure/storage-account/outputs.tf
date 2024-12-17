# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "storage_account_name" {
  description = "The ID of the resource group"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_container_name" {
  description = "The name of the storage container - if provisioned"
  value       = var.storage_container_config != null ? azurerm_storage_container.this[0].name : ""
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint for the storage account"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The secondary blob endpoint for the storage account"
  value       = azurerm_storage_account.this.secondary_blob_endpoint
}

output "identity" {
  description = "The identity of the storage account"
  value       = azurerm_storage_account.this.identity
}

output "primary_access_key" {
  description = "The primary access key of the storage account"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key of the storage account"
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}
