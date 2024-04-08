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

variable "description" {
  type        = string
  description = "The description of the alert"
}

variable "scopes" {
  type        = list(string)
  description = "The scopes to assign the role to"
  default     = []
}

variable "target_resource_type" {
  type        = string
  description = <<DESC
  The type of the target resource.
  For example, Microsoft.Compute/virtualMachines"
  DESC
}

variable "severity" {
  type        = number
  description = "The severity of the alert rule"
  default     = 3
  validation {
    condition     = can(regex("^[1-4]$", var.severity))
    error_message = "Severity must be a value between 1 and 4"
  }
}

variable "window_size" {
  type        = string
  description = "The window size of the alert rule, in ISO8601 format"
  default     = "PT5M"
}

variable "frequency" {
  type        = string
  description = "The frequency of the alert rule, in ISO8601 format"
  default     = "PT1M"
}

variable "criteria" {
  type = list(object({
    aggregation       = string
    metric_name       = string
    metric_namespace  = optional(string, "")
    operator          = string
    threshold         = optional(number, null)
    alert_sensitivity = optional(string, "")
  }))
  description = "The criteria for the alert rule"
}

variable "action" {
  type = object({
    action_group_id    = string
    webhook_properties = optional(map(string), {})
  })
  description = "The action for the alert rule"
}

