# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2023-12-19T16:11:02

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

variable "resource_group_name_override" {
  type        = string
  description = "Override the resource group name"
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "The tenant id of the Azure AD tenant used for authentication"
}

variable "sql_monitor_alert_emails" {
  type        = list(string)
  description = "Emails to send SQL alerts to"
}

variable "app_service_configuration" {
  type        = map(string)
  description = "Configuration for the app service"
  default     = {}
}

variable "secret_app_service_configuration" {
  type        = map(string)
  description = "Configuration for the app service"
  default     = {}
}

variable "warehouse_ip_whitelist" {
  type = list(
    object({
      ip_address = string
      name       = string
    })
  )
  description = "A list of IP Addresses / Name pairs to whitelist for the data warehouse"
  default     = []
}

variable "keyvault_admin_principal_ids" {
  type        = list(string)
  description = "List of EntraID Principal ID's that will be granted admin access to the Key Vault."
  default     = null
}

variable "databases" {
  description = "Map of databases to create"
  type = map(object({
    sku_name    = string
    max_size_gb = number
  }))
}

variable "public_ip_name_override" {
  type        = string
  description = "Override the public IP name"
  default     = ""
}

variable "app_service_name_override" {
  type        = string
  description = "Override the app service name"
  default     = ""
}

variable "vnet_name_override" {
  type        = string
  description = "Override the vnet name"
  default     = ""
}

variable "sql_admin_group_owner_principal_ids" {
  type        = list(string)
  description = "List of EntraID Principal ID's that will be granted owner access to the SQL Server."
}

variable "db_server_audit_storage_account_name_override" {
  type        = string
  description = "Override the storage account name for the database server audit"
  default     = ""
}
