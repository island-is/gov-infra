# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "alert"

  static_criteria  = { for crit_name, crit in var.criteria : crit_name => crit if crit.alert_sensitivity == "" }
  dynamic_criteria = { for crit_name, crit in var.criteria : crit_name => crit if crit.alert_sensitivity != "" }
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = module.defaults.resource_name
  resource_group_name = var.resource_group_info.name

  description = <<DESC
  ${var.description}

  Target      = ${var.target_resource_type}
  Scope       = ${join(",", var.scopes)}
  Environment = ${module.defaults.environment}

  - provisioned via terraform
  DESC

  scopes = var.scopes

  severity                 = var.severity
  window_size              = var.window_size
  frequency                = var.frequency
  target_resource_type     = var.target_resource_type
  target_resource_location = var.resource_group_info.location

  # Static criteria
  dynamic "criteria" {
    for_each = local.static_criteria

    content {
      aggregation      = criteria.value.aggregation
      metric_name      = criteria.value.metric_name
      metric_namespace = criteria.value.metric_namespace
      operator         = criteria.value.operator

      threshold = criteria.value.threshold

      dynamic "dimension" {
        for_each = lookup(criteria.value, "dimension", [])
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  # Dynamic criteria
  dynamic "dynamic_criteria" {
    for_each = local.dynamic_criteria

    content {
      metric_name      = dynamic_criteria.value.metric_name
      aggregation      = dynamic_criteria.value.aggregation
      metric_namespace = dynamic_criteria.value.metric_namespace
      operator         = dynamic_criteria.value.operator

      alert_sensitivity = dynamic_criteria.value.alert_sensitivity

      dynamic "dimension" {
        for_each = lookup(dynamic_criteria.value, "dimension", [])
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  # Actions
  dynamic "action" {
    for_each = toset([var.action])
    content {
      action_group_id    = action.value.action_group_id
      webhook_properties = action.value.webhook_properties
    }
  }

  tags = local.tags
}
