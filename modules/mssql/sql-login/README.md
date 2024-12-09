# sql-login

### a Skývafnir Terraform Module

This module creates an SQL Login in an Microsoft SQL Server Database via
the [`mssql_sql_login` resource](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/resources/sql_login)
provided
by the [PGSSoft terraform provider](https://registry.terraform.io/providers/PGSSoft/mssql/latest).

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_username"></a> [username](#input\_username) | Username for the database user. | `string` | n/a | yes |
| <a name="input_default_language"></a> [default\_language](#input\_default\_language) | The default language for the database. Defaults to the current default language of the server. | `string` | `null` | no |
| <a name="input_enforce_pw_expiry"></a> [enforce\_pw\_expiry](#input\_enforce\_pw\_expiry) | Whether to enforce password expiry on the database. | `bool` | `false` | no |
| <a name="input_enforce_pw_policy"></a> [enforce\_pw\_policy](#input\_enforce\_pw\_policy) | Whether to enforce password policy on the database. | `bool` | `false` | no |
| <a name="input_mssql_db_info"></a> [mssql\_db\_info](#input\_mssql\_db\_info) | The name and MSSQL Provider ID of the MSSQL database | <pre>object({<br>    id   = optional(string, null)<br>    name = optional(string, null)<br>  })</pre> | <pre>{<br>  "id": null,<br>  "name": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_login_id"></a> [login\_id](#output\_login\_id) | ID of the SQL Login |
| <a name="output_login_password"></a> [login\_password](#output\_login\_password) | Login credentials for The SQL Login |
| <a name="output_login_username"></a> [login\_username](#output\_login\_username) | Login username for SQL Login |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Principal ID of the SQL Login |

## Resources

| Name | Type |
|------|------|
| [mssql_sql_login.this](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/resources/sql_login) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_mssql"></a> [mssql](#requirement\_mssql) | >=0.6.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mssql"></a> [mssql](#provider\_mssql) | 0.6.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.1 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
