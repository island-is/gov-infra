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

variable "sku" {
  description = "The SKU of the Databricks workspace to create"
  type        = string
}
