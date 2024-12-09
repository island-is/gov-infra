# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "username" {
  description = "A the user created by this module"
  value       = var.entra_display_name
}

output "db_info" {
  description = "Information about the databases in which the user has been created."
  value       = var.mssql_db_info
}
