# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "N/A"
}

resource "azurerm_role_assignment" "this" {
  description = var.description != "" ? var.description : null

  scope        = var.scope
  principal_id = var.principal_id

  role_definition_id   = try(var.role_definition_id, null)
  role_definition_name = try(var.role_name, null)
}

