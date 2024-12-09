# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  server_builtin_role_assignments = [
    {
      name  = "Reader"
      scope = azurerm_mssql_server.this.id
    },
    {
      name  = "SQL Server Contributor"
      scope = azurerm_mssql_server.this.id
    },
  ]

  server_contributor_role_assignments = flatten([
    for principal_key, principal_id in var.datawarehouse_contributor_principal_ids : [
      for role_assignment in local.server_builtin_role_assignments : {
        key          = principal_key
        role_name    = role_assignment.name
        scope        = role_assignment.scope
        principal_id = principal_id

      }
    ]
  ])
}

module "server_contributor_access" {
  for_each = {
    for assignment in local.server_contributor_role_assignments :
    "${assignment.key}-${assignment.role_name}" => assignment
  }

  source = "../role-assignment"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  # Either use the role_definition_id or the builtin_role_name.
  # We prefer the role_definition_id, except for built in roles
  role_definition_id = try(each.value.role_definition_id, null) != null ? each.value.role_definition_id : null
  role_name          = try(each.value.type, null) == null ? each.value.role_name : null
  principal_id       = each.value.principal_id
  scope              = each.value.scope
}
