# MS SQL Database Role Assignment

### a Skývafnir Terraform Module

This module assigns a database role to a database principal using the [PGSSoft terraform provider](https://registry.terraform.io/providers/PGSSoft/mssql/latest).

This is because the `mssql_user` resource does not support creating external users.

### Permission Requirements

- A list of known permissions required to run this module

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_mssql_db_info"></a> [mssql\_db\_info](#input\_mssql\_db\_info) | The name and MSSQL Provider ID of the MSSQL database | <pre>object({<br>    name = string<br>    id   = optional(string, "")<br>  })</pre> | n/a | yes |
| <a name="input_mssql_principal_name"></a> [mssql\_principal\_name](#input\_mssql\_principal\_name) | The name of the principal to which the role will be assigned. | `string` | n/a | yes |
| <a name="input_mssql_role_id"></a> [mssql\_role\_id](#input\_mssql\_role\_id) | The MSSQL Provider ID (`<database_id>/<role_id>`) of the role to assign to the principal.<br>  Use either this or `var.mssql_role_name` | `string` | `null` | no |
| <a name="input_mssql_role_name"></a> [mssql\_role\_name](#input\_mssql\_role\_name) | The name of the role to assign to the principal.<br>  Use either this or `var.mssql_role_id` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | The database name |
| <a name="output_member"></a> [member](#output\_member) | The member |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The role created by this module and its members |

## Resources

| Name | Type |
|------|------|
| [mssql_database_role_member.this](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/resources/database_role_member) | resource |
| [mssql_database_role.this](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/data-sources/database_role) | data source |
| [mssql_sql_user.this](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/data-sources/sql_user) | data source |



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_mssql"></a> [mssql](#requirement\_mssql) | >=0.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mssql"></a> [mssql](#provider\_mssql) | 0.6.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
