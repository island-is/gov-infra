# azuread-group

### a Skývafnir Terraform Module

This module provisions a Group in Azure Active Directory.

## API Permissions

The following API permissions are required in order to use this resource.

When authenticated with a service principal, this resource requires one of the following application roles: `Group.ReadWrite.All` or `Directory.ReadWrite.All`.

Alternatively, if the authenticated service principal is also an owner of the group being managed, this resource can use the application role: `Group.Create`.

_For more information on this, refer to the `azuread_group` terraform resource documentation: <https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group#api-permissions>_

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_owner_principal_ids"></a> [group\_owner\_principal\_ids](#input\_group\_owner\_principal\_ids) | List of owners of the group.<br>  If empty, the group will be owned by the provisioning identity. | `list(string)` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_existing_group_name"></a> [existing\_group\_name](#input\_existing\_group\_name) | The name of an existing group. If set, the module will not create a new group,<br>  but will instead use the existing group as a data source. | `string` | `""` | no |
| <a name="input_group_description"></a> [group\_description](#input\_group\_description) | Description of the group | `string` | `""` | no |
| <a name="input_group_member_principal_ids"></a> [group\_member\_principal\_ids](#input\_group\_member\_principal\_ids) | List of members of the group (optional) | `list(string)` | `[]` | no |
| <a name="input_group_purpose"></a> [group\_purpose](#input\_group\_purpose) | Purpose of the group, i.e. user / admin / job / service. This goes into constructing the name of the group | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_display_name"></a> [group\_display\_name](#output\_group\_display\_name) | The display name of the AD Group. |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The principal ID of the AD Group. |

## Resources

| Name | Type |
|------|------|
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.51.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->

<!--
```
# Module scaffolded via skyvafnir-module-template
Author: skyvafnir 
```
-->
