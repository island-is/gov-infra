# role-definition

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                 | Description                                                                                                                                                           | Type                                                                                                                                                                                                                            | Default                                                                                                                                                                                                                                                                                                   | Required |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                            | Identifier for the application, workload or service                                                                                                                   | `string`                                                                                                                                                                                                                        | n/a                                                                                                                                                                                                                                                                                                       |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                            | Org code                                                                                                                                                              | `string`                                                                                                                                                                                                                        | n/a                                                                                                                                                                                                                                                                                                       |   yes    |
| <a name="input_scope"></a> [scope](#input_scope)                                     | The Scope to which the Role Definition applies.<br>  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/scope-overview                            | `string`                                                                                                                                                                                                                        | n/a                                                                                                                                                                                                                                                                                                       |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                        | The tier of the environment (e.g. test, prod)                                                                                                                         | `string`                                                                                                                                                                                                                        | n/a                                                                                                                                                                                                                                                                                                       |   yes    |
| <a name="input_assignable_scopes"></a> [assignable_scopes](#input_assignable_scopes) | One or more assignable scopes for this Role Definition.<br>  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions#assignablescopes | `list(string)`                                                                                                                                                                                                                  | `[]`                                                                                                                                                                                                                                                                                                      |    no    |
| <a name="input_description"></a> [description](#input_description)                   | The Description of the Role Definition.                                                                                                                               | `string`                                                                                                                                                                                                                        | `""`                                                                                                                                                                                                                                                                                                      |    no    |
| <a name="input_permissions"></a> [permissions](#input_permissions)                   | One or more Permissions for this Role Definition.                                                                                                                     | <pre>object({<br>    actions          = optional(list(string))<br>    not_actions      = optional(list(string))<br>    data_actions     = optional(list(string))<br>    not_data_actions = optional(list(string))<br>  })</pre> | <pre>{<br>  "actions": \[<br>    "Microsoft.Storage/storageAccounts/write",<br>    "Microsoft.Web/ServerFarms/write",<br>    "Microsoft.Web/Sites/write",<br>    "Microsoft.Logic/workflows/read",<br>    "Microsoft.Logic/workflows/write",<br>    "Microsoft.Logic/workflows/delete"<br>  \]<br>}</pre> |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                        | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                         | `map(string)`                                                                                                                                                                                                                   | `{}`                                                                                                                                                                                                                                                                                                      |    no    |

## Outputs

| Name                                                                                                                 | Description                             |
| -------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| <a name="output_role_definition_resource_id"></a> [role_definition_resource_id](#output_role_definition_resource_id) | The ID of the role definition resource. |
| <a name="output_role_name"></a> [role_name](#output_role_name)                                                       | The name of the role.                   |

## Resources

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

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
Author:    gzur
Version:   0.1.0
Timestamp: 2023-08-09T13:38:32
-->
