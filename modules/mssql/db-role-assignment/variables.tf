# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "mssql_db_info" {
  type = object({
    name = string
    id   = optional(string, "")
  })
  description = "The name and MSSQL Provider ID of the MSSQL database"
}

variable "mssql_role_name" {
  type        = string
  description = <<DESC
  The name of the role to assign to the principal.
  Use either this or `var.mssql_role_id`
  DESC
  default     = null
}

variable "mssql_role_id" {
  type        = string
  description = <<DESC
  The MSSQL Provider ID (`<database_id>/<role_id>`) of the role to assign to the principal.
  Use either this or `var.mssql_role_name`
  DESC
  default     = null
}

variable "mssql_principal_name" {
  type        = string
  description = "The name of the principal to which the role will be assigned."
}
