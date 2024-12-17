# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
moved {
  from = data.azuread_user.warehouse_admins
  to   = data.azuread_user.datalakehouse_contributors
}

moved {
  from = azurerm_mssql_firewall_rule.whitelist
  to   = module.datawarehouse.azurerm_mssql_firewall_rule.whitelist
}

moved {
  from = module.datalakehouse_user_group
  to   = module.data_engineer_user_group
}

moved {
  from = module.datalakehouse_users_can_operate_datalake
  to   = module.data_engineers_can_operate_datalakehouse
}

moved { # 2023-07-18 -  Dashes to underscore
  from = module.base-setup
  to   = module.base_setup
}


moved { # 2023-10-06 - Introducing env module
  from = module.datawarehouse
  to   = module.datawarehouse[0]
}

moved { # 2023-11-09 - Introduced Datalake feature flag
  from = module.datalake
  to   = module.datalake[0]
}

moved { # 2023-11-09 - Introduced Datalake feature flag
  from = module.datafactory
  to   = module.datafactory[0]
}

moved { # 2023-11-09 - Introduced Datalake and ADF feature flag
  from = module.logic_app_mgmt_role
  to   = module.logic_app_mgmt_role[0]
}
moved { # 2023-11-09 - Introduced Datalake and ADF feature flag
  from = module.logic_app_mgmt_role_assignment
  to   = module.logic_app_mgmt_role_assignment[0]
}
moved { # 2023-11-09 - Introduced Datalake and ADF feature flag
  from = module.logic_app_contributor_role_assignment
  to   = module.logic_app_contributor_role_assignment[0]
}
moved { # 2023-11-09 - Introduced Datalake and ADF feature flag
  from = module.keyvault
  to   = module.keyvault[0]
}

moved { # 2023-11-17 - Refactor Role Assignments
  from = module.logic_app_contributor_role_assignment[0]
  to   = module.data_engineer_group_role_assignments["Can edit Logic Apps"]
}

moved { # 2023-11-17 - Refactor Role Assignments
  from = module.logic_app_mgmt_role_assignment[0]
  to   = module.data_engineer_group_role_assignments["Can manage Logic Apps"]
}

moved {
  from = module.data_engineer_user_group
  to   = module.data_engineer_user_group[0]
}

moved {
  from = module.warehouse_admin_group
  to   = module.warehouse_admin_group[0]
}

moved {
  from = module.datawarehouse[0].azurerm_mssql_database.this
  to   = module.datawarehouse[0].azurerm_mssql_database.this["stokkur"]
}

moved {
  from = module.logic_app_mgmt_role
  to   = module.data_engineer_role
}

moved {
  from = module.data_engineer_group_role_assignments
  to   = module.data_lakehouse_role_assignments
}
