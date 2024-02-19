locals {
  resource_abbreviation  = "rg"
  resource_name_template = module.defaults.resource_name_template
  resource_group_name    = module.defaults.resource_name
}

resource "time_offset" "now" {
  offset_seconds = 1
}

data "external" "git_sha" {
  # We tag our resource groups with the git sha of the provisioning commit.
  program = [
    "git",
    "log",
    "--pretty=format:{ \"git_sha\": \"%H\" }",
    "-1",
    "HEAD"
  ]
}

# Unify resource group access patterns, since sometimes we are creating the resource group and sometimes we are not.
locals {
  provision_resource_group = var.existing_resource_group_info == null ? true : false
  provision_action_group   = local.provision_resource_group && var.budget_for_resource_group > 0.0

  resource_group_info = {
    id       = local.provision_resource_group ? azurerm_resource_group.this[0].id : var.existing_resource_group_info.id
    name     = local.provision_resource_group ? azurerm_resource_group.this[0].name : var.existing_resource_group_info.name
    location = local.provision_resource_group ? azurerm_resource_group.this[0].location : var.existing_resource_group_info.location
  }
}

resource "azurerm_resource_group" "this" {
  count    = local.provision_resource_group ? 1 : 0
  name     = local.resource_group_name
  location = var.location

  tags = merge(local.tags, data.external.git_sha.result)
}

resource "azurerm_monitor_action_group" "this" {
  count = local.provision_action_group ? 1 : 0

  name                = format(local.resource_name_template, "ag")
  short_name          = substr(format(local.resource_name_template, "ag"), 0, 12)
  resource_group_name = local.resource_group_info.name

  tags = local.tags
}

resource "azurerm_consumption_budget_resource_group" "this" {
  count = local.provision_resource_group && var.budget_for_resource_group > 0.0 ? 1 : 0

  name              = format(local.resource_name_template, "budget")
  resource_group_id = local.resource_group_info.id

  amount     = var.budget_for_resource_group
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", time_offset.now.base_rfc3339)
    end_date   = formatdate("2100-MM-01'T'00:00:00Z", time_offset.now.base_rfc3339)
  }

  notification {
    enabled        = true
    threshold      = 90.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.budget_contact_emails
  }

  notification {
    enabled   = false
    threshold = 100.0
    operator  = "GreaterThan"

    contact_emails = var.budget_contact_emails
  }
}

