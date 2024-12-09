# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
output "key_vault_id" {
  description = "ID of the KeyVault"
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Name of the KeyVault"
  value       = azurerm_key_vault.this.name
}
