# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

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

variable "role_name" {
  description = "The name of the policy to assign. This is required if role_definition_id is not set."
  type        = string
  default     = null
}

variable "role_definition_id" {
  type        = string
  description = <<DESC
  The Policy Definition ID of the policy to assign. This is required if builtin_role_name is not set.
  NOTE: This is the `role_definition_resource_id` property of the `azurerm_role_definition`, not the `id` or `role_definition_id` property.
  DESC
  default     = null
}

variable "principal_id" {
  description = "The principal ID to assign the role to."
  type        = string
}

variable "scope" {
  description = "The ID of the scope at which the role should be assigned."
  type        = string
}

variable "description" {
  description = "The description of the role assignment."
  type        = string
  default     = ""
}
