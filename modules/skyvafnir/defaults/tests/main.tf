# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

terraform {
  required_version = ">= 1.1"
}

module "defaults" {
  source                = "../"
  caller                = "test-caller"
  instance              = "instance"
  org_code              = "org"
  resource_abbreviation = "abbrv"
  tags                  = {}
  tier                  = "tier"
}
