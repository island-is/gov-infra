# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

module "base_setup" {
  source = "../../modules/azure/base-setup"

  org_code = var.org_code
  tier     = var.tier
  instance = "databricks"

  budget_contact_emails     = var.budget_contact_emails
  budget_for_resource_group = 50

  tags = var.tags
}

module "databricks_workspace" {
  source = "../../modules/azure/databricks"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    name     = module.base_setup.resource_group_name
    location = module.base_setup.resource_group_location
  }

  sku  = var.databricks_sku_name
  tags = var.tags
}

module "databricks_config" {
  source = "../../modules/databricks/initial_config"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  users = var.databricks_users
}
