# azure-networked-appservice

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | Map of databases to create | <pre>map(object({<br>    sku_name      = string<br>    max_size_gb   = number<br>    name_override = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_service_contributor_principal_ids"></a> [service\_contributor\_principal\_ids](#input\_service\_contributor\_principal\_ids) | List of EntraID Principal ID's that will be granted contributor access to the Azure Services. | `list(string)` | n/a | yes |
| <a name="input_sql_admin_group_owner_principal_ids"></a> [sql\_admin\_group\_owner\_principal\_ids](#input\_sql\_admin\_group\_owner\_principal\_ids) | List of EntraID Principal ID's that will be granted owner access to the SQL Server. | `list(string)` | n/a | yes |
| <a name="input_sql_monitor_alert_emails"></a> [sql\_monitor\_alert\_emails](#input\_sql\_monitor\_alert\_emails) | Emails to send SQL alerts to | `list(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant id of the Azure AD tenant used for authentication | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_app_service_configuration"></a> [app\_service\_configuration](#input\_app\_service\_configuration) | Configuration for the app service | `map(string)` | `{}` | no |
| <a name="input_app_service_environment_enabled"></a> [app\_service\_environment\_enabled](#input\_app\_service\_environment\_enabled) | Enable the app service environment for the app service. | `bool` | `false` | no |
| <a name="input_app_service_name_override"></a> [app\_service\_name\_override](#input\_app\_service\_name\_override) | Override the app service name | `string` | `""` | no |
| <a name="input_app_service_plan_name_override"></a> [app\_service\_plan\_name\_override](#input\_app\_service\_plan\_name\_override) | Override the app service plan name | `string` | `""` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | Connection strings for the app service | `map(string)` | `{}` | no |
| <a name="input_db_server_audit_storage_account_name_override"></a> [db\_server\_audit\_storage\_account\_name\_override](#input\_db\_server\_audit\_storage\_account\_name\_override) | Override the storage account name for the database server audit | `string` | `""` | no |
| <a name="input_keyvault_admin_principal_ids"></a> [keyvault\_admin\_principal\_ids](#input\_keyvault\_admin\_principal\_ids) | List of EntraID Principal ID's that will be granted admin access to the Key Vault. | `list(string)` | `null` | no |
| <a name="input_public_ip_name_override"></a> [public\_ip\_name\_override](#input\_public\_ip\_name\_override) | Override the public IP name | `string` | `""` | no |
| <a name="input_resource_group_name_override"></a> [resource\_group\_name\_override](#input\_resource\_group\_name\_override) | Override the resource group name | `string` | `null` | no |
| <a name="input_secret_app_service_configuration"></a> [secret\_app\_service\_configuration](#input\_secret\_app\_service\_configuration) | Configuration for the app service | `map(string)` | `{}` | no |
| <a name="input_sql_admin_group_member_principal_ids"></a> [sql\_admin\_group\_member\_principal\_ids](#input\_sql\_admin\_group\_member\_principal\_ids) | List of EntraID Principal ID's that will be granted member access to the SQL Server. | `list(string)` | `[]` | no |
| <a name="input_sql_logins"></a> [sql\_logins](#input\_sql\_logins) | List of SQL Logins to create on the SQL Server | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_vnet_name_override"></a> [vnet\_name\_override](#input\_vnet\_name\_override) | Override the vnet name | `string` | `""` | no |
| <a name="input_warehouse_ip_whitelist"></a> [warehouse\_ip\_whitelist](#input\_warehouse\_ip\_whitelist) | A list of IP Addresses / Name pairs to whitelist for the data warehouse | <pre>list(<br>    object({<br>      ip_address = string<br>      name       = string<br>    })<br>  )</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | The ID of the app service plan |
| <a name="output_db_admin_group_object_id"></a> [db\_admin\_group\_object\_id](#output\_db\_admin\_group\_object\_id) | The object ID of the SQL Admin group |
| <a name="output_keyvault_id"></a> [keyvault\_id](#output\_keyvault\_id) | The ID of the Key Vault |
| <a name="output_resource_group_info"></a> [resource\_group\_info](#output\_resource\_group\_info) | Information about the resource group |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The ID of the subnet the app service was created in |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [mssql_database.databases](https://registry.terraform.io/providers/PGSSoft/mssql/0.6.0/docs/data-sources/database) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_service"></a> [app\_service](#module\_app\_service) | ../../modules/azure/app-service | n/a |
| <a name="module_base_setup"></a> [base\_setup](#module\_base\_setup) | ../../modules/azure/base-setup | n/a |
| <a name="module_database_server"></a> [database\_server](#module\_database\_server) | ../../modules/azure/datawarehouse | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../modules/skyvafnir/defaults | n/a |
| <a name="module_frontdoor"></a> [frontdoor](#module\_frontdoor) | ../../modules/azure/front-door | n/a |
| <a name="module_group_sql_user"></a> [group\_sql\_user](#module\_group\_sql\_user) | ../../modules/mssql/external-user | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../../modules/azure/keyvault | n/a |
| <a name="module_network_base"></a> [network\_base](#module\_network\_base) | ../../modules/azure/network/network-base | n/a |
| <a name="module_role_assignments"></a> [role\_assignments](#module\_role\_assignments) | ../../modules/mssql/db-role-assignment | n/a |
| <a name="module_sql_admin_group"></a> [sql\_admin\_group](#module\_sql\_admin\_group) | ../../modules/azure/ad-group | n/a |
| <a name="module_sql_logins"></a> [sql\_logins](#module\_sql\_logins) | ../../modules/mssql/sql-login | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |
| <a name="requirement_mssql"></a> [mssql](#requirement\_mssql) | =0.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.107.0 |
| <a name="provider_mssql"></a> [mssql](#provider\_mssql) | 0.6.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    skyvafnir 
-->
