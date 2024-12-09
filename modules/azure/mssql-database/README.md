# mssql_database

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The maximum size of the MS SQL Database in GB.<br>  Keep in mind that the maximum size of a database varies between SKUs.<br>  See: https://learn.microsoft.com/en-us/azure/azure-sql/database/resource-limits-logical-server?view=azuresql-db | `number` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | The ID of the SQL server to which the database belongs | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name to use for the MS SQL Database. The SKU name determines the performance tier (and thus the price) of the database.<br>  See: https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_auto_pause_delay_minutes"></a> [auto\_pause\_delay\_minutes](#input\_auto\_pause\_delay\_minutes) | The number of minutes of idle time before the database is automatically paused. The minimum is 60 minutes and the maximum is 10080 minutes (7 days).<br>  If not specified, the database is never paused.<br>  This setting is only available for Serverless SKU's. | `number` | `null` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | The collation to use for the MS SQL Database. | `string` | `"Icelandic_100_CI_AS"` | no |
| <a name="input_contributor_principal_ids"></a> [contributor\_principal\_ids](#input\_contributor\_principal\_ids) | List of principal IDs to assign the SQL DB Contributor role to. | `list(string)` | `[]` | no |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | Override the name of the database. If not set, the name will be generated from the var.instance variable | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the SQL Database. |
| <a name="output_name"></a> [name](#output\_name) | The name of the SQL Database. |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_contributor_access"></a> [contributor\_access](#module\_contributor\_access) | ../role-assignment | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |

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

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
