# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

resource "mssql_script" "this" {
  database_id = var.mssql_db_info.id

  create_script = <<CREATE_SQL
    -- Create Database Users for Entra identities
    CREATE USER [${var.entra_display_name}] FROM EXTERNAL PROVIDER;
    CREATE_SQL

  read_script = <<READ_SQL
    -- Read Database Users for Entra identities
    SELECT CASE WHEN EXISTS (SELECT 1 FROM sys.database_principals WHERE name = '${var.entra_display_name}') THEN '1' ELSE '0' END AS user_exists;
    READ_SQL

  update_script = <<UPDATE_SQL
    -- Update Database Users for Entra identities
    DROP USER [${var.entra_display_name}];
    CREATE USER [${var.entra_display_name}] FROM EXTERNAL PROVIDER;
    UPDATE_SQL

  delete_script = <<DELETE_SQL
    -- Delete Database Users for Entra identities
    DROP USER [${var.entra_display_name}];
    DELETE_SQL

  state = {
    user_exists = "1" # This is the value that the read_script should return if the user exists.
  }
}
