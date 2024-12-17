# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  project     = join("-", [var.org_code, var.tier, var.instance])
  environment = join("-", [var.org_code, var.tier])

  default_tags = var.default_tag_override != null ? var.default_tag_override : {
    org_code    = var.org_code
    tier        = var.tier
    instance    = var.instance
    environment = local.environment
    project     = local.project
  }

  iac_tags = {
    _iac-provisioned-by = var.provisioned_by
    _iac-part-of-module = var.caller
    _iac-support-email  = var.iac_support_email
  }

  # If the tier is in the list of production tiers, then we don't want to include it in the name
  naming_tier = var.include_tier_in_names ? var.tier : ""

  # If random_suffix is true, then we'll generate a random pet name and append it to the end of the name
  optional_random_pet = var.append_random_pet ? random_pet.random_suffix[0].id : ""

  # %s is a placeholder for the resource abbreviation
  prefix = var.prefix == "" ? var.org_code : var.prefix

  # trim and join are used to remove any leading or trailing dashes (if any of the edge variables are empty)
  default_resource_name_template = trim(join("-", [local.prefix, local.suffix, "%s"]), "-")
  default_suffix = trim(join("-",
    [
      var.instance,
      local.naming_tier,
      local.optional_random_pet
  ]), "-")

  # This is technical debt due to us not having a consistent naming convention during the early development
  # of the fjr-dev environment.
  # We need to keep this around until we can recycle that environment.

  fjr_resource_name_template = trim(join("-", [local.prefix, "%s", local.suffix]), "-")
  fjr_dev_suffix = trim(join("-",
    [
      local.naming_tier,
      var.instance,
      local.optional_random_pet
  ]), "-")

  suffix                 = (var.org_code == "fjr" && var.tier == "dev") ? local.fjr_dev_suffix : local.default_suffix
  resource_name_template = var.org_code == "fjr" ? local.fjr_resource_name_template : local.default_resource_name_template

  tags = merge(var.tags, local.default_tags, local.iac_tags)
}

resource "random_pet" "random_suffix" {
  count  = var.append_random_pet ? 1 : 0
  length = 1
}

