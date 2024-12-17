# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
  upper            = true
  lower            = true
}

resource "mssql_sql_login" "this" {
  name     = var.username
  password = random_password.this.result

  default_database_id       = var.mssql_db_info.id
  default_language          = var.default_language
  check_password_expiration = var.enforce_pw_expiry
  check_password_policy     = var.enforce_pw_policy
}

