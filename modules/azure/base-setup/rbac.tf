# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  role_assignment_scope = local.resource_group_info.id
}

module "permissions" {
  for_each = var.role_assignments == null ? {} : { for idx, role in var.role_assignments : role.role_name => role }

  source = "../role-assignment"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  # Either use the role_definition_id or the builtin_role_name.
  # We prefer the role_definition_id, except for built in roles
  role_definition_id = try(each.value.role_definition_id, null) != null ? each.value.role_definition_id : null
  role_name          = try(each.value.role_definition_id, null) == null ? each.value.role_name : null
  principal_id       = each.value.principal_id
  scope              = local.role_assignment_scope
}
