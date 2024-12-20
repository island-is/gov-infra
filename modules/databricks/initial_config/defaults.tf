# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
################################################################################
## NOTE: Do not edit this file directly. It should be uniform across modules. ##
################################################################################

module "defaults" {
  source                = "../../skyvafnir/defaults"
  resource_abbreviation = local.resource_abbreviation
  caller                = basename(path.module)
  org_code              = var.org_code
  tier                  = var.tier
  instance              = var.instance
}
