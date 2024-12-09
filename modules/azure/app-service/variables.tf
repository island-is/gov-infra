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
  description = "The name and location of the Resource Group into which the app service should be placed."
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "contributor_principal_ids" {
  description = "A list of principal IDs that should be granted contributor access to the app service."
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The ID of the subnet into which the app service should be placed."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "A map of app settings to be applied to the app service."
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "A map of connection strings to be applied to the app service."
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

variable "app_service_plan_name_override" {
  description = "Override the name of the app service plan. If not set, the name will be generated."
  type        = string
  default     = ""
}

variable "app_service_environment_enabled" {
  description = "Enable the app service environment for the app service."
  type        = bool
  default     = false
}

variable "existing_service_plan_id" {
  description = "The ID of an existing App Service Plan to use for the app service."
  type        = string
  default     = ""
}


variable "os_type" {
  type        = string
  description = "The O/S type for the app servic"
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.os_type)
    error_message = "os_type must be one of 'Linux', 'Windows', or 'WindowsContainer'"
  }
}

variable "sku_name" {
  type        = string
  description = "The SKU name for the app service plan"
  default     = "I1v2"

  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "I4v2", "I5v2", "I6v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "FC1", "WS1", "WS2", "WS3", "Y1"], var.sku_name)
    error_message = "sku_name must be one of: B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, or Y1"
  }
}

variable "worker_count" {
  type        = number
  description = "The number of workers to use for the app service plan"
  default     = 1
}

variable "enable_health_check" {
  type        = bool
  description = "Enable the health check for the app service. If this is set to true, the health_check_path will be used."
  default     = true
}

variable "health_check_path" {
  type        = string
  description = "The path to use for the health check."
  default     = "/live"
}

variable "health_check_eviction_time_in_min" {
  type        = number
  description = "The time in minutes to wait before evicting an unhealthy instance."
  default     = 2
}

variable "ip_restrictions" {
  type = list(object({
    action          = string
    ip_address_cidr = string
    priority        = number
    name            = string
  }))
  description = "IP restrictions"


  validation {
    condition     = alltrue([for restriction in var.ip_restrictions : can(cidrnetmask(restriction.ip_address_cidr))])
    error_message = "Each 'ip_address_cidr' must be a valid CIDR notation."
  }
}

variable "enabled" {
  type        = bool
  description = "Enable the app service"
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access"
  default     = true
}
