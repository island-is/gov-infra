# monitor-alert

### a Skývafnir Terraform Module

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                             | Description                                                                                                                                                                              | Type                                                                                                   | Default | Required |
| ------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------- | :------: |
| <a name="input_group_purpose"></a> [group_purpose](#input_group_purpose)                         | The purpose of the resource group. This goes into the resource name.<br>    Should be succinct, descriptive and self-explanatory.<br>    Examples: `pipeline_fail`, `budget_alarms` etc. | `string`                                                                                               | n/a     |   yes    |
| <a name="input_instance"></a> [instance](#input_instance)                                        | Identifier for the application, workload or service                                                                                                                                      | `string`                                                                                               | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                        | Org code                                                                                                                                                                                 | `string`                                                                                               | n/a     |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info)       | The name and location of the Resource Group into which the app service should be placed.                                                                                                 | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a     |   yes    |
| <a name="input_short_name"></a> [short_name](#input_short_name)                                  | Short name for the Action Group. Must not exceed 9 characters.<br>  This string, together with the org_code, forms the "short_name" of the Action Group.                                 | `string`                                                                                               | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                    | The tier of the environment (e.g. test, prod)                                                                                                                                            | `string`                                                                                               | n/a     |   yes    |
| <a name="input_arm_receiver_role_ids"></a> [arm_receiver_role_ids](#input_arm_receiver_role_ids) | A map of ARM receiver role ids, keyed by role name, to be added to the action group                                                                                                      | `map(string)`                                                                                          | `{}`    |    no    |
| <a name="input_email_receivers"></a> [email_receivers](#input_email_receivers)                   | Email addresses to send alerts to                                                                                                                                                        | `list(string)`                                                                                         | `[]`    |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                    | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                            | `map(string)`                                                                                          | `{}`    |    no    |

## Outputs

| Name                                                                             | Description                 |
| -------------------------------------------------------------------------------- | --------------------------- |
| <a name="output_action_group_id"></a> [action_group_id](#output_action_group_id) | The ID of the Action Group. |

## Resources

| Name                                                                                                                                      | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

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
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=3.0.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    gzur
Version:   0.1.0
Timestamp: 2024-02-14T13:40:35
-->
