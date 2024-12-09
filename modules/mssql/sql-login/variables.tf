# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "mssql_db_info" {
  type = object({
    id   = optional(string, null)
    name = optional(string, null)
  })
  description = "The name and MSSQL Provider ID of the MSSQL database"
  default = {
    id   = null
    name = null
  }
}

variable "username" {
  type        = string
  description = <<DESC
  Username for the database user.
  DESC
}


# Optional variables
variable "default_language" {
  type        = string
  description = "The default language for the database. Defaults to the current default language of the server."
  default     = null
}
variable "enforce_pw_expiry" {
  type        = bool
  description = "Whether to enforce password expiry on the database."
  default     = false
}

variable "enforce_pw_policy" {
  type        = bool
  description = "Whether to enforce password policy on the database."
  default     = false
}

