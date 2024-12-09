# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

module "defaults" {
  source                = "../../skyvafnir/defaults"
  resource_abbreviation = local.resource_abbreviation
  tags                  = var.tags
  caller                = basename(path.module)
  org_code              = var.org_code
  tier                  = var.tier
  instance              = var.instance
}