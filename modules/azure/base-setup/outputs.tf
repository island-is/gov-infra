# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
output "resource_group_name" {
  description = "The Resource Group name"
  value       = local.resource_group_info.name
}

output "resource_group_location" {
  description = "The Resource Group location"
  value       = local.resource_group_info.location
}

output "resource_group_id" {
  description = "The Resource Group id"
  value       = local.resource_group_info.id
}

output "resource_group_info" {
  description = "The ID, Name and Location of the Resource Group."
  value = {
    id       = local.resource_group_info.id
    name     = local.resource_group_info.name
    location = local.resource_group_info.location
  }
}

output "budget_alert_action_group_id" {
  description = "The Action Group ID"
  value       = local.provision_action_group ? module.cost_alarm_action_group[0].action_group_id : null
}
