# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "entra_display_name" {
  type        = string
  description = "The display names of the Entra identity"
}

variable "mssql_db_info" {
  type = object({
    id   = string
    name = string
  })
  description = "The name and MSSQL Provider ID of the MSSQL database"
}
