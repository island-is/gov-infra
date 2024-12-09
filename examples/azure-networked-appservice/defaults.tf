# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

module "defaults" {
  source                = "../../modules/skyvafnir/defaults"
  resource_abbreviation = "appgw"
  tags                  = var.tags
  caller                = basename(path.module)
  org_code              = var.org_code
  tier                  = var.tier
  instance              = var.instance
}
