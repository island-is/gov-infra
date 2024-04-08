# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2024-02-14T13:40:35

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

variable "resource_group_info" {
  description = "The name and location of the Resource Group into which the app service should be placed."
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "group_purpose" {
  description = <<DESC
    The purpose of the resource group. This goes into the resource name.
    Should be succinct, descriptive and self-explanatory.
    Examples: `pipeline_fail`, `budget_alarms` etc.
    DESC
  type        = string
}

variable "short_name" {
  description = <<DESC
  Short name for the Action Group. Must not exceed 9 characters.
  This string, together with the org_code, forms the "short_name" of the Action Group.
  DESC
  type        = string
  validation {
    condition     = length(var.short_name) <= 9
    error_message = "Short name must not exceed 9 characters."

  }
}

variable "email_receivers" {
  type        = list(string)
  description = "Email addresses to send alerts to"
  default     = []
}

variable "arm_receiver_role_ids" {
  type        = map(string)
  description = "A map of ARM receiver role ids, keyed by role name, to be added to the action group"
  default     = {}
}
