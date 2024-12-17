# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  resource_abbreviation = "vnet"
}

resource "azurerm_virtual_network" "this" {
  name                = coalesce(var.vnet_name_override, module.defaults.resource_name)
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location
  address_space       = [var.virtual_network_cidr]

  tags = local.tags
}

resource "azurerm_subnet" "this" {
  name                              = coalesce(var.subnet_name_override, "${azurerm_virtual_network.this.name}-subnet-1")
  virtual_network_name              = azurerm_virtual_network.this.name
  resource_group_name               = var.resource_group_info.name
  address_prefixes                  = [var.subnet_cidr]
  private_endpoint_network_policies = "Enabled"

  service_endpoints = var.service_endpoints

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name
      service_delegation {
        actions = delegation.value.service_delegation.actions
        name    = delegation.value.service_delegation.name
      }
    }
  }
}

resource "azurerm_network_security_group" "default" {
  name                = format(module.defaults.resource_name_template, "nsg")
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  tags = local.tags
}

resource "azurerm_network_security_rule" "default_rules" {
  for_each = var.security_group_rules

  name                        = each.key
  protocol                    = each.value.protocol
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  network_security_group_name = azurerm_network_security_group.default.name
  resource_group_name         = var.resource_group_info.name

  description                  = try(each.value.description, null)
  source_port_range            = try(each.value.source_port_range, null)
  destination_port_range       = try(each.value.destination_port_range, null)
  source_address_prefix        = try(each.value.source_address_prefix, null)
  source_address_prefixes      = try(each.value.source_address_prefixes, null)
  destination_address_prefix   = try(each.value.destination_address_prefix, null)
  destination_address_prefixes = try(each.value.destination_address_prefixes, null)
}

resource "azurerm_subnet_network_security_group_association" "default" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.default.id
}

resource "azurerm_private_dns_zone" "this" {
  name                = "${azurerm_virtual_network.this.name}.${var.private_dns_suffix}"
  resource_group_name = var.resource_group_info.name

  tags = local.sliced_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "local" {
  name                  = "local"
  resource_group_name   = var.resource_group_info.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = azurerm_virtual_network.this.id

  tags = local.sliced_tags
}

resource "azurerm_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0

  name                = "${var.org_code}-${var.tier}-${var.instance}-natgw"
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  idle_timeout_in_minutes = 4
  sku_name                = "Standard"

  tags = local.tags
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  count = var.create_nat_gateway ? 1 : 0

  subnet_id      = azurerm_subnet.this.id
  nat_gateway_id = azurerm_nat_gateway.this[0].id
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  count = var.create_nat_gateway ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.this[0].id
  public_ip_address_id = azurerm_public_ip.this[0].id
}

resource "azurerm_public_ip" "this" {
  count = var.create_nat_gateway ? 1 : 0

  name                = var.public_ip_name_override != "" ? var.public_ip_name_override : format(module.defaults.resource_name_template, "ip")
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  sku                     = "Standard"
  sku_tier                = "Regional"

  tags = local.tags
}

locals {
  sliced_tags = merge(
    local.tags,
    {
      "_iac-part-of-module" = null
      "_iac-provisioned-by" = null
      "_iac-support-email"  = null
    }
  )
}
