# monitor-alert

### a Skývafnir Terraform Module

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | The action for the alert rule | <pre>object({<br>    action_group_id    = string<br>    webhook_properties = optional(map(string), {})<br>  })</pre> | n/a | yes |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | The criteria for the alert rule | <pre>list(object({<br>    aggregation       = string<br>    metric_name       = string<br>    metric_namespace  = optional(string, "")<br>    operator          = string<br>    threshold         = optional(number, null)<br>    alert_sensitivity = optional(string, "")<br>  }))</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the alert | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The name and location of the Resource Group into which the app service should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_target_resource_type"></a> [target\_resource\_type](#input\_target\_resource\_type) | The type of the target resource.<br>  For example, Microsoft.Compute/virtualMachines" | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_frequency"></a> [frequency](#input\_frequency) | The frequency of the alert rule, in ISO8601 format | `string` | `"PT1M"` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | The scopes to assign the role to | `list(string)` | `[]` | no |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity of the alert rule | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | The window size of the alert rule, in ISO8601 format | `string` | `"PT5M"` | no |



## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_metric_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |

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
