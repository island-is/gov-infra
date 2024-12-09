# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
output "azure_resource_group_location" {
  description = "The azure_resource_group_location"
  value       = azurerm_virtual_network.this.location
}

output "virtual_network_name" {
  description = "The virtual_network_name"
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_id" {
  description = "The virtual_network_id"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "The subnet_id"
  value       = azurerm_subnet.this.id
}

output "subnet_name" {
  description = "The subnet_name"
  value       = azurerm_subnet.this.name
}

output "private_zone_name" {
  description = "Private DNS zone for this VNET"
  value       = azurerm_private_dns_zone.this.name
}
