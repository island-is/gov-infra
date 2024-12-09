# monitor-alert

### a Skývafnir Terraform Module

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_purpose"></a> [group\_purpose](#input\_group\_purpose) | The purpose of the resource group. This goes into the resource name.<br>    Should be succinct, descriptive and self-explanatory.<br>    Examples: `pipeline_fail`, `budget_alarms` etc. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The name and location of the Resource Group into which the app service should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | Short name for the Action Group. Must not exceed 9 characters.<br>  This string, together with the org\_code, forms the "short\_name" of the Action Group. | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_arm_receiver_role_ids"></a> [arm\_receiver\_role\_ids](#input\_arm\_receiver\_role\_ids) | A map of ARM receiver role ids, keyed by role name, to be added to the action group | `map(string)` | `{}` | no |
| <a name="input_email_receivers"></a> [email\_receivers](#input\_email\_receivers) | Email addresses to send alerts to | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_action_group_id"></a> [action\_group\_id](#output\_action\_group\_id) | The ID of the Action Group. |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.103.1 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
