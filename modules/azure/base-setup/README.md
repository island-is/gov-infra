# Base Setup

### a Skývafnir Terraform Module

Provision a Resource Group and a Consumption Budget for an Environment.

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                                  | Description                                                                                   | Type                                                                                                                                                           | Default         | Required |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                                             | What is this resource for? (e.g. 'bastion', 'app', 'db')                                      | `string`                                                                                                                                                       | n/a             |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                             | Name of the organization                                                                      | `string`                                                                                                                                                       | n/a             |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                                         | Tier of the environment                                                                       | `string`                                                                                                                                                       | n/a             |   yes    |
| <a name="input_budget_contact_emails"></a> [budget_contact_emails](#input_budget_contact_emails)                      | Emails to notify when the budget is forecasted to be broken                                   | `list(string)`                                                                                                                                                 | `null`          |    no    |
| <a name="input_budget_for_resource_group"></a> [budget_for_resource_group](#input_budget_for_resource_group)          | Budget for the whole resource group                                                           | `number`                                                                                                                                                       | `0`             |    no    |
| <a name="input_existing_resource_group_info"></a> [existing_resource_group_info](#input_existing_resource_group_info) | Information about an existing resource group to use instead of creating a new one             | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre>                                                         | `null`          |    no    |
| <a name="input_location"></a> [location](#input_location)                                                             | Azure region to deploy to                                                                     | `string`                                                                                                                                                       | `"northeurope"` |    no    |
| <a name="input_lock"></a> [lock](#input_lock)                                                                         | Whether to protect resources from accidental deletion                                         | `bool`                                                                                                                                                         | `false`         |    no    |
| <a name="input_role_assignments"></a> [role_assignments](#input_role_assignments)                                     | Role assignments to be applied to the resource group                                          | <pre>list(object({<br>    principal_id       = string<br>    role_definition_id = optional(string)<br>    role_name          = optional(string)<br>  }))</pre> | `null`          |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                         | Any tags that should be present on created resources. Will get merged with local.default_tags | `map(string)`                                                                                                                                                  | `{}`            |    no    |

## Outputs

| Name                                                                                                                    | Description                                      |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| <a name="output_budget_alert_action_group_id"></a> [budget_alert_action_group_id](#output_budget_alert_action_group_id) | The Action Group ID                              |
| <a name="output_resource_group_id"></a> [resource_group_id](#output_resource_group_id)                                  | The Resource Group id                            |
| <a name="output_resource_group_info"></a> [resource_group_info](#output_resource_group_info)                            | The ID, Name and Location of the Resource Group. |
| <a name="output_resource_group_location"></a> [resource_group_location](#output_resource_group_location)                | The Resource Group location                      |
| <a name="output_resource_group_name"></a> [resource_group_name](#output_resource_group_name)                            | The Resource Group name                          |

## Resources

| Name                                                                                                                                                                | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_consumption_budget_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) | resource    |
| [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock)                                     | resource    |
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group)                           | resource    |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)                                       | resource    |
| [time_offset.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset)                                                              | resource    |
| [external_external.git_sha](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)                                           | data source |

## Modules

| Name                                                                 | Source                   | Version |
| -------------------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_defaults"></a> [defaults](#module_defaults)          | ../../skyvafnir/defaults | n/a     |
| <a name="module_permissions"></a> [permissions](#module_permissions) | ../role-assignment       | n/a     |

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >=3.0.0 |
| <a name="requirement_external"></a> [external](#requirement_external)    | >=2.3   |
| <a name="requirement_time"></a> [time](#requirement_time)                | >=0.9   |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | 3.90.0  |
| <a name="provider_external"></a> [external](#provider_external) | 2.3.2   |
| <a name="provider_time"></a> [time](#provider_time)             | 0.10.0  |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
```
# Module scaffolded via skyvafnir-module-template
Author:    gzur
Version:   0.1.0
Timestamp: 2023-05-08T15:12:19
```
-->
