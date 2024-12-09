# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "db"
  db_name               = format(module.defaults.resource_name_template, local.resource_abbreviation)
}

resource "azurerm_mssql_database" "this" {
  name                 = var.name_override == null ? local.db_name : var.name_override
  server_id            = var.server_id
  collation            = var.collation
  sku_name             = var.sku_name
  max_size_gb          = var.max_size_gb
  min_capacity         = var.min_capacity
  zone_redundant       = var.zone_redundant
  storage_account_type = var.zone_redundant ? "Geo" : "Local"
  tags                 = local.tags

  auto_pause_delay_in_minutes = var.auto_pause_delay_minutes

  depends_on = [var.server_id]
}

locals {
  contributor_principal_ids_map = { for idx, id in var.contributor_principal_ids : idx => id }
}

module "contributor_access" {
  for_each = local.contributor_principal_ids_map

  source = "../role-assignment"

  instance = var.instance
  org_code = var.org_code
  tier     = var.tier

  role_name    = "SQL DB Contributor"
  principal_id = each.value
  scope        = azurerm_mssql_database.this.id
}
