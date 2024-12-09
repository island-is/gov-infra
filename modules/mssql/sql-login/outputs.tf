# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
output "login_username" {
  description = "Login username for SQL Login"
  value       = mssql_sql_login.this.name
}

output "login_password" {
  description = "Login credentials for The SQL Login"
  value       = mssql_sql_login.this.password
  sensitive   = true
}

output "login_id" {
  description = "ID of the SQL Login"
  value       = mssql_sql_login.this.id
}

output "principal_id" {
  description = "Principal ID of the SQL Login"
  value       = mssql_sql_login.this.principal_id
}
