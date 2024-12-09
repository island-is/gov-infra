# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

data "mssql_sql_user" "this" {
  name        = var.mssql_principal_name
  database_id = var.mssql_db_info.id
}

data "mssql_database_role" "this" {
  count       = var.mssql_role_name != null ? 1 : 0
  name        = var.mssql_role_name
  database_id = var.mssql_db_info.id
}

locals {
  mssql_role_id = var.mssql_role_name != null ? data.mssql_database_role.this[0].id : var.mssql_role_id
}

resource "mssql_database_role_member" "this" {
  role_id   = local.mssql_role_id
  member_id = data.mssql_sql_user.this.id
}
