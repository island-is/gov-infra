# databricks

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                             | Description                                                                                                                                                                                                                                                         | Type                                                                                        | Default      | Required |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------ | :------: |
| <a name="input_budget_contact_emails"></a> [budget_contact_emails](#input_budget_contact_emails) | Emails to notify when the budget is forecasted to be broken                                                                                                                                                                                                         | `list(string)`                                                                              | n/a          |   yes    |
| <a name="input_databricks_users"></a> [databricks_users](#input_databricks_users)                | List of users to add to the databricks workspace                                                                                                                                                                                                                    | <pre>list(object({<br>    user_name    = string<br>    display_name = string<br>  }))</pre> | n/a          |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                        | Identifier for the application, workload or service                                                                                                                                                                                                                 | `string`                                                                                    | n/a          |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                        | Org code                                                                                                                                                                                                                                                            | `string`                                                                                    | n/a          |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                    | The tier of the environment (e.g. test, prod)                                                                                                                                                                                                                       | `string`                                                                                    | n/a          |   yes    |
| <a name="input_databricks_sku_name"></a> [databricks_sku_name](#input_databricks_sku_name)       | The sku-name for the databricks workspace. This controls the sku-name that will be used for the databricks workspace.<br>  sku-names vary across regions and offerings, run `az databricks workspace list-skus -l [your region] -o table` to see available options. | `string`                                                                                    | `"standard"` |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                    | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                                                                                                       | `map(string)`                                                                               | `{}`         |    no    |

## Outputs

| Name                                                                                                        | Description                         |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| <a name="output_databricks_workspace_url"></a> [databricks_workspace_url](#output_databricks_workspace_url) | The URL of the Databricks workspace |

## Modules

| Name                                                                                            | Source                                  | Version |
| ----------------------------------------------------------------------------------------------- | --------------------------------------- | ------- |
| <a name="module_base_setup"></a> [base_setup](#module_base_setup)                               | ../../modules/azure/base-setup          | n/a     |
| <a name="module_databricks_config"></a> [databricks_config](#module_databricks_config)          | ../../modules/databricks/initial_config | n/a     |
| <a name="module_databricks_workspace"></a> [databricks_workspace](#module_databricks_workspace) | ../../modules/azure/databricks          | n/a     |
| <a name="module_defaults"></a> [defaults](#module_defaults)                                     | ../../modules/skyvafnir/defaults        | n/a     |

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1  |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    jonorrikristjansson
Version:   0.1.0
Timestamp: 2024-01-14T16:44:10
-->
