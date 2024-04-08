locals {
  resource_abbreviation  = "rg"
}

resource "time_offset" "now" {
  offset_seconds = 1
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
  name     = module.defaults.resource_name
  location = var.location

  tags = module.defaults.tags
}

module "cost_alarm_action_group" {
  count = local.provision_action_group ? 1 : 0

  source = "../monitor-action-group"

  tier     = var.tier
  instance = var.instance
  org_code = var.org_code

  resource_group_info = local.resource_group_info

  group_purpose   = "cost-alert"
  short_name      = "cost"
  email_receivers = var.budget_contact_emails

  tags = module.defaults.tags
}

resource "azurerm_consumption_budget_resource_group" "this" {
  count = local.provision_resource_group && var.budget_for_resource_group > 0.0 ? 1 : 0

  name              = format(module.defaults.resource_name_template, "budget")
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

