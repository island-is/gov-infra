# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2023-08-09T13:38:32

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

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "scope" {
  description = <<DESC
  The Scope to which the Role Definition applies.
  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/scope-overview
  DESC
  type        = string
}

variable "description" {
  description = "The Description of the Role Definition."
  type        = string
  default     = ""
}

variable "assignable_scopes" {
  description = <<DESC
  One or more assignable scopes for this Role Definition.
  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions#assignablescopes
  DESC
  type        = list(string)
  default     = []
}

variable "permissions" {
  description = "One or more Permissions for this Role Definition."
  type = object({
    actions          = optional(list(string))
    not_actions      = optional(list(string))
    data_actions     = optional(list(string))
    not_data_actions = optional(list(string))
  })
  default = {
    actions = [
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Web/ServerFarms/write",
      "Microsoft.Web/Sites/write",
      "Microsoft.Logic/workflows/read",
      "Microsoft.Logic/workflows/write",
      "Microsoft.Logic/workflows/delete",
    ]
  }
}
