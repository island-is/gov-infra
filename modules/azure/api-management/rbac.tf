# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  builtin_role_assignments = [
    {
      name  = "API Management Service Contributor"
      scope = azurerm_api_management.apim.id
    },
  ]
}

module "contributor_access" {
  source   = "../role-assignment"
  for_each = { for idx, role in local.builtin_role_assignments : role.name => role }

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  # Either use the role_definition_id or the builtin_role_name.
  # We prefer the role_definition_id, except for built in roles
  role_definition_id = try(each.value.role_definition_id, null) != null ? each.value.role_definition_id : null
  role_name          = try(each.value.type, null) == null ? each.value.name : null
  principal_id       = var.api_contributor_group_id
  scope              = each.value.scope
}
