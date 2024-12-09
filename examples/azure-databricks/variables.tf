# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

#


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

variable "budget_contact_emails" {
  type        = list(string)
  description = "Emails to notify when the budget is forecasted to be broken"
}

variable "databricks_users" {
  description = "List of users to add to the databricks workspace"
  type = list(object({
    user_name    = string
    display_name = string
  }))

  validation {
    # Ensure user_name is unique
    condition = length(var.databricks_users) == length(distinct([
      for user in var.databricks_users : user.user_name
    ]))
    error_message = "User names must be unique"
  }
}

variable "databricks_sku_name" {
  type        = string
  description = <<DESC
  The sku-name for the databricks workspace. This controls the sku-name that will be used for the databricks workspace.
  sku-names vary across regions and offerings, run `az databricks workspace list-skus -l [your region] -o table` to see available options.
  DESC
  default     = "standard"
}
