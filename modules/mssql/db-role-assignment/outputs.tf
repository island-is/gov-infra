# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "role_name" {
  description = "The role created by this module and its members"
  value       = var.mssql_role_name != null ? data.mssql_database_role.this[0].name : null
}

output "member" {
  description = "The member"
  value       = data.mssql_sql_user.this.name
}

output "db_name" {
  description = "The database name"
  value       = var.mssql_db_info.name
}
