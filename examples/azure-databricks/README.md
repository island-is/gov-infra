# databricks

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_contact_emails"></a> [budget\_contact\_emails](#input\_budget\_contact\_emails) | Emails to notify when the budget is forecasted to be broken | `list(string)` | n/a | yes |
| <a name="input_databricks_users"></a> [databricks\_users](#input\_databricks\_users) | List of users to add to the databricks workspace | <pre>list(object({<br>    user_name    = string<br>    display_name = string<br>  }))</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_databricks_sku_name"></a> [databricks\_sku\_name](#input\_databricks\_sku\_name) | The sku-name for the databricks workspace. This controls the sku-name that will be used for the databricks workspace.<br>  sku-names vary across regions and offerings, run `az databricks workspace list-skus -l [your region] -o table` to see available options. | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | The URL of the Databricks workspace |



## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_setup"></a> [base\_setup](#module\_base\_setup) | ../../modules/azure/base-setup | n/a |
| <a name="module_databricks_config"></a> [databricks\_config](#module\_databricks\_config) | ../../modules/databricks/initial_config | n/a |
| <a name="module_databricks_workspace"></a> [databricks\_workspace](#module\_databricks\_workspace) | ../../modules/azure/databricks | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |


<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
