# role-assignment

_Assigns a Built-In or Custom Role to a User, Group or Service Principal_

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                    | Description                                                                                                                                                                                                                                        | Type          | Default | Required |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                               | Identifier for the application, workload or service                                                                                                                                                                                                | `string`      | n/a     |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                               | Org code                                                                                                                                                                                                                                           | `string`      | n/a     |   yes    |
| <a name="input_principal_id"></a> [principal_id](#input_principal_id)                   | The principal ID to assign the role to.                                                                                                                                                                                                            | `string`      | n/a     |   yes    |
| <a name="input_scope"></a> [scope](#input_scope)                                        | The ID of the scope at which the role should be assigned.                                                                                                                                                                                          | `string`      | n/a     |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                           | The tier of the environment (e.g. test, prod)                                                                                                                                                                                                      | `string`      | n/a     |   yes    |
| <a name="input_description"></a> [description](#input_description)                      | The description of the role assignment.                                                                                                                                                                                                            | `string`      | `""`    |    no    |
| <a name="input_role_definition_id"></a> [role_definition_id](#input_role_definition_id) | The Policy Definition ID of the policy to assign. This is required if builtin_role_name is not set.<br>  NOTE: This is the `role_definition_resource_id` property of the `azurerm_role_definition`, not the `id` or `role_definition_id` property. | `string`      | `null`  |    no    |
| <a name="input_role_name"></a> [role_name](#input_role_name)                            | The name of the policy to assign. This is required if role_definition_id is not set.                                                                                                                                                               | `string`      | `null`  |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                           | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                                                                                      | `map(string)` | `{}`    |    no    |

## Resources

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

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
Timestamp: 2023-06-07T15:57:07
-->
