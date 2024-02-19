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
  naming_tier = contains(var.production_identifiers, var.tier) ? "" : var.tier

  # If random_suffix is true, then we'll generate a random pet name and append it to the end of the name
  optional_random_pet = var.append_random_pet ? random_pet.random_suffix[0].id : ""

  # trim and join are used to remove any leading or trailing dashes (if any of the edge variables are empty)
  resource_name_template = trim(join("-", [local.prefix, "%s", local.suffix]), "-")
  # %s is a placeholder for the resource abbreviation
  prefix = var.prefix == "" ? var.org_code : var.prefix

  default_suffix = trim(join("-",
    [
      var.instance,
      local.naming_tier,
      local.optional_random_pet
  ]), "-")

  # This is technical debt due to us not having a consistent naming convention during the early development
  # of the fjr-dev environment.
  # We need to keep this around until we can recycle that environment.
  # Asana task: https://app.asana.com/0/1203940565275815/1206545187888540/f

  fjr_dev_suffix = trim(join("-",
    [
      local.naming_tier,
      var.instance,
      local.optional_random_pet
  ]), "-")

  suffix = (var.org_code == "fjr" && var.tier == "dev") ? local.fjr_dev_suffix : local.default_suffix
  tags   = merge(var.tags, local.default_tags, local.iac_tags)
}

resource "random_pet" "random_suffix" {
  count  = var.append_random_pet ? 1 : 0
  length = 1
}

