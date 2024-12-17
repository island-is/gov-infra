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

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "server_id" {
  type        = string
  description = "The ID of the SQL server to which the database belongs"
}

variable "max_size_gb" {
  type        = number
  description = <<DESC
  The maximum size of the MS SQL Database in GB.
  Keep in mind that the maximum size of a database varies between SKUs.
  See: https://learn.microsoft.com/en-us/azure/azure-sql/database/resource-limits-logical-server?view=azuresql-db
  DESC
}

variable "min_capacity" {
  default     = null
  type        = number
  description = <<DESC
  The minimum capacity of the MS SQL Database in DTUs. This is only applicable Serverless dbs.
  See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu
  DESC
}

variable "sku_name" {
  type        = string
  description = <<DESC
  The SKU name to use for the MS SQL Database. The SKU name determines the performance tier (and thus the price) of the database.
  See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu
  DESC
}

variable "collation" {
  type        = string
  description = "The collation to use for the MS SQL Database."
  default     = "Icelandic_100_CI_AS"
}

variable "zone_redundant" {
  type        = bool
  description = "Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones"
  default     = false
}

variable "name_override" {
  type        = string
  description = "Override the name of the database. If not set, the name will be generated from the var.instance variable"
  default     = null
}

variable "contributor_principal_ids" {
  type        = list(string)
  description = "List of principal IDs to assign the SQL DB Contributor role to."
  default     = []
}

variable "auto_pause_delay_minutes" {
  type        = number
  description = <<DESC
  The number of minutes of idle time before the database is automatically paused. The minimum is 60 minutes and the maximum is 10080 minutes (7 days).
  If not specified, the database is never paused.
  This setting is only available for Serverless SKU's.
  DESC
  default     = null
}
