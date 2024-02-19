# network-base

<!-- TERRAFORM_DOCS_BLOCK -->

## Inputs

| Name                                                                                                   | Description                                                                              | Type                                                                                                   | Default                           | Required |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | --------------------------------- | :------: |
| <a name="input_instance"></a> [instance](#input_instance)                                              | Identifier for the application, workload or service                                      | `string`                                                                                               | n/a                               |   yes    |
| <a name="input_org_code"></a> [org_code](#input_org_code)                                              | Org code                                                                                 | `string`                                                                                               | n/a                               |   yes    |
| <a name="input_resource_group_info"></a> [resource_group_info](#input_resource_group_info)             | The name and location of the Resource Group into which the app service should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a                               |   yes    |
| <a name="input_subnet_cidr"></a> [subnet_cidr](#input_subnet_cidr)                                     | The CIDR of the default subnet                                                           | `string`                                                                                               | n/a                               |   yes    |
| <a name="input_tier"></a> [tier](#input_tier)                                                          | The tier of the environment (e.g. test, prod)                                            | `string`                                                                                               | n/a                               |   yes    |
| <a name="input_virtual_network_cidr"></a> [virtual_network_cidr](#input_virtual_network_cidr)          | The CIDR of the Virtual Network                                                          | `string`                                                                                               | n/a                               |   yes    |
| <a name="input_create_delegation"></a> [create_delegation](#input_create_delegation)                   | Create a delegation for the subnet                                                       | `bool`                                                                                                 | `false`                           |    no    |
| <a name="input_create_nat_gateway"></a> [create_nat_gateway](#input_create_nat_gateway)                | Create a NAT Gateway                                                                     | `bool`                                                                                                 | `false`                           |    no    |
| <a name="input_private_dns_suffix"></a> [private_dns_suffix](#input_private_dns_suffix)                | The private DNS suffix of the Azure region                                               | `string`                                                                                               | `"private.northeurope.azmk8s.io"` |    no    |
| <a name="input_public_ip_name_override"></a> [public_ip_name_override](#input_public_ip_name_override) | The name override of the public IP address                                               | `string`                                                                                               | `""`                              |    no    |
| <a name="input_service_endpoints"></a> [service_endpoints](#input_service_endpoints)                   | A list of service endpoints to enable on the subnet                                      | `list(string)`                                                                                         | `[]`                              |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                          | A map of tags to add to all resources                                                    | `map(string)`                                                                                          | `{}`                              |    no    |
| <a name="input_vnet_name_override"></a> [vnet_name_override](#input_vnet_name_override)                | The name override of the virtual network                                                 | `string`                                                                                               | `""`                              |    no    |

## Outputs

| Name                                                                                                                       | Description                       |
| -------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| <a name="output_azure_resource_group_location"></a> [azure_resource_group_location](#output_azure_resource_group_location) | The azure_resource_group_location |
| <a name="output_private_zone_name"></a> [private_zone_name](#output_private_zone_name)                                     | Private DNS zone for this VNET    |
| <a name="output_subnet_id"></a> [subnet_id](#output_subnet_id)                                                             | The subnet_id                     |
| <a name="output_subnet_name"></a> [subnet_name](#output_subnet_name)                                                       | The subnet_name                   |
| <a name="output_virtual_network_id"></a> [virtual_network_id](#output_virtual_network_id)                                  | The virtual_network_id            |
| <a name="output_virtual_network_name"></a> [virtual_network_name](#output_virtual_network_name)                            | The virtual_network_name          |

## Resources

| Name                                                                                                                                                                         | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway)                                                      | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association)          | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)                                            | resource |
| [azurerm_private_dns_zone_virtual_network_link.local](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                                          | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)                                              | resource |

## Modules

| Name                                                        | Source                      | Version |
| ----------------------------------------------------------- | --------------------------- | ------- |
| <a name="module_defaults"></a> [defaults](#module_defaults) | ../../../skyvafnir/defaults | n/a     |

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
