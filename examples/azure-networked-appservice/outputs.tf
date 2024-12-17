# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "subnet_id" {
  description = "The ID of the subnet the app service was created in"
  value       = module.network_base.subnet_id
}

output "resource_group_info" {
  description = "Information about the resource group"
  value = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }
}

output "app_service_plan_id" {
  description = "The ID of the app service plan"
  value       = module.app_service.app_service_plan_id
}

output "db_admin_group_object_id" {
  description = "The object ID of the SQL Admin group"
  value       = module.sql_admin_group.group_id
}

output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = module.keyvault.key_vault_id
}
