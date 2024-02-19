# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2023-12-14T13:28:23

output "name" {
  description = "The name of the SQL Database."
  value       = azurerm_mssql_database.this.name
}

output "id" {
  description = "The ID of the SQL Database."
  value       = azurerm_mssql_database.this.id
}