# datalake

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datalake_contributor_group_id"></a> [datalake\_contributor\_group\_id](#input\_datalake\_contributor\_group\_id) | Object ID of the Azure AD Group that should be granted Contributor permissions on the datalake | `string` | n/a | yes |
| <a name="input_datalake_ip_whitelist"></a> [datalake\_ip\_whitelist](#input\_datalake\_ip\_whitelist) | List of IP addresses to whitelist for access to the datalake | `list(string)` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | ID of the key vault to use for secrets | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | The organisation code for the environment | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The id, name and location of the Resource Group into which the Datalake should be placed. | <pre>object({<br>    id       = optional(string)<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_keyvault_key_name_override"></a> [keyvault\_key\_name\_override](#input\_keyvault\_key\_name\_override) | Override the name of the keyvault key to use for encryption | `string` | `null` | no |
| <a name="input_private_link_access_endpoint_resource_ids"></a> [private\_link\_access\_endpoint\_resource\_ids](#input\_private\_link\_access\_endpoint\_resource\_ids) | List of resource IDs to grant access to the datalake via private link | `list(string)` | `[]` | no |
| <a name="input_provision_fileshare"></a> [provision\_fileshare](#input\_provision\_fileshare) | Whether to provision a fileshare in the datalake | `bool` | `false` | no |
| <a name="input_storage_account_name_override"></a> [storage\_account\_name\_override](#input\_storage\_account\_name\_override) | Override the name of the Storage Account to use for the datalake | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | ID of the tenant to use for secrets | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datalake_id"></a> [datalake\_id](#output\_datalake\_id) | The ID of the Data Lake |
| <a name="output_datalake_location"></a> [datalake\_location](#output\_datalake\_location) | The location of the Data Lake |
| <a name="output_datalake_name"></a> [datalake\_name](#output\_datalake\_name) | The name of the Data Lake |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_contributor_access"></a> [contributor\_access](#module\_contributor\_access) | ../role-assignment | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |
| <a name="module_fileshare_contributor_role_assignment"></a> [fileshare\_contributor\_role\_assignment](#module\_fileshare\_contributor\_role\_assignment) | ../role-assignment | n/a |
| <a name="module_fileshare_role"></a> [fileshare\_role](#module\_fileshare\_role) | ../role-definition | n/a |
| <a name="module_naming_storage_account"></a> [naming\_storage\_account](#module\_naming\_storage\_account) | Azure/naming/azurerm | 0.2.0 |

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
