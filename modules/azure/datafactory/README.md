# datafactory

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datafactory_contributor_group_id"></a> [datafactory\_contributor\_group\_id](#input\_datafactory\_contributor\_group\_id) | The ID of the group that should be granted contributor access to the Data Factory. | `string` | n/a | yes |
| <a name="input_git_backend_config"></a> [git\_backend\_config](#input\_git\_backend\_config) | Configuration for the github repository | <pre>object({<br>    type = string # must be either "github" or "azuredevops"<br><br>    # Required for Github<br>    git_url = optional(string)<br><br>    # Required for Azure DevOps<br>    project_name = optional(string)<br>    tenant_id    = optional(string)<br><br>    # General configuration<br>    account_name    = string<br>    branch_name     = string<br>    repository_name = string<br>    root_folder     = string<br>  })</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | The organization code for the environment | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The name and location of the Resource Group into which the Data Factory should be placed. | <pre>object({<br>    id       = optional(string, "")<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_alert_on_pipeline_failure"></a> [alert\_on\_pipeline\_failure](#input\_alert\_on\_pipeline\_failure) | If true, an alert will be created to notify when a pipeline fails. | `bool` | `true` | no |
| <a name="input_datalake_id"></a> [datalake\_id](#input\_datalake\_id) | The id of the datalake to assign the data factory to. | `string` | `""` | no |
| <a name="input_global_parameters"></a> [global\_parameters](#input\_global\_parameters) | A list of global parameters to be added to the Data Factory. These parameters will be available to all pipelines in the Data Factory. | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = any<br>  }))</pre> | `[]` | no |
| <a name="input_grant_access_to_warehouse"></a> [grant\_access\_to\_warehouse](#input\_grant\_access\_to\_warehouse) | Whether to grant the the data factory access to the warehouse. | `bool` | `false` | no |
| <a name="input_group_config"></a> [group\_config](#input\_group\_config) | Configuration for the Entra ID Group that will be created for the Data Factory principal.<br>    The passed `purpose` will be included in the group name.<br>    If not provided, no group will be created. | <pre>object({<br>    purpose = string<br>    owners  = list(string)<br>  })</pre> | `null` | no |
| <a name="input_link_service_to_datalake"></a> [link\_service\_to\_datalake](#input\_link\_service\_to\_datalake) | Whether to link the data factory to the datalake via Linked Services. | `bool` | `false` | no |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | Override the name of the Data Factory. If not provided, the name will be generated. | `string` | `null` | no |
| <a name="input_pipeline_failure_alert_emails"></a> [pipeline\_failure\_alert\_emails](#input\_pipeline\_failure\_alert\_emails) | A list of email addresses to notify when a pipeline fails. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_warehouse_id"></a> [warehouse\_id](#input\_warehouse\_id) | The id the warehouse to assign the data factory to. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The ID the Entra group to which the datafactory belongs. |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of the Entra group to which the datafactory belongs. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the data factory. |
| <a name="output_identity"></a> [identity](#output\_identity) | The name of the data factory. |
| <a name="output_name"></a> [name](#output\_name) | The name of the data factory. |
| <a name="output_service_principal_object_id"></a> [service\_principal\_object\_id](#output\_service\_principal\_object\_id) | The Service Principal / Object ID that the Data Factory runs as. |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |
| [azurerm_data_factory_linked_service_data_lake_storage_gen2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_linked_service_data_lake_storage_gen2) | resource |
| [azurerm_data_factory_managed_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_managed_private_endpoint) | resource |
| [azurerm_monitor_metric_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_storage_account.datalake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_contributor_access"></a> [contributor\_access](#module\_contributor\_access) | ../role-assignment | n/a |
| <a name="module_datafactory_group"></a> [datafactory\_group](#module\_datafactory\_group) | ../ad-group | n/a |
| <a name="module_datalake_access"></a> [datalake\_access](#module\_datalake\_access) | ../role-assignment | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |
| <a name="module_pipeline_failure_action_group"></a> [pipeline\_failure\_action\_group](#module\_pipeline\_failure\_action\_group) | ../monitor-action-group | n/a |
| <a name="module_warehouse_access"></a> [warehouse\_access](#module\_warehouse\_access) | ../role-assignment | n/a |

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
