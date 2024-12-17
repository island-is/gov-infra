# datawarehouse

## Metric Alerts

This module implements the following metric alerts,
as [recommended by Microsoft](https://learn.microsoft.com/en-us/azure/azure-sql/database/monitoring-metrics-alerts?view=azuresql-db&preserve-view=true#recommended-alert-rules):

| Alert Name                         | Metric                         | Description                                                                               | Aggregation | Operator          | Threshold            | Severity      |
| ---------------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------- | ----------- | ----------------- | -------------------- | ------------- |
| High User CPU Usage                | `cpu_percent`                  | Alerts when the average CPU usage by the user code exceeds 90%.                           | Average     | GreaterThan       | 90                   | Warning       |
| High Total CPU Usage               | `sql_instance_cpu_percent`     | Triggers an alert when the average total CPU usage of the SQL instance exceeds 90%.       | Average     | GreaterThan       | 90                   | Warning       |
| High Worker Usage                  | `workers_percent`              | Activates when the minimum percentage of SQL workers in use is greater than 60%.          | Minimum     | GreaterThan       | 60                   | Error         |
| High Data IO Usage                 | `physical_data_read_percent`   | Alerts if the average physical data read percentage goes above 90%.                       | Average     | GreaterThan       | 90                   | Informational |
| Storage Percent                    | `storage_percent`              | Issues an alert when the minimum storage usage exceeds 95%.                               | Minimum     | GreaterThan       | 95                   | Error         |
| Low TempDB Log Space               | `tempdb_log_used_percent`      | Raises an alert when the minimum percentage of used tempdb log space is greater than 60%. | Minimum     | GreaterThan       | 60                   | Error         |
| Failed Connections - System Errors | `connection_failed`            | Alerts on more than 10 failed connections due to system errors.                           | Total       | GreaterThan       | 10                   | Warning       |
| Deadlocks                          | `deadlock`                     | Monitors and alerts on deadlock occurrences in the database.                              | Total       | GreaterThan       | (Medium Sensitivity) | Informational |
| Failed Connections - User Errors   | `connection_failed_user_error` | Alerts on failed connections due to user errors, if they exceed a threshold.              | Total       | GreaterThan       | (Medium Sensitivity) | Warning       |
| Anomalous Connection Rate          | `connection_successful`        | Alerts on unusual rates of successful connections, indicating potential anomalies.        | Total       | GreaterOrLessThan | (Low Sensitivity)    | Warning       |

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_sql_admin_display_name"></a> [ad\_sql\_admin\_display\_name](#input\_ad\_sql\_admin\_display\_name) | The Display Name of the Azure AD Principal to use as the SQL admin | `string` | n/a | yes |
| <a name="input_ad_sql_admin_id"></a> [ad\_sql\_admin\_id](#input\_ad\_sql\_admin\_id) | ID of the Azure AD Principal to use as the SQL admin | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | ID of the Key Vault to use for storing secrets | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | The organisation code for the environment | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The id, name and location of the Resource Group into which the Data Warehouse should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_allow_access_from_azure_services"></a> [allow\_access\_from\_azure\_services](#input\_allow\_access\_from\_azure\_services) | Allow access to Azure services. This is done by setting start\_ip\_address and end\_ip\_address to 0.0.0.0.<br>  This rule only applies to Azure internal IPs, as documented in the Azure API Documentation:<br>  - https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update?view=rest-sql-2021-11-01&tabs=HTTP<br>  - https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-configure#allow-access-to-azure-services | `bool` | `false` | no |
| <a name="input_allow_sql_login"></a> [allow\_sql\_login](#input\_allow\_sql\_login) | Setting this to true will allow SQL authentication as well as Azure Entra authentication. | `bool` | `false` | no |
| <a name="input_audit_storage_account_name_override"></a> [audit\_storage\_account\_name\_override](#input\_audit\_storage\_account\_name\_override) | Override the name of the storage account to use for audit logs | `string` | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | A map of SQL databases (keyed by instance/db-name) to provision in the Data Warehouse (SQL Server),<br>  - sku\_name: The SKU name to use for the MS SQL Database. The SKU name determines the performance tier (and thus the price) of the database.<br>              See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu<br>  - max\_size\_gb: The maximum size of the MS SQL Database in GB.<br>                 Keep in mind that the maximum size of a database varies between SKUs.<br>                 See: https://learn.microsoft.com/en-us/azure/azure-sql/database/resource-limits-logical-server?view=azuresql-db<br>  - collation: The collation to use for the MS SQL Database.<br>  - zone\_redundant: Whether the MS SQL Database should be zone redundant. Only available for Standard and Premium SKUs.<br>                    See: https://docs.microsoft.com/en-us/azure/azure-sql/database/high-availability-sla#zone-redundant-database<br>  - name\_override: Override the name of the database. If not set, the name will be generated according to the following pattern:<br>                   <org\_code>-<resource-abbreviation>-<name>-<tier><br>  - contributor\_principal\_ids: The Principal ID of an existing AD Principal (User, Group, Service Principal etc.) that should be granted contributor access to the database in question.<br>  - auto\_pause\_delay\_minutes: The number of minutes of inactivity before the database is automatically paused. A value of -1 indicates that the database will never be paused.<br>                              NOTE: This can only be supplied for "Serverless" databases.<br>  Example:<pre>"db_name" = {<br>         sku_name       = var.warehouse_config.sku_name<br>         zone_redundant = var.warehouse_config.zone_redundant<br>         max_size_gb    = var.warehouse_config.max_size_gb<br>         collation      = "Icelandic_100_CI_AS"<br>         name_override  = null<br>         contributor_principal_ids = ["<principal-id1>", "<principal-id2>", [...] ]<br>     }</pre> | <pre>map(<br>    object({<br>      sku_name                  = string<br>      max_size_gb               = number<br>      collation                 = optional(string, "Icelandic_100_CI_AS")<br>      zone_redundant            = optional(bool, false)<br>      name_override             = optional(string, null)<br>      contributor_principal_ids = optional(list(string), [])<br>      auto_pause_delay_minutes  = optional(number, null)<br>    })<br>  )</pre> | `{}` | no |
| <a name="input_datawarehouse_contributor_principal_ids"></a> [datawarehouse\_contributor\_principal\_ids](#input\_datawarehouse\_contributor\_principal\_ids) | A map of Azure Entra Principal IDs that should be granted contributor access to the Data Warehouse.<br>  Each key should be a semi-unique identifier (eg. a Group Name or purpose) for the Principal and the value should be the Principal ID. | `map(string)` | `{}` | no |
| <a name="input_disabled_monitor_alerts"></a> [disabled\_monitor\_alerts](#input\_disabled\_monitor\_alerts) | A list of Azure Monitor Alert rules that should be disabled.<br><br>  EXAMPLE: To disable the `high_user_cpu_usage` and `high_total_cpu_usage` alerts, set this variable as follows:<br>  `disabled_monitor_alerts = ["high_user_cpu_usage", "high_total_cpu_usage"]` | `list(string)` | `[]` | no |
| <a name="input_enable_db_monitor_alerts"></a> [enable\_db\_monitor\_alerts](#input\_enable\_db\_monitor\_alerts) | Create metric alert rules for the databases in the datawarehouse.<br>  Currently supported alerts are:<br>  high\_user\_cpu\_usage              = "Alerts when the average CPU usage by the user code exceeds 90%."<br>  high\_total\_cpu\_usage             = "Triggers an alert when the average total CPU usage of the SQL instance exceeds 90%."<br>  high\_worker\_usage                = "Activates when the minimum percentage of SQL workers in use is greater than 60%."<br>  high\_data\_io\_usage               = "Alerts if the average physical data read percentage goes above 90%."<br>  storage\_percent                  = "Issues an alert when the minimum storage usage exceeds 95%."<br>  low\_tempdb\_log\_space             = "Raises an alert when the minimum percentage of used tempdb log space is greater than 60%."<br>  failed\_connections\_system\_errors = "Alerts on more than 10 failed connections due to system errors."<br>  deadlocks                        = "Monitors and alerts on deadlock occurrences in the database."<br>  failed\_connections\_user\_errors   = "Alerts on failed connections due to user errors, if they exceed a threshold."<br>  anomalous\_connection\_rate        = "Alerts on unusual rates of successful connections, indicating potential anomalies." | `bool` | `true` | no |
| <a name="input_keyvault_key_name_override"></a> [keyvault\_key\_name\_override](#input\_keyvault\_key\_name\_override) | Override the name of the keyvault key to use for encryption | `string` | `null` | no |
| <a name="input_monitor_alert_emails"></a> [monitor\_alert\_emails](#input\_monitor\_alert\_emails) | Email addresses to send Azure Monitor alerts to. | `list(string)` | `[]` | no |
| <a name="input_mssql_version"></a> [mssql\_version](#input\_mssql\_version) | Version of MSSQL to use | `string` | `"12.0"` | no |
| <a name="input_sql_server_name_override"></a> [sql\_server\_name\_override](#input\_sql\_server\_name\_override) | Override the name of the SQL Server. If not set, the name will be generated according to the following pattern: <org\_code>-<resource-abbreviation>-<name>-<tier> | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure tenant ID | `string` | `""` | no |
| <a name="input_warehouse_ip_whitelist"></a> [warehouse\_ip\_whitelist](#input\_warehouse\_ip\_whitelist) | A list of IP Addresses / Name pairs to whitelist for the datalakehouse | <pre>list(<br>    object({<br>      ip_address = string<br>      name       = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_warehouse_subnet_whitelist"></a> [warehouse\_subnet\_whitelist](#input\_warehouse\_subnet\_whitelist) | Subnet Id that should be able to access the warehouse | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_info"></a> [db\_info](#output\_db\_info) | Information about the created database(s) |
| <a name="output_enabled_alerts"></a> [enabled\_alerts](#output\_enabled\_alerts) | List of enabled alerts |
| <a name="output_sql_server_fqdn"></a> [sql\_server\_fqdn](#output\_sql\_server\_fqdn) | Fully Qualified Domain Name (FQDN) of the Azure SQL Database created. |
| <a name="output_sql_server_id"></a> [sql\_server\_id](#output\_sql\_server\_id) | The id of the datawarehouse |
| <a name="output_sql_server_location"></a> [sql\_server\_location](#output\_sql\_server\_location) | Location of the Azure SQL Database created. |
| <a name="output_sql_server_name"></a> [sql\_server\_name](#output\_sql\_server\_name) | Server name of the Azure SQL Database created. |
| <a name="output_sql_server_owner"></a> [sql\_server\_owner](#output\_sql\_server\_owner) | Owner of the Azure SQL Database created. |
| <a name="output_sql_server_version"></a> [sql\_server\_version](#output\_sql\_server\_version) | Version the Azure SQL Database created. |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.audit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_mssql_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_firewall_rule.whitelist](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_virtual_network_rule.allow_subnet_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azurerm_role_assignment.audit_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account_customer_managed_key.audit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_action_group"></a> [action\_group](#module\_action\_group) | ../monitor-action-group | n/a |
| <a name="module_audit_store"></a> [audit\_store](#module\_audit\_store) | ../storage-account | n/a |
| <a name="module_database"></a> [database](#module\_database) | ../mssql-database | n/a |
| <a name="module_db_alerts"></a> [db\_alerts](#module\_db\_alerts) | ../monitor-metric-alert | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |
| <a name="module_server_contributor_access"></a> [server\_contributor\_access](#module\_server\_contributor\_access) | ../role-assignment | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.103.1 |

<!-- /TERRAFORM_DOCS_BLOCK -->
