# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  # Change this to match your resource.
  # https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/azure-best-practices/resource-abbreviations.md
  resource_abbreviation = "role"
}

resource "azurerm_role_definition" "this" {
  name              = module.defaults.resource_name
  description       = var.description
  scope             = var.scope
  assignable_scopes = var.assignable_scopes

  permissions {
    actions     = var.permissions.actions
    not_actions = var.permissions.not_actions

    data_actions     = var.permissions.data_actions
    not_data_actions = var.permissions.not_data_actions
  }
}
