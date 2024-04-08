# Module scaffolded via skyvafnir-module-template by
# Author: jonorri
# Version: 0.1.0
# Timestamp: 2023-04-29T10:53:38

variable "org_code" {
  description = "Organization code"
  type        = string
}

variable "instance" {
  description = "Instance name"
  type        = string
}

variable "tier" {
  description = "Tier of the environment"
  type        = string
}

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "existing_resource_group_info" {
  description = "An existing Resource Group to use. If not provided, a new one will be created."
  type = object({
    id       = string
    name     = string
    location = string
  })
  default = null
}

variable "existing_audit_keyvault_id" {
  description = "An existing Keyvault to use for audit logs. If not provided, a new one will be created."
  type        = string
  default     = null
}

variable "features" {
  # Be sure to add any feature flags to the feature flags locals section in main.tf
  description = "Features to enable or disable."
  type = object({
    api_management = optional(bool, true)
    datawarehouse  = optional(bool, true)
    data_factory   = optional(bool, true)
    datalake       = optional(bool, true)
    keyvault       = optional(bool, true)
  })
  default = {
    "api_management" = true
    "datawarehouse"  = true
    "data_factory"   = true
    "datalake"       = true
    "keyvault"       = true
  }
}

variable "platform_config" {
  type = object({
    workload_subscription_id       = string
    platform_subscription_id       = string
    workload_management_group_name = optional(string, "")
  })
  description = <<DESC
  `workload_subscription_id` - The ID of the subscription which we want to provision into.
  `platform_subscription_id` - The ID of the platform subscription.
  `workload_management_group_name (optional)` - The name of the management group which we want to provision our workload subscription into. If this is not set, the placement of the workload subscription inside the management group hieracry will not be changed.
  DESC
}

variable "warehouse_config" {
  type = object({
    sku_name         = string
    max_size_gb      = optional(number, 500)
    zone_redundant   = optional(bool, true)
    admin_group_name = optional(string, "")
    collation        = optional(string, "Icelandic_100_CI_AS")
    ip_whitelist     = optional(list(any), [])
  })
  description = <<DESC
    `sku_name` - The sku-name for the datawarehouse. This controls the sku-name that will be used for the SQL Server Database. sku-names vary across regions and offerings, run `az sql db list-editions -l [your region] -o table` to see available options.
    `max_size_gb` - This controls the max-size-gb setting, i.e. how much storage to allocate for the SQL Server Database.
    `zone_redundant` - Whether the datawarehouse should be zone-redundant. This controls the zone-redundant setting that will be used for the SQL Server Database. Be aware that might not be available for all sku's.
    `admin_group_id (optional)` - The name of an existing AD Group that should be used as an admin to the datawarehouse. If this is not set, a new AD Group will be created.
    `collation (optional)` - The collation to use for the datawarehouse. This controls the collation that will be used for the SQL Server Database.
    `ip_whitelist (optional)` - A list of maps containing ip_address / name pairs to whitelist for the datalakehouse
  DESC
}

variable "api_management_config" {
  type = object({
    sku_name        = optional(string, "Developer")
    sku_capacity    = optional(number, 1)
    publisher_name  = optional(string, "<your name>")
    publisher_email = optional(string, "")
  })
  default     = null
  description = <<DESC
  `sku_name` - SKU name for the API management instance
  `sku_capacity` - SKU capacity for the API management instance
  `publisher_name` - Publisher name for the API management instance
  `publisher_email` - Publisher email for the API management instance
  DESC
}

variable "adf_git_backend_config" {
  description = "Configuration for the github repository"
  type = object({
    type = string # must be either "github" or "azuredevops"

    account_name    = string
    branch_name     = string
    repository_name = string
    root_folder     = string

    # Required for Github
    git_url = optional(string)

    # Required for Azure DevOps
    project_name = optional(string)
    tenant_id    = optional(string)
  })

  default = null
}

variable "budget_for_resource_group" {
  description = "Budget for the resource group"
  type        = number
  default     = 50
}

variable "budget_contact_emails" {
  description = "Emails to send budget notifications to"
  type        = list(string)
}

variable "keyvault_ip_whitelist" {
  description = "IP addresses to whitelist for the keyvault"
  type        = list(string)
  default     = []
}

variable "datalakehouse_contributors" {
  type        = list(string)
  description = "Contributors to the datalakehouse"
  default     = []
}

variable "datalakehouse_admins" {
  type        = list(string)
  description = <<DESC
  A list of Azure AD User Principal ID's that are allowed to administer the Data Lakehouse.
  DESC
  default     = []
}

variable "datalake_whitelisted_cidrs" {
  type        = list(string)
  description = "A list of CIDRs to whitelist for the datalake"
  default     = []
}

variable "datalakehouse_contributor_group_name" {
  type        = string
  description = <<DESC
  The name of an existing AD Group that should be used as a contributor to the datalakehouse.
  If this is not set, a new AD Group will be created.
  DESC
  default     = ""
}

variable "datalakehouse_contributor_can_contribute_to_keyvault" {
  type        = bool
  description = "Whether the data engineers should be able to contribute to the key vault."
  default     = false
}

variable "name_overrides" {
  type        = map(string)
  description = <<DESC
  Map of resource names to override. If not set, the name will be generated from the instance name.
  This variable is an escape hatch for some naming scheme conflicts that can occur and should, ideally, not be used.
  The schema for this variable is defined inside resource and service modules and is not documented here.
  DESC
  default     = {}
}

variable "alert_on_pipeline_failure" {
  type        = bool
  description = "Whether to alert on pipeline failure"
  default     = false
}
variable "alert_contact_emails" {
  type        = list(string)
  description = "A list of emails to send alerts to on pipeline failure"
  default     = []
}
