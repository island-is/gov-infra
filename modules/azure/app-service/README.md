# app-service

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The name and location of the Resource Group into which the app service should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet into which the app service should be placed. | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_app_service_environment_enabled"></a> [app\_service\_environment\_enabled](#input\_app\_service\_environment\_enabled) | Enable the app service environment for the app service. | `bool` | `false` | no |
| <a name="input_app_service_name_override"></a> [app\_service\_name\_override](#input\_app\_service\_name\_override) | Override the name of the app service. If not set, the name will be generated. | `string` | `""` | no |
| <a name="input_app_service_plan_name_override"></a> [app\_service\_plan\_name\_override](#input\_app\_service\_plan\_name\_override) | Override the name of the app service plan. If not set, the name will be generated. | `string` | `""` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of app settings to be applied to the app service. | `map(string)` | `{}` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | A map of connection strings to be applied to the app service. | `map(string)` | `{}` | no |
| <a name="input_contributor_principal_ids"></a> [contributor\_principal\_ids](#input\_contributor\_principal\_ids) | A list of principal IDs that should be granted contributor access to the app service. | `list(string)` | `[]` | no |
| <a name="input_dotnet_version"></a> [dotnet\_version](#input\_dotnet\_version) | The version of .NET to use for the web app. | `string` | `"8.0"` | no |
| <a name="input_existing_service_plan_id"></a> [existing\_service\_plan\_id](#input\_existing\_service\_plan\_id) | The ID of an existing App Service Plan to use for the app service. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_fqdn"></a> [app\_service\_fqdn](#output\_app\_service\_fqdn) | The FQDN of the App Service |
| <a name="output_app_service_identity_principal_id"></a> [app\_service\_identity\_principal\_id](#output\_app\_service\_identity\_principal\_id) | The principal ID of the identity associated with the App Service |
| <a name="output_app_service_identity_tenant_id"></a> [app\_service\_identity\_tenant\_id](#output\_app\_service\_identity\_tenant\_id) | The tenant ID of the identity associated with the App Service |
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | The ID of the App Service Plan |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_environment_v3.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.107.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
-->
