# Module scaffolded via skyvafnir-module-template by
# Author: jonorri
# Version: 0.1.0
# Timestamp: 2023-04-29T11:02:35

output "sql_server_id" {
  description = "The id of the datawarehouse"
  value       = azurerm_mssql_server.this.id
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_server_location" {
  description = "Location of the Azure SQL Database created."
  value       = azurerm_mssql_server.this.location
}

output "sql_server_name" {
  description = "Server name of the Azure SQL Database created."
  value       = azurerm_mssql_server.this.name
}

output "sql_server_version" {
  description = "Version the Azure SQL Database created."
  value       = azurerm_mssql_server.this.version
}

output "sql_server_owner" {
  description = "Owner of the Azure SQL Database created."
  value       = var.ad_sql_admin_display_name
}

output "db_info" {
  description = "Information about the created database(s)"
  value       = module.database
}

output "enabled_alerts" {
    description = "List of enabled alerts"
    value       = keys(local.enabled_alerts)
}