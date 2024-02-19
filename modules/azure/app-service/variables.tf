# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-17T13:33:48

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

variable "subnet_id" {
  description = "The ID of the subnet into which the app service should be placed."
  type        = string
}

variable "app_settings" {
  description = "A map of app settings to be applied to the app service."
  type        = map(string)
  default     = {}
}

variable "dotnet_version" {
  type        = string
  description = "The version of .NET to use for the web app."
  default     = "8.0"
}

variable "app_service_name_override" {
  description = "Override the name of the app service. If not set, the name will be generated."
  type        = string
  default     = ""
}
