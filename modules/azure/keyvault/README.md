# keyvault

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                   | Type                                                                                                   | Default                              | Required |
| --------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------ | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                                             | The instance of the environment                                                                                                                                                                                                                                                                                                                               | `string`                                                                                               | n/a                                  |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                                             | The organisation code for the environment                                                                                                                                                                                                                                                                                                                     | `string`                                                                                               | n/a                                  |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info)                            | The name and location of the Resource Group into which the Key Vault should be placed.                                                                                                                                                                                                                                                                        | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a                                  |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                                         | Tier identifier (e.g. dev, test, prod)                                                                                                                                                                                                                                                                                                                        | `string`                                                                                               | n/a                                  |   yes    |
| <a name="input_keyvault_admin_principal_id"></a> [keyvault_admin_principal_id](#input_keyvault_admin_principal_id)    | The Object ID of the user or service principal that should be granted Key Vault Administrator permissions<br>  DEPRECATED: Use keyvault_admin_ids (a list) instead.                                                                                                                                                                                           | `string`                                                                                               | `null`                               |    no    |
| <a name="input_keyvault_admin_principal_ids"></a> [keyvault_admin_principal_ids](#input_keyvault_admin_principal_ids) | List of Object IDs of the users or service principals that should be granted Key Vault Administrator permissions                                                                                                                                                                                                                                              | `list(string)`                                                                                         | `[]`                                 |    no    |
| <a name="input_keyvault_ip_whitelist"></a> [keyvault_ip_whitelist](#input_keyvault_ip_whitelist)                      | List of IP addresses that should be whitelisted to access the Key Vault                                                                                                                                                                                                                                                                                       | `list(string)`                                                                                         | <pre>\[<br>  "0.0.0.0/0"<br>\]</pre> |    no    |
| <a name="input_keyvault_name_override"></a> [keyvault_name_override](#input_keyvault_name_override)                   | Override the name of the Key Vault. Leave blank to use the default naming convention.                                                                                                                                                                                                                                                                         | `string`                                                                                               | `null`                               |    no    |
| <a name="input_keyvault_secret_contributors"></a> [keyvault_secret_contributors](#input_keyvault_secret_contributors) | A map of free-form identifiers to Entra Object IDs of Entra Users / Service Principals / Managed Identities that should be granted Key Vault Secret **Contributor** permissions.<br>  Example:<pre>.hcl<br>    {<br>        "Group Name"   = "<user-entra-object-id>"<br>        "Data Factory" = "<data-factory-service-principal-object-id>"<br>    }</pre> | `map(string)`                                                                                          | `{}`                                 |    no    |
| <a name="input_keyvault_secret_readers"></a> [keyvault_secret_readers](#input_keyvault_secret_readers)                | A map of free-form identifiers to Entra Object IDs of Entra Users / Service Principals / Managed Identities that should be granted Key Vault Secret **Reader** permissions.<br>  Example:<pre>.hcl<br>    {<br>        "Group Name"   = "<user-entra-object-id>"<br>        "Data Factory" = "<data-factory-service-principal-object-id>"<br>    }</pre>      | `map(string)`                                                                                          | `{}`                                 |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                         | Any tags that should be present on created resources. Will get merged with local.default_tags                                                                                                                                                                                                                                                                 | `map(string)`                                                                                          | `{}`                                 |    no    |
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id)                                                          | The Azure AD tenant ID that should be used for authenticating requests to the key vault. Leave blank to use the current Tenant ID                                                                                                                                                                                                                             | `string`                                                                                               | `""`                                 |    no    |

## Outputs

| Name                                                                          | Description          |
| ----------------------------------------------------------------------------- | -------------------- |
| <a name="output_key_vault_id"></a> [key_vault_id](#output_key_vault_id)       | ID of the KeyVault   |
| <a name="output_key_vault_name"></a> [key_vault_name](#output_key_vault_name) | Name of the KeyVault |

## Resources

| Name                                                                                                                                                   | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)                                    | resource    |
| [azurerm_key_vault_access_policy.admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)       | resource    |
| [azurerm_key_vault_access_policy.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource    |
| [azurerm_key_vault_access_policy.reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)      | resource    |
| [azurerm_role_assignment.kv_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                    | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)                      | data source |

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
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.83.0  |

<!-- /TERRAFORM_DOCS_BLOCK -->
