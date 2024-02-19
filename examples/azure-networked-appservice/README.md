# azure-networked-appservice

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                                                                                     | Description                                                                                   | Type                                                                                                        | Default | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_databases"></a> [databases](#input_databases)                                                                                                             | Map of databases to create                                                                    | <pre>map(object({<br>    sku_name    = string<br>    max_size_gb = number<br>  }))</pre>                    | n/a     |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                                                                                                | Identifier for the application, workload or service                                           | `string`                                                                                                    | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                                                                                | Org code                                                                                      | `string`                                                                                                    | n/a     |   yes    |
| <a name="input_sql_admin_group_owner_principal_ids"></a> [sql_admin_group_owner_principal_ids](#input_sql_admin_group_owner_principal_ids)                               | List of EntraID Principal ID's that will be granted owner access to the SQL Server.           | `list(string)`                                                                                              | n/a     |   yes    |
| <a name="input_sql_monitor_alert_emails"></a> [sql_monitor_alert_emails](#input_sql_monitor_alert_emails)                                                                | Emails to send SQL alerts to                                                                  | `list(string)`                                                                                              | n/a     |   yes    |
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id)                                                                                                             | The tenant id of the Azure AD tenant used for authentication                                  | `string`                                                                                                    | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                                                                                            | The tier of the environment (e.g. test, prod)                                                 | `string`                                                                                                    | n/a     |   yes    |
| <a name="input_app_service_configuration"></a> [app_service_configuration](#input_app_service_configuration)                                                             | Configuration for the app service                                                             | `map(string)`                                                                                               | `{}`    |    no    |
| <a name="input_app_service_name_override"></a> [app_service_name_override](#input_app_service_name_override)                                                             | Override the app service name                                                                 | `string`                                                                                                    | `""`    |    no    |
| <a name="input_db_server_audit_storage_account_name_override"></a> [db_server_audit_storage_account_name_override](#input_db_server_audit_storage_account_name_override) | Override the storage account name for the database server audit                               | `string`                                                                                                    | `""`    |    no    |
| <a name="input_keyvault_admin_principal_ids"></a> [keyvault_admin_principal_ids](#input_keyvault_admin_principal_ids)                                                    | List of EntraID Principal ID's that will be granted admin access to the Key Vault.            | `list(string)`                                                                                              | `null`  |    no    |
| <a name="input_public_ip_name_override"></a> [public_ip_name_override](#input_public_ip_name_override)                                                                   | Override the public IP name                                                                   | `string`                                                                                                    | `""`    |    no    |
| <a name="input_resource_group_name_override"></a> [resource_group_name_override](#input_resource_group_name_override)                                                    | Override the resource group name                                                              | `string`                                                                                                    | `null`  |    no    |
| <a name="input_secret_app_service_configuration"></a> [secret_app_service_configuration](#input_secret_app_service_configuration)                                        | Configuration for the app service                                                             | `map(string)`                                                                                               | `{}`    |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                                            | Any tags that should be present on created resources. Will get merged with local.default_tags | `map(string)`                                                                                               | `{}`    |    no    |
| <a name="input_vnet_name_override"></a> [vnet_name_override](#input_vnet_name_override)                                                                                  | Override the vnet name                                                                        | `string`                                                                                                    | `""`    |    no    |
| <a name="input_warehouse_ip_whitelist"></a> [warehouse_ip_whitelist](#input_warehouse_ip_whitelist)                                                                      | A list of IP Addresses / Name pairs to whitelist for the data warehouse                       | <pre>list(<br>    object({<br>      ip_address = string<br>      name       = string<br>    })<br>  )</pre> | `[]`    |    no    |

## Resources

| Name                                                                                                                                 | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azurerm_key_vault_secret.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource    |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)     | data source |
| [mssql_database.databases](https://registry.terraform.io/providers/PGSSoft/mssql/0.6.0/docs/data-sources/database)                   | data source |

## Modules

| Name                                                                             | Source                                   | Version |
| -------------------------------------------------------------------------------- | ---------------------------------------- | ------- |
| <a name="module_app_service"></a> [app_service](#module_app_service)             | ../../modules/azure/app-service          | n/a     |
| <a name="module_base_setup"></a> [base_setup](#module_base_setup)                | ../../modules/azure/base-setup           | n/a     |
| <a name="module_database_server"></a> [database_server](#module_database_server) | ../../modules/azure/datawarehouse        | n/a     |
| <a name="module_group_sql_user"></a> [group_sql_user](#module_group_sql_user)    | ../../modules/mssql/external-user        | n/a     |
| <a name="module_keyvault"></a> [keyvault](#module_keyvault)                      | ../../modules/azure/keyvault             | n/a     |
| <a name="module_network_base"></a> [network_base](#module_network_base)          | ../../modules/azure/network/network-base | n/a     |
| <a name="module_sql_admin_group"></a> [sql_admin_group](#module_sql_admin_group) | ../../modules/azure/ad-group             | n/a     |

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1   |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >=3.89.0 |
| <a name="requirement_mssql"></a> [mssql](#requirement_mssql)             | =0.6.0   |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=3.89.0 |
| <a name="provider_mssql"></a> [mssql](#provider_mssql)       | =0.6.0   |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    jonorrikristjansson
Version:   0.1.0
Timestamp: 2023-12-19T16:11:02
-->
