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

variable "resource_group_info" {
  description = "Name and Location of the Resource Group"
  type = object({
    name     = string
    location = string
  })
}

variable "publisher_name" {
  description = "Publisher name"
  type        = string
}

variable "publisher_email" {
  description = "Publisher email"
  type        = string
}

variable "sku_name" {
  description = "SKU for API management"
  default     = "Developer"
  type        = string
}

variable "sku_capacity" {
  description = "SKU capacity for API management"
  type        = string
}

variable "api_contributor_group_id" {
  type        = string
  description = "The ID of the group that should be given contributor access to the API Management instance"
}

variable "name_override" {
  type        = string
  description = "Override the name of the API Management service. If not provided, the name will be generated."
  default     = null
}
