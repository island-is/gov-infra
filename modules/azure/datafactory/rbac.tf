# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  builtin_role_assignments = [
    {
      # Create and manage data factories
      name  = "Data Factory Contributor"
      scope = azurerm_data_factory.this.id
    }
  ]
}

module "contributor_access" {
  for_each = { for idx, role in local.builtin_role_assignments : role.name => role }

  source = "../role-assignment"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  # Either use the role_definition_id or the builtin_role_name.
  # We prefer the role_definition_id, except for built in roles
  role_definition_id = try(each.value.role_definition_id, null) != null ? each.value.role_definition_id : null
  role_name          = try(each.value.type, null) == null ? each.value.name : null
  principal_id       = var.datafactory_contributor_group_id
  scope              = each.value.scope
}

module "datalake_access" {
  source = "../role-assignment"

  instance = var.instance
  org_code = var.org_code
  tier     = var.tier

  role_name    = "Storage Blob Data Contributor"
  principal_id = azurerm_data_factory.this.identity[0].principal_id
  scope        = var.datalake_id
}

module "warehouse_access" {
  count = var.grant_access_to_warehouse ? 1 : 0

  source = "../role-assignment"

  instance = var.instance
  org_code = var.org_code
  tier     = var.tier

  role_name    = "SQL Server Contributor"
  principal_id = azurerm_data_factory.this.identity[0].principal_id
  scope        = var.warehouse_id
}

module "datafactory_group" {
  count = var.group_config != null ? 1 : 0

  source = "../ad-group"

  instance = var.instance
  org_code = var.org_code
  tier     = var.tier

  group_purpose              = var.group_config.purpose
  group_owner_principal_ids  = var.group_config.owners
  group_member_principal_ids = [azurerm_data_factory.this.identity[0].principal_id]
}
