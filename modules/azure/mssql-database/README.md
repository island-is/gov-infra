# mssql_database

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                         | Description                                                                                                                                                                                                                                    | Type           | Default                 | Required |
| ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                                    | Identifier for the application, workload or service                                                                                                                                                                                            | `string`       | n/a                     |   yes    |
| <a name="input_max_size_gb"></a> [max_size_gb](#input_max_size_gb)                                           | The maximum size of the MS SQL Database in GB.<br>  Keep in mind that the maximum size of a database varies between SKUs.<br>  See: https://learn.microsoft.com/en-us/azure/azure-sql/database/resource-limits-logical-server?view=azuresql-db | `number`       | n/a                     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                    | Org code                                                                                                                                                                                                                                       | `string`       | n/a                     |   yes    |
| <a name="input_server_id"></a> [server_id](#input_server_id)                                                 | The ID of the SQL server to which the database belongs                                                                                                                                                                                         | `string`       | n/a                     |   yes    |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name)                                                    | The SKU name to use for the MS SQL Database. The SKU name determines the performance tier (and thus the price) of the database.<br>  See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu                          | `string`       | n/a                     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                                | The tier of the environment (e.g. test, prod)                                                                                                                                                                                                  | `string`       | n/a                     |   yes    |
| <a name="input_auto_pause_delay"></a> [auto_pause_delay](#input_auto_pause_delay)                            | The number of minutes of idle time before the database is automatically paused. The minimum is 60 minutes and the maximum is 10080 minutes (7 days).<br>  If not specified, the database is never paused.                                      | `number`       | `null`                  |    no    |
| <a name="input_collation"></a> [collation](#input_collation)                                                 | The collation to use for the MS SQL Database.                                                                                                                                                                                                  | `string`       | `"Icelandic_100_CI_AS"` |    no    |
| <a name="input_contributor_principal_ids"></a> [contributor_principal_ids](#input_contributor_principal_ids) | List of principal IDs to assign the SQL DB Contributor role to.                                                                                                                                                                                | `list(string)` | `[]`                    |    no    |
| <a name="input_name_override"></a> [name_override](#input_name_override)                                     | Override the name of the database. If not set, the name will be generated from the var.instance variable                                                                                                                                       | `string`       | `null`                  |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                                                                                  | `map(string)`  | `{}`                    |    no    |
| <a name="input_zone_redundant"></a> [zone_redundant](#input_zone_redundant)                                  | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones                                                                                                    | `bool`         | `false`                 |    no    |

## Outputs

| Name                                            | Description                   |
| ----------------------------------------------- | ----------------------------- |
| <a name="output_id"></a> [id](#output_id)       | The ID of the SQL Database.   |
| <a name="output_name"></a> [name](#output_name) | The name of the SQL Database. |

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |

## Modules

| Name                                                                                      | Source                   | Version |
| ----------------------------------------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_contributor_access"></a> [contributor_access](#module_contributor_access) | ../role-assignment       | n/a     |
| <a name="module_defaults"></a> [defaults](#module_defaults)                               | ../../skyvafnir/defaults | n/a     |

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >=3.0.0 |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.90.0  |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    gzur
Version:   0.1.0
Timestamp: 2023-12-14T13:28:23
-->
