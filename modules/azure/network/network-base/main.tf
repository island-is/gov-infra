locals {
  resource_abbreviation = "vnet"
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name_override != "" ? var.vnet_name_override : format(module.defaults.resource_name_template, "vnet")
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location
  address_space       = [var.virtual_network_cidr]

  tags = local.tags
}

resource "azurerm_subnet" "this" {
  name                                      = "${azurerm_virtual_network.this.name}-subnet-1"
  virtual_network_name                      = azurerm_virtual_network.this.name
  resource_group_name                       = var.resource_group_info.name
  address_prefixes                          = [var.subnet_cidr]
  private_endpoint_network_policies_enabled = true

  service_endpoints = var.service_endpoints

  dynamic "delegation" {
    for_each = var.create_delegation ? [1] : [0]

    content {
      name = "delegation"

      service_delegation {
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action",
        ]
        name = "Microsoft.Web/serverFarms"
      }
    }
  }
}

resource "azurerm_private_dns_zone" "this" {
  name                = "${azurerm_virtual_network.this.name}.${var.private_dns_suffix}"
  resource_group_name = var.resource_group_info.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "local" {
  name                  = "local"
  resource_group_name   = var.resource_group_info.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

resource "azurerm_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0

  name                = "${var.org_code}-${var.tier}-${var.instance}-natgw"
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  idle_timeout_in_minutes = 4
  sku_name                = "Standard"

  tags = var.tags
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

  tags = var.tags
}

