# api-management

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                      | Description                                                                                   | Type                                                                          | Default       | Required |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------------- | :------: |
| <a name="input_api_contributor_group_id"></a> [api_contributor_group_id](#input_api_contributor_group_id) | The ID of the group that should be given contributor access to the API Management instance    | `string`                                                                      | n/a           |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                                 | Identifier for the application, workload or service                                           | `string`                                                                      | n/a           |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                 | Org code                                                                                      | `string`                                                                      | n/a           |   yes    |
| <a name="input_publisher_email"></a> [publisher_email](#input_publisher_email)                            | Publisher email                                                                               | `string`                                                                      | n/a           |   yes    |
| <a name="input_publisher_name"></a> [publisher_name](#input_publisher_name)                               | Publisher name                                                                                | `string`                                                                      | n/a           |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info)                | Name and Location of the Resource Group                                                       | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | n/a           |   yes    |
| <a name="input_sku_capacity"></a> [sku_capacity](#input_sku_capacity)                                     | SKU capacity for API management                                                               | `string`                                                                      | n/a           |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                             | The tier of the environment (e.g. test, prod)                                                 | `string`                                                                      | n/a           |   yes    |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name)                                                 | SKU for API management                                                                        | `string`                                                                      | `"Developer"` |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                             | Any tags that should be present on created resources. Will get merged with local.default_tags | `map(string)`                                                                 | `{}`          |    no    |

## Resources

| Name                                                                                                                          | Type     |
| ----------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Modules

| Name                                                                                            | Source                   | Version |
| ----------------------------------------------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_contributor_access"></a> [contributor_access](#module_contributor_access)       | ../role-assignment       | n/a     |
| <a name="module_defaults"></a> [defaults](#module_defaults)                                     | ../../skyvafnir/defaults | n/a     |
| <a name="module_naming_apimanagement"></a> [naming_apimanagement](#module_naming_apimanagement) | Azure/naming/azurerm     | 0.2.0   |

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
Timestamp: 2023-05-23T20:48:44
-->
