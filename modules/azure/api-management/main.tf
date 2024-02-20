# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2023-05-23T20:48:44

locals {
  # Change this to match your resource.
  # https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/azure-best-practices/resource-abbreviations.md
  resource_abbreviation = "apim"
}

module "naming_apimanagement" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"

  prefix = module.defaults.prefix
  suffix = module.defaults.suffix
}

resource "azurerm_api_management" "apim" {
  name                          = module.naming_apimanagement.api_management.name_unique
  location                      = var.resource_group_info.location
  resource_group_name           = var.resource_group_info.name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = "${var.sku_name}_${var.sku_capacity}"
  public_network_access_enabled = true
  virtual_network_type          = "None"

  identity {
    type = "SystemAssigned"
  }

  tags = local.sliced_tags
}

locals {
  selected_keys = slice(sort([for x, y in local.tags : x]), 0, 14)
  sliced_tags = {
    for x, y in local.tags : x => y if contains(local.selected_keys, x)
  }
}
