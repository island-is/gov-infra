# app-service

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                         | Description                                                                                   | Type                                                                                                   | Default | Required |
| ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                                    | Identifier for the application, workload or service                                           | `string`                                                                                               | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                    | Org code                                                                                      | `string`                                                                                               | n/a     |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info)                   | The name and location of the Resource Group into which the app service should be placed.      | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a     |   yes    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                                 | The ID of the subnet into which the app service should be placed.                             | `string`                                                                                               | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                                | The tier of the environment (e.g. test, prod)                                                 | `string`                                                                                               | n/a     |   yes    |
| <a name="input_app_service_name_override"></a> [app_service_name_override](#input_app_service_name_override) | Override the name of the app service. If not set, the name will be generated.                 | `string`                                                                                               | `""`    |    no    |
| <a name="input_app_settings"></a> [app_settings](#input_app_settings)                                        | A map of app settings to be applied to the app service.                                       | `map(string)`                                                                                          | `{}`    |    no    |
| <a name="input_dotnet_version"></a> [dotnet_version](#input_dotnet_version)                                  | The version of .NET to use for the web app.                                                   | `string`                                                                                               | `"8.0"` |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                | Any tags that should be present on created resources. Will get merged with local.default_tags | `map(string)`                                                                                          | `{}`    |    no    |

## Outputs

| Name                                                                                                                                   | Description                                                      |
| -------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| <a name="output_app_service_identity_principal_id"></a> [app_service_identity_principal_id](#output_app_service_identity_principal_id) | The principal ID of the identity associated with the App Service |
| <a name="output_app_service_identity_tenant_id"></a> [app_service_identity_tenant_id](#output_app_service_identity_tenant_id)          | The tenant ID of the identity associated with the App Service    |

## Resources

| Name                                                                                                                                            | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)       | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)                     | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan)                       | resource |

## Modules

| Name                                                        | Source                   | Version |
| ----------------------------------------------------------- | ------------------------ | ------- |
| <a name="module_defaults"></a> [defaults](#module_defaults) | ../../skyvafnir/defaults | n/a     |

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.1  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >=3.0   |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.90.0  |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
# Module scaffolded via skyvafnir-module-template
Author:    jonorrikristjansson
Version:   0.1.0
Timestamp: 2024-01-17T13:33:48
-->
