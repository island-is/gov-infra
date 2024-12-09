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

variable "group_purpose" {
  description = "Purpose of the group, i.e. user / admin / job / service. This goes into constructing the name of the group"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "group_owner_principal_ids" {
  description = <<DESC
  List of owners of the group.
  If empty, the group will be owned by the provisioning identity.
  DESC
  type        = list(string)
}

variable "group_member_principal_ids" {
  description = "List of members of the group (optional)"
  type        = list(string)
  default     = []
}

variable "group_description" {
  description = "Description of the group"
  type        = string
  default     = ""
}

variable "existing_group_name" {
  type        = string
  description = <<DESC
  The name of an existing group. If set, the module will not create a new group,
  but will instead use the existing group as a data source.
  DESC
  default     = ""
}
