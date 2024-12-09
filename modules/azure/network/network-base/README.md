# network-base

<!-- TERRAFORM_DOCS_BLOCK -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | Identifier for the application, workload or service | `string` | n/a | yes |
| <a name="input_org_code"></a> [org\_code](#input\_org\_code) | Org code | `string` | n/a | yes |
| <a name="input_resource_group_info"></a> [resource\_group\_info](#input\_resource\_group\_info) | The name and location of the Resource Group into which the app service should be placed. | <pre>object({<br>    id       = string<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A map of security group rules to create. The key is the name of the rule.<br>  Example:<br>  security\_group\_rules = {<br>    "Allow-All-Inbound" : {<br>      description = "Allow all inbound traffic"<br>      access = "Allow"<br>      direction = "Inbound"<br>      priority = 100<br>      protocol = "Tcp"<br>      source\_port\_range = "*"<br>      destination\_port\_range = "*"<br>      source\_address\_prefix = "*" \| "AzureDevOps"<br>      destination\_address\_prefix = "*"<br>    }<br>  } | <pre>map(object({<br>    protocol  = string<br>    priority  = number<br>    direction = string<br>    access    = string<br><br>    description                  = optional(string)<br>    source_port_range            = optional(string)<br>    destination_port_range       = optional(string)<br>    source_address_prefix        = optional(string)<br>    source_address_prefixes      = optional(list(string))<br>    destination_address_prefix   = optional(string)<br>    destination_address_prefixes = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | The CIDR of the default subnet | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the environment (e.g. test, prod) | `string` | n/a | yes |
| <a name="input_virtual_network_cidr"></a> [virtual\_network\_cidr](#input\_virtual\_network\_cidr) | The CIDR of the Virtual Network | `string` | n/a | yes |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Create a NAT Gateway | `bool` | `false` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | A list of delegations to create for the subnet | <pre>list(object({<br>    name = string<br>    service_delegation = object({<br>      name    = string<br>      actions = list(string)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_private_dns_suffix"></a> [private\_dns\_suffix](#input\_private\_dns\_suffix) | The private DNS suffix of the Azure region | `string` | `"private.northeurope.azmk8s.io"` | no |
| <a name="input_public_ip_name_override"></a> [public\_ip\_name\_override](#input\_public\_ip\_name\_override) | The name override of the public IP address | `string` | `""` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | A list of service endpoints to enable on the subnet | `list(string)` | `[]` | no |
| <a name="input_subnet_name_override"></a> [subnet\_name\_override](#input\_subnet\_name\_override) | The name override of the subnet | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vnet_name_override"></a> [vnet\_name\_override](#input\_vnet\_name\_override) | The name override of the virtual network | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_resource_group_location"></a> [azure\_resource\_group\_location](#output\_azure\_resource\_group\_location) | The azure\_resource\_group\_location |
| <a name="output_private_zone_name"></a> [private\_zone\_name](#output\_private\_zone\_name) | Private DNS zone for this VNET |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The subnet\_id |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The subnet\_name |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The virtual\_network\_id |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The virtual\_network\_name |

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.default_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.local](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defaults"></a> [defaults](#module\_defaults) | ../../../skyvafnir/defaults | n/a |

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
