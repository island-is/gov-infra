# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "datalakehouse_contributor_group_info" {
  description = "The Data Lakehouse Contributor group"
  value = local.data_factory_enabled || local.warehouse_enabled ? {
    display_name = module.data_engineer_user_group[0].group_display_name
    id           = module.data_engineer_user_group[0].group_id
  } : null
}

output "datalakehouse_warehouse_admin_group_info" {
  description = "The Data Lakehouse Warehouse Admin group"
  value = local.warehouse_enabled ? {
    display_name = module.warehouse_admin_group[0].group_display_name
    id           = module.warehouse_admin_group[0].group_id
  } : null
}

output "datalakehouse_warehouse_connection_info" {
  description = "The Data Lakehouse Warehouse Connection Info"
  value       = local.warehouse_enabled ? module.datawarehouse : null
}

output "datafactory_info" {
  description = "The Data Factory Info"
  value       = local.data_factory_enabled ? module.datafactory : null
}

output "datalake_info" {
  description = "The Data Lake Info"
  value       = local.datalake_enabled ? module.datalake : null
}

output "data_engineer_user_group_id" {
  description = "The Data Engineer User Group ID"
  value       = module.data_engineer_user_group[0].group_id
}
