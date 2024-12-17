# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "group_display_name" {
  description = "The display name of the AD Group."
  value       = local.group_info.group_name
}

output "group_id" {
  description = "The principal ID of the AD Group."
  value       = local.group_info.group_id
}
