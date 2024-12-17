# Azure Data Lakehouse

This module provisions a [Data Lakehouse](https://learn.microsoft.com/en-us/azure/databricks/lakehouse/) in Azure,
by employing the following Azure resources:

- Datalake as an [Azure Storage Account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- ETL via [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/introduction)
- Data Warehousing
  via [Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview)
- API Access
  via [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts)

______________________________________________________________________

## Access Patterns

The module provisions Azure Roles and Role Assignments alongside Active Directory Groups to allow for the following
access patterns:

### Data Factory Contributor

### Data Warehouse Admins

______________________________________________________________________

## Considerations

### Azure Data Factory Github Integration

Azure Data Factory has a [Github Integration](https://docs.microsoft.com/en-us/azure/data-factory/source-control) that
allows us to store our Data Factory configuration in a Github repository.
Though we are able to configure it, we are not able to automatically authenticate against it.

This is left to the user to do manually, by following the steps outlined in
the [Azure Data Factory Github Integration](https://docs.microsoft.com/en-us/azure/data-factory/source-control#configure-github-integration)
documentation.

## Troubleshooting

### Key Vault access issues:

#### Symptom:

Sometimes, when applying, you might get an error like this:

```txt
Error: checking for presence of existing Key "[KEY NAME]" (Key Vault "[KEY VAULT FQDN]"):
keyvault.BaseClient#GetKey: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error.
Status=403 Code="Forbidden" Message="The user, group or application '[...]' does not have keys get permission on key vault '[NAME OF KEYVAULT];location=northeurope'.
[...]
InnerError={"code":"AccessDenied"}
```

#### Probable cause:

Key Vault Access Controls often take a while to propagate. This can cause issues when trying to access a newly created
Key Vault.

#### Resolution:

Wait a few minutes and try again.
If that does not work, review the access policies for the Key Vault and make sure that the access policies are correctly
configured.

### Key Vault Firewall issues:

#### Symptom

Sometimes, when applying, you might get an error like this:

```txt
Error: checking for presence of existing Key "[KEY NAME]" (Key Vault "[KEY VAULT FQDN]):
keyvault.BaseClient#GetKey: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error.
Status=403 Code="Forbidden" Message="Client address is not authorized and caller is not a trusted service.
[...]
InnerError={"code":"ForbiddenByFirewall"}
```

#### Probable cause:

The Network Access / Firewall rules for the Key Vault might be blocking your acess.

#### Resolution:

Add your IP to the Key Vault Firewall rules.

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_contact_emails"></a> [budget\_contact\_emails](#input\_budget\_contact\_emails) | Emails to send budget notifications to | `list(string)` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Instance name | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Organization code | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier of the environment | `string` | n/a | yes |
| <a name="input_warehouse_config"></a> [warehouse\_config](#input\_warehouse\_config) | `sku_name` - The sku-name for the datawarehouse. This controls the sku-name that will be used for the SQL Server Database. sku-names vary across regions and offerings, run `az sql db list-editions -l [your region] -o table` to see available options.<br>    `max_size_gb` - This controls the max-size-gb setting, i.e. how much storage to allocate for the SQL Server Database.<br>    `zone_redundant` - Whether the datawarehouse should be zone-redundant. This controls the zone-redundant setting that will be used for the SQL Server Database. Be aware that might not be available for all sku's.<br>    `admin_group_id (optional)` - The name of an existing AD Group that should be used as an admin to the datawarehouse. If this is not set, a new AD Group will be created.<br>    `collation (optional)` - The collation to use for the datawarehouse. This controls the collation that will be used for the SQL Server Database.<br>    `ip_whitelist (optional)` - A list of maps containing ip\_address / name pairs to whitelist for the datalakehouse | <pre>object({<br>    sku_name         = string<br>    max_size_gb      = optional(number, 500)<br>    zone_redundant   = optional(bool, true)<br>    admin_group_name = optional(string, "")<br>    collation        = optional(string, "Icelandic_100_CI_AS")<br>    ip_whitelist     = optional(list(any), [])<br>  })</pre> | n/a | yes |
| <a name="input_adf_contributors"></a> [adf\_contributors](#input\_adf\_contributors) | A list of AD Object ID's that are allowed to contribute to the Data Factory | <pre>list(object({<br>    purpose      = string<br>    principal_id = string<br>  }))</pre> | `null` | no |
| <a name="input_adf_git_backend_config"></a> [adf\_git\_backend\_config](#input\_adf\_git\_backend\_config) | Configuration for the github repository | <pre>object({<br>    type = string # must be either "github" or "azuredevops"<br><br>    account_name    = string<br>    branch_name     = string<br>    repository_name = string<br>    root_folder     = string<br><br>    # Required for Github<br>    git_url = optional(string)<br><br>    # Required for Azure DevOps<br>    project_name = optional(string)<br>    tenant_id    = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_alert_contact_emails"></a> [alert\_contact\_emails](#input\_alert\_contact\_emails) | A list of emails to send alerts to on pipeline failure | `list(string)` | `[]` | no |
| <a name="input_alert_on_pipeline_failure"></a> [alert\_on\_pipeline\_failure](#input\_alert\_on\_pipeline\_failure) | Whether to alert on pipeline failure | `bool` | `false` | no |
| <a name="input_api_management_config"></a> [api\_management\_config](#input\_api\_management\_config) | `sku_name` - SKU name for the API management instance<br>  `sku_capacity` - SKU capacity for the API management instance<br>  `publisher_name` - Publisher name for the API management instance<br>  `publisher_email` - Publisher email for the API management instance | <pre>object({<br>    sku_name        = optional(string, "Developer")<br>    sku_capacity    = optional(number, 1)<br>    publisher_name  = optional(string, "<your name>")<br>    publisher_email = optional(string, "")<br>  })</pre> | `null` | no |
| <a name="input_budget_for_resource_group"></a> [budget\_for\_resource\_group](#input\_budget\_for\_resource\_group) | Budget for the resource group | `number` | `50` | no |
| <a name="input_create_adf_group"></a> [create\_adf\_group](#input\_create\_adf\_group) | Whether to create a group for the Data Factory. | `bool` | `true` | no |
| <a name="input_datalake_whitelisted_cidrs"></a> [datalake\_whitelisted\_cidrs](#input\_datalake\_whitelisted\_cidrs) | A list of CIDRs to whitelist for the datalake | `list(string)` | `[]` | no |
| <a name="input_datalakehouse_admins"></a> [datalakehouse\_admins](#input\_datalakehouse\_admins) | A list of Azure AD User Principal ID's that are allowed to administer the Data Lakehouse. | `list(string)` | `[]` | no |
| <a name="input_datalakehouse_contributor_can_contribute_to_keyvault"></a> [datalakehouse\_contributor\_can\_contribute\_to\_keyvault](#input\_datalakehouse\_contributor\_can\_contribute\_to\_keyvault) | Whether the data engineers should be able to contribute to the key vault. | `bool` | `false` | no |
| <a name="input_datalakehouse_contributor_group_name"></a> [datalakehouse\_contributor\_group\_name](#input\_datalakehouse\_contributor\_group\_name) | The name of an existing AD Group that should be used as a contributor to the datalakehouse.<br>  If this is not set, a new AD Group will be created. | `string` | `""` | no |
| <a name="input_datalakehouse_contributors"></a> [datalakehouse\_contributors](#input\_datalakehouse\_contributors) | Contributors to the datalakehouse | `list(string)` | `[]` | no |
| <a name="input_existing_audit_keyvault_id"></a> [existing\_audit\_keyvault\_id](#input\_existing\_audit\_keyvault\_id) | An existing Keyvault to use for audit logs. If not provided, a new one will be created. | `string` | `null` | no |
| <a name="input_existing_resource_group_info"></a> [existing\_resource\_group\_info](#input\_existing\_resource\_group\_info) | An existing Resource Group to use. If not provided, a new one will be created. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | `null` | no |
| <a name="input_features"></a> [features](#input\_features) | Features to enable or disable. | <pre>object({<br>    api_management = optional(bool, true)<br>    datawarehouse  = optional(bool, true)<br>    data_factory   = optional(bool, true)<br>    datalake       = optional(bool, true)<br>    keyvault       = optional(bool, true)<br>  })</pre> | <pre>{<br>  "api_management": true,<br>  "data_factory": true,<br>  "datalake": true,<br>  "datawarehouse": true,<br>  "keyvault": true<br>}</pre> | no |
| <a name="input_keyvault_ip_whitelist"></a> [keyvault\_ip\_whitelist](#input\_keyvault\_ip\_whitelist) | IP addresses to whitelist for the keyvault | `list(string)` | `[]` | no |
| <a name="input_name_overrides"></a> [name\_overrides](#input\_name\_overrides) | Map of resource names to override. If not set, the name will be generated from the instance name.<br>  This variable is an escape hatch for some naming scheme conflicts that can occur and should, ideally, not be used.<br>  The schema for this variable is defined inside resource and service modules and is not documented here. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on created resources. Will get merged with local.default\_tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datafactory_info"></a> [datafactory\_info](#output\_datafactory\_info) | The Data Factory Info |
| <a name="output_datalake_info"></a> [datalake\_info](#output\_datalake\_info) | The Data Lake Info |
| <a name="output_datalakehouse_contributor_group_info"></a> [datalakehouse\_contributor\_group\_info](#output\_datalakehouse\_contributor\_group\_info) | The Data Lakehouse Contributor group |
| <a name="output_datalakehouse_warehouse_admin_group_info"></a> [datalakehouse\_warehouse\_admin\_group\_info](#output\_datalakehouse\_warehouse\_admin\_group\_info) | The Data Lakehouse Warehouse Admin group |
| <a name="output_datalakehouse_warehouse_connection_info"></a> [datalakehouse\_warehouse\_connection\_info](#output\_datalakehouse\_warehouse\_connection\_info) | The Data Lakehouse Warehouse Connection Info |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azuread_user.datalakehouse_contributors](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_management"></a> [api\_management](#module\_api\_management) | ../../modules/azure/api-management | n/a |
| <a name="module_base_setup"></a> [base\_setup](#module\_base\_setup) | ../../modules/azure/base-setup | n/a |
| <a name="module_data_engineer_role"></a> [data\_engineer\_role](#module\_data\_engineer\_role) | ../../modules/azure/role-definition | n/a |
| <a name="module_data_engineer_user_group"></a> [data\_engineer\_user\_group](#module\_data\_engineer\_user\_group) | ../../modules/azure/ad-group | n/a |
| <a name="module_data_lakehouse_role_assignments"></a> [data\_lakehouse\_role\_assignments](#module\_data\_lakehouse\_role\_assignments) | ../../modules/azure/role-assignment | n/a |
| <a name="module_datafactory"></a> [datafactory](#module\_datafactory) | ../../modules/azure/datafactory | n/a |
| <a name="module_datalake"></a> [datalake](#module\_datalake) | ../../modules/azure/datalake | n/a |
| <a name="module_datawarehouse"></a> [datawarehouse](#module\_datawarehouse) | ../../modules/azure/datawarehouse | n/a |
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../modules/skyvafnir/defaults | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../../modules/azure/keyvault | n/a |
| <a name="module_logic_apps_base"></a> [logic\_apps\_base](#module\_logic\_apps\_base) | ../../modules/azure/base-setup | n/a |
| <a name="module_warehouse_admin_group"></a> [warehouse\_admin\_group](#module\_warehouse\_admin\_group) | ../../modules/azure/ad-group | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >=2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.51.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.107.0 |

<!-- /TERRAFORM_DOCS_BLOCK -->
