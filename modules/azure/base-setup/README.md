# Base Setup

### a Skývafnir Terraform Module

Provision a Resource Group and a Consumption Budget for an Environment.

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | What is this resource for? (e.g. 'bastion', 'app', 'db') | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Name of the organization | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_budget_contact_emails"></a> [budget\_contact\_emails](#input\_budget\_contact\_emails) | Emails to notify when the budget is forecasted to be broken | `list(string)` | `null` | no |
| <a name="input_budget_for_resource_group"></a> [budget\_for\_resource\_group](#input\_budget\_for\_resource\_group) | Budget for the whole resource group. The currency is determined by the subscription's billing currency.<br>  If set to 0, no budget will be created. | `number` | `0` | no |
| <a name="input_existing_resource_group_info"></a> [existing\_resource\_group\_info](#input\_existing\_resource\_group\_info) | Information about an existing resource group to use instead of creating a new one | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to deploy to | `string` | `"northeurope"` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | Whether to protect resources from accidental deletion | `bool` | `false` | no |
| <a name="input_resource_group_name_override"></a> [resource\_group\_name\_override](#input\_resource\_group\_name\_override) | Override the name of the resource group | `string` | `null` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | Role assignments to be applied to the resource group | <pre>list(object({<br>    principal_id       = string<br>    role_definition_id = optional(string)<br>    role_name          = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budget_alert_action_group_id"></a> [budget\_alert\_action\_group\_id](#output\_budget\_alert\_action\_group\_id) | The Action Group ID |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The Resource Group id |
| <a name="output_resource_group_info"></a> [resource\_group\_info](#output\_resource\_group\_info) | The ID, Name and Location of the Resource Group. |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | The Resource Group location |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group name |

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) | resource |
| [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [time_offset.now](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cost_alarm_action_group"></a> [cost\_alarm\_action\_group](#module\_cost\_alarm\_action\_group) | ../monitor-action-group | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |
| <a name="module_permissions"></a> [permissions](#module\_permissions) | ../role-assignment | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.103.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.11.1 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
```
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
```
-->
