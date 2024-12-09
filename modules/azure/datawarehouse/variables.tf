# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "org_code" {
  description = "The organisation code for the environment"
  type        = string
}

variable "tier" {
  description = "Tier of the environment"
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
  type = object({
    id       = string
    name     = string
    location = string
  })
  description = "The id, name and location of the Resource Group into which the Data Warehouse should be placed."
}

variable "mssql_version" {
  description = "Version of MSSQL to use"
  type        = string
  default     = "12.0"
}

variable "ad_sql_admin_id" {
  description = "ID of the Azure AD Principal to use as the SQL admin"
  type        = string
}

variable "ad_sql_admin_display_name" {
  description = "The Display Name of the Azure AD Principal to use as the SQL admin"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault to use for storing secrets"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
  default     = ""
}

variable "warehouse_ip_whitelist" {
  type = list(
    object({
      ip_address = string
      name       = string
    })
  )
  description = "A list of IP Addresses / Name pairs to whitelist for the datalakehouse"
  default     = []
}

variable "datawarehouse_contributor_principal_ids" {
  type        = map(string)
  description = <<DESC
  A map of Azure Entra Principal IDs that should be granted contributor access to the Data Warehouse.
  Each key should be a semi-unique identifier (eg. a Group Name or purpose) for the Principal and the value should be the Principal ID.
  DESC
  default     = {}
}

variable "databases" {
  description = <<DESC
  A map of SQL databases (keyed by instance/db-name) to provision in the Data Warehouse (SQL Server),
  - sku_name: The SKU name to use for the MS SQL Database. The SKU name determines the performance tier (and thus the price) of the database.
              See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu
  - max_size_gb: The maximum size of the MS SQL Database in GB.
                 Keep in mind that the maximum size of a database varies between SKUs.
                 See: https://learn.microsoft.com/en-us/azure/azure-sql/database/resource-limits-logical-server?view=azuresql-db
  - min_capacity: The minimum capacity of the MS SQL Database in DTUs. This is only applicable Serverless dbs.
  - collation: The collation to use for the MS SQL Database.
  - zone_redundant: Whether the MS SQL Database should be zone redundant. Only available for Standard and Premium SKUs.
                    See: https://docs.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla#zone-redundant-database
  - name_override: Override the name of the database. If not set, the name will be generated according to the following pattern:
                   <org_code>-<resource-abbreviation>-<name>-<tier>
  - contributor_principal_ids: The Principal ID of an existing AD Principal (User, Group, Service Principal etc.) that should be granted contributor access to the database in question.
  - auto_pause_delay_minutes: The number of minutes of inactivity before the database is automatically paused. A value of -1 indicates that the database will never be paused.
                              NOTE: This can only be supplied for "Serverless" databases.
  Example:
  ```
     "db_name" = {
         sku_name       = var.warehouse_config.sku_name
         zone_redundant = var.warehouse_config.zone_redundant
         max_size_gb    = var.warehouse_config.max_size_gb
         collation      = "Icelandic_100_CI_AS"
         name_override  = null
         contributor_principal_ids = ["<principal-id1>", "<principal-id2>", [...] ]

         # only applies to Serverless databases
         min_capacity   = 0.5
     }
  ```
  DESC
  type = map(
    object({
      sku_name                  = string
      max_size_gb               = number
      min_capacity              = optional(number, 0)
      collation                 = optional(string, "Icelandic_100_CI_AS")
      zone_redundant            = optional(bool, false)
      name_override             = optional(string, null)
      contributor_principal_ids = optional(list(string), [])
      auto_pause_delay_minutes  = optional(number, null)
    })
  )
  default = {}
}

variable "sql_server_name_override" {
  type        = string
  description = "Override the name of the SQL Server. If not set, the name will be generated according to the following pattern: <org_code>-<resource-abbreviation>-<name>-<tier>"
  default     = null
}

variable "allow_sql_login" {
  type        = bool
  description = <<DESC
  Setting this to true will allow SQL authentication as well as Azure Entra authentication.
  DESC
  default     = false
}

variable "keyvault_key_name_override" {
  type        = string
  description = "Override the name of the keyvault key to use for encryption"
  default     = null
}

variable "audit_storage_account_name_override" {
  type        = string
  description = "Override the name of the storage account to use for audit logs"
  default     = null
}

variable "enable_db_monitor_alerts" {
  type        = bool
  description = <<DESC
  Create metric alert rules for the databases in the datawarehouse.
  Currently supported alerts are:
  high_user_cpu_usage              = "Alerts when the average CPU usage by the user code exceeds 90%."
  high_total_cpu_usage             = "Triggers an alert when the average total CPU usage of the SQL instance exceeds 90%."
  high_worker_usage                = "Activates when the minimum percentage of SQL workers in use is greater than 60%."
  high_data_io_usage               = "Alerts if the average physical data read percentage goes above 90%."
  storage_percent                  = "Issues an alert when the minimum storage usage exceeds 95%."
  low_tempdb_log_space             = "Raises an alert when the minimum percentage of used tempdb log space is greater than 60%."
  failed_connections_system_errors = "Alerts on more than 10 failed connections due to system errors."
  deadlocks                        = "Monitors and alerts on deadlock occurrences in the database."
  failed_connections_user_errors   = "Alerts on failed connections due to user errors, if they exceed a threshold."
  anomalous_connection_rate        = "Alerts on unusual rates of successful connections, indicating potential anomalies."
  DESC
  default     = true
}

variable "monitor_alert_emails" {
  type        = list(string)
  description = "Email addresses to send Azure Monitor alerts to."
  default     = []
}

variable "disabled_monitor_alerts" {
  type        = list(string)
  description = <<DESC
  A list of Azure Monitor Alert rules that should be disabled.

  EXAMPLE: To disable the `high_user_cpu_usage` and `high_total_cpu_usage` alerts, set this variable as follows:
  `disabled_monitor_alerts = ["high_user_cpu_usage", "high_total_cpu_usage"]`
  DESC
  default     = []
}

variable "warehouse_subnet_whitelist" {
  type        = string
  description = "Subnet Id that should be able to access the warehouse"
  default     = null
}

variable "allow_access_from_azure_services" {
  type        = bool
  description = <<DESC
  Allow access to Azure services. This is done by setting start_ip_address and end_ip_address to 0.0.0.0.
  This rule only applies to Azure internal IPs, as documented in the Azure API Documentation:
  - https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update?view=rest-sql-2021-11-01&tabs=HTTP
  - https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#allow-access-to-azure-services
  DESC
  default     = false
}

