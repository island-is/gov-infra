# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

#


locals {
  resource_abbreviation = "dbw"
}

resource "azurerm_databricks_workspace" "this" {
  name                = module.defaults.resource_name
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location
  sku                 = var.sku

  tags = module.defaults.tags
}
