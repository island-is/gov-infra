# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "name" {
  description = "The name of the SQL Database."
  value       = azurerm_mssql_database.this.name
}

output "id" {
  description = "The ID of the SQL Database."
  value       = azurerm_mssql_database.this.id
}
