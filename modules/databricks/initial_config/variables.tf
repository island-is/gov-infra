# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-04T10:40:16

variable "org_code" {
  description = "Org code"
  type        = string
}

variable "tier" {
  description = "The tier of the environment (e.g. test, prod)"
  type        = string
}

variable "instance" {
  description = "Identifier for the application, workload or service"
  type        = string
}

variable "users" {
  description = "List of users to add to the workspace"
  type = list(object({
    user_name    = string
    display_name = string
  }))
}
