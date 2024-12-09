# storage-account

### a Skývafnir Terraform Module

Provision a storage account in Azure.

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | For what purpose is this module being used? | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Organization code | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | Name and Location of the Resource Group | <pre>object({<br>    id       = optional(string)<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS | `string` | `"LRS"` | no |
| <a name="input_account_soft_delete_retention_days"></a> [account\_soft\_delete\_retention\_days](#input\_account\_soft\_delete\_retention\_days) | The number of days that the soft-deleted blob will be retained. Must be set between 1 and 365. Set to 0 to disable soft delete. Defaults to 0. | `number` | `0` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. Defaults to Standard. | `string` | `"Standard"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | The identity block for the storage account | <pre>object({<br>    type         = optional(string, "SystemAssigned")<br>    identity_ids = optional(list(string), null)<br>  })</pre> | `null` | no |
| <a name="input_logging_properties"></a> [logging\_properties](#input\_logging\_properties) | The logging properties for the storage account | <pre>object({<br>    delete                = bool<br>    read                  = bool<br>    version               = string<br>    write                 = bool<br>    retention_policy_days = number<br>  })</pre> | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum TLS version to use for the storage account | `string` | `"TLS1_2"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Controls whether data may be accessed from public networks. | `bool` | `true` | no |
| <a name="input_storage_account_name_override"></a> [storage\_account\_name\_override](#input\_storage\_account\_name\_override) | Override the storage account name. If not set, the storage account name will be autogenerated based on the org\_code, instance and tier. | `string` | `null` | no |
| <a name="input_storage_container_config"></a> [storage\_container\_config](#input\_storage\_container\_config) | Configuration for the storage containers | <pre>object({<br>    name                  = string<br>    container_access_type = string<br>    metadata              = map(string)<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity"></a> [identity](#output\_identity) | The identity of the storage account |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key of the storage account |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The primary blob endpoint for the storage account |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key of the storage account |
| <a name="output_secondary_blob_endpoint"></a> [secondary\_blob\_endpoint](#output\_secondary\_blob\_endpoint) | The secondary blob endpoint for the storage account |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The ID of the resource group |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | The name of the storage container - if provisioned |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../skyvafnir/defaults | n/a |
| <a name="module_naming_storage_account"></a> [naming\_storage\_account](#module\_naming\_storage\_account) | Azure/naming/azurerm | 0.2.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.103.1 |

<!-- /TERRAFORM_DOCS_BLOCK -->