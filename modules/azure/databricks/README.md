# databricks

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                       | Description                                                                                   | Type                                                                          | Default | Required |
| ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                  | Identifier for the application, workload or service                                           | `string`                                                                      | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                  | Org code                                                                                      | `string`                                                                      | n/a     |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info) | Name and Location of the Resource Group                                                       | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | n/a     |   yes    |
| <a name="input_sku"></a> [sku](#input_sku)                                                 | The SKU of the Databricks workspace to create                                                 | `string`                                                                      | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                              | The tier of the environment (e.g. test, prod)                                                 | `string`                                                                      | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                              | Any tags that should be present on created resources. Will get merged with local.default_tags | `map(string)`                                                                 | `{}`    |    no    |

## Outputs

| Name                                                                       | Description                         |
| -------------------------------------------------------------------------- | ----------------------------------- |
| <a name="output_workspace_url"></a> [workspace_url](#output_workspace_url) | The URL of the Databricks workspace |

## Resources

| Name                                                                                                                                      | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |

## Modules

| Name                                                        | Source                   | Version |
| ----------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_defaults"></a> [defaults](#module_defaults) | ../../skyvafnir/defaults | n/a     |

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
Author:    jonorrikristjansson
Version:   0.1.0
Timestamp: 2024-01-04T10:40:16
-->
