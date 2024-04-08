variable "org_code" {
  type        = string
  description = "Name of the organization"
}

variable "tier" {
  type        = string
  description = "Tier of the environment"
}

variable "instance" {
  type        = string
  description = "What is this resource for? (e.g. 'bastion', 'app', 'db')"
}

variable "existing_resource_group_info" {
  type = object({
    id       = string
    name     = string
    location = string
  })
  description = "Information about an existing resource group to use instead of creating a new one"
  default     = null
}
variable "lock" {
  type        = bool
  description = "Whether to protect resources from accidental deletion"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  default     = {}
}

variable "location" {
  type        = string
  description = "Azure region to deploy to"
  default     = "northeurope"
}

variable "budget_for_resource_group" {
  type        = number
  description = <<DESC
  Budget for the whole resource group. The currency is determined by the subscription's billing currency.
  DESC
  default     = 0
}

variable "budget_contact_emails" {
  type        = list(string)
  description = "Emails to notify when the budget is forecasted to be broken"
  default     = null
}

variable "role_assignments" {
  # TODO: Probably move this check to the role-assignment module
  type = list(object({
    principal_id       = string
    role_definition_id = optional(string)
    role_name          = optional(string)
  }))
  description = "Role assignments to be applied to the resource group"
  default     = null
  nullable    = true

  validation {
    # Ensure that either role_definition_id or role_name is set - but not both
    condition = var.role_assignments == null ? true : sum([for r in var.role_assignments : try(r.role_definition_id, r.role_name, null) != null ? 1 : 0]) < 2

    error_message = "Either role_definition_id or role_name must be set for each role assignment."
  }
}