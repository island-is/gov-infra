# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  resource_abbreviation = "ag"
  name_instance         = "${var.instance}-${var.group_purpose}"
}

resource "azurerm_monitor_action_group" "this" {
  name                = replace(module.defaults.resource_name, var.instance, local.name_instance)
  short_name          = substr("${var.org_code}-${var.short_name}", 0, 12)
  resource_group_name = var.resource_group_info.name

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name          = "email-receiver-${email_receiver.value}"
      email_address = email_receiver.value
    }
  }

  dynamic "arm_role_receiver" {
    for_each = var.arm_receiver_role_ids
    content {
      name    = "arm-receiver-${arm_role_receiver.key}"
      role_id = arm_role_receiver.value
    }
  }

  tags = local.tags
}
