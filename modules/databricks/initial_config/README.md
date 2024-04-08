# databricks

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                      | Description                                         | Type                                                                                        | Default | Required |
| --------------------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance) | Identifier for the application, workload or service | `string`                                                                                    | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code) | Org code                                            | `string`                                                                                    | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)             | The tier of the environment (e.g. test, prod)       | `string`                                                                                    | n/a     |   yes    |
| <a name="input_users"></a> [users](#input_users)          | List of users to add to the workspace               | <pre>list(object({<br>    user_name    = string<br>    display_name = string<br>  }))</pre> | n/a     |   yes    |

## Resources

| Name                                                                                                                                 | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [databricks_cluster.cluster](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster)            | resource    |
| [databricks_user.users](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/user)                    | resource    |
| [databricks_node_type.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/node_type)        | data source |
| [databricks_spark_version.lts](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/spark_version) | data source |

## Modules

| Name                                                        | Source                   | Version |
| ----------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_defaults"></a> [defaults](#module_defaults) | ../../skyvafnir/defaults | n/a     |

## Requirements

| Name                                                                        | Version  |
| --------------------------------------------------------------------------- | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)    | >= 1.1   |
| <a name="requirement_databricks"></a> [databricks](#requirement_databricks) | >=1.33.0 |

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_databricks"></a> [databricks](#provider_databricks) | 1.35.0  |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    jonorrikristjansson
Version:   0.1.0
Timestamp: 2024-01-04T10:40:16
-->
