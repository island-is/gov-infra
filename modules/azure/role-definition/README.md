# role-definition

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The Scope to which the Role Definition applies.<br>  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/scope-overview | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_assignable_scopes"></a> [assignable\_scopes](#input\_assignable\_scopes) | One or more assignable scopes for this Role Definition.<br>  See: https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions#assignablescopes | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The Description of the Role Definition. | `string` | `""` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | One or more Permissions for this Role Definition. | <pre>object({<br>    actions          = optional(list(string))<br>    not_actions      = optional(list(string))<br>    data_actions     = optional(list(string))<br>    not_data_actions = optional(list(string))<br>  })</pre> | <pre>{<br>  "actions": [<br>    "Microsoft.Storage/storageAccounts/write",<br>    "Microsoft.Web/ServerFarms/write",<br>    "Microsoft.Web/Sites/write",<br>    "Microsoft.Logic/workflows/read",<br>    "Microsoft.Logic/workflows/write",<br>    "Microsoft.Logic/workflows/delete"<br>  ]<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_definition_resource_id"></a> [role\_definition\_resource\_id](#output\_role\_definition\_resource\_id) | The ID of the role definition resource. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the role. |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

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
