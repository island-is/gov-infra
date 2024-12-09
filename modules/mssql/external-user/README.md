# MS SQL External User

### a Skývafnir Terraform Module

This module creates an external user in an Microsoft SQL Server via
the [`mssql_script` resource](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/resources/script)
provided
by the [PGSSoft terraform provider](https://registry.terraform.io/providers/PGSSoft/mssql/latest).

This is because the `mssql_user` resource does not support creating users `FROM EXTERNAL PROVIDER`

______________________________________________________________________

## Troubleshooting

**Symptom:** The following error is returned when running `terraform apply`:

```
mssql: Principal '<PRINCIPAL NAME>' could not be found or this principal type is not supported.
```

**Probably cause:** The Principal mentioned does not exist in Azure Entra.

**Solution:** Ensure the Principal exists in Azure Entra and that the `entra_display_name` matches the Principal name.

______________________________________________________________________

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entra_display_name"></a> [entra\_display\_name](#input\_entra\_display\_name) | The display names of the Entra identity | `string` | n/a | yes |
| <a name="input_mssql_db_info"></a> [mssql\_db\_info](#input\_mssql\_db\_info) | The name and MSSQL Provider ID of the MSSQL database | <pre>object({<br>    id   = string<br>    name = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_info"></a> [db\_info](#output\_db\_info) | Information about the databases in which the user has been created. |
| <a name="output_username"></a> [username](#output\_username) | A the user created by this module |

## Resources

| Name | Type |
|------|------|
| [mssql_script.this](https://registry.terraform.io/providers/PGSSoft/mssql/latest/docs/resources/script) | resource |



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
