# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

data "azurerm_resource_group" "this" {
  count = var.resource_group_name_override != null ? 1 : 0
  name  = var.resource_group_name_override
}

module "base_setup" {
  source = "../../modules/azure/base-setup"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  existing_resource_group_info = var.resource_group_name_override != null ? {
    id       = data.azurerm_resource_group.this[0].id,
    name     = data.azurerm_resource_group.this[0].name,
    location = data.azurerm_resource_group.this[0].location
  } : null

  tags = var.tags
}

module "network_base" {
  source = "../../modules/azure/network/network-base"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  virtual_network_cidr = "10.0.0.0/16"
  subnet_cidr          = "10.0.0.0/24"
  service_endpoints    = ["Microsoft.Sql"]
  create_nat_gateway   = true
  delegations = [
    {
      name = "delegation"
      service_delegation = {
        name = "Microsoft.Web/hostingEnvironments"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action",
        ]
      }
    }
  ]

  vnet_name_override      = var.vnet_name_override
  public_ip_name_override = var.public_ip_name_override

  security_group_rules = {
    "Allow-Outbound-To-SQL" = {
      description                = "Allow outbound traffic to SQL subnet"
      access                     = "Allow"
      direction                  = "Outbound"
      priority                   = 100
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "10.0.2.0/24" # Update this to the SQL subnet cidr if different
    },
    "Allow-Outbound-Internet" = {
      description                = "Allow outbound traffic to the Internet"
      access                     = "Allow"
      direction                  = "Outbound"
      priority                   = 200
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "Internet"
    },
    "Deny-All-Inbound" = {
      description                = "Deny all inbound traffic"
      access                     = "Deny"
      direction                  = "Inbound"
      priority                   = 300
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    "Deny-All-Outbound" = {
      description                = "Deny all outbound traffic"
      access                     = "Deny"
      direction                  = "Outbound"
      priority                   = 300
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    },
    "Allow-AzureDevOps-Access" = {
      description                = "Allow access from Azure Devops"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 120
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureDevOps"
      destination_address_prefix = "*"
    },
    "Allow-FrontDoor-Frontend-Access" = {
      description                = "Allow access from Azure Front Door"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 130
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureFrontDoor.Frontend"
      destination_address_prefix = "*"
    },
    "Allow-FrontDoor-Backend-Access" = {
      description                = "Allow access from Azure Front Door"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 140
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureFrontDoor.Backend"
      destination_address_prefix = "*"
    },
    "Allow-FrontDoor-FirstParty-Access" = {
      description                = "Allow access from Azure Front Door"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 150
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureFrontDoor.FirstParty"
      destination_address_prefix = "*"
    },
    "Allow-Dev-HTTPS-Access" = {
      description                = "Allow access from Devs over HTTPS"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 160
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefixes    = var.warehouse_ip_whitelist[*].ip_address
      destination_address_prefix = "*"
    },
    "Allow-Azure-LoadBalancer-Access" = {
      description                = "Allow access from Azure Load Balancer to 80"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 170
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },
    "Allow-Azure-LoadBalancer-Access2" = {
      description                = "Allow access from Azure Load Balancer to 443"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = 180
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },

  }

  tags = var.tags
}

module "frontdoor" {
  source = "../../modules/azure/front-door"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  app_service_fqdn = module.app_service.app_service_fqdn

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  tags = var.tags
}

module "app_service" {
  source = "../../modules/azure/app-service"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  subnet_id                       = module.network_base.subnet_id
  app_settings                    = var.app_service_configuration
  connection_strings              = var.connection_strings
  app_service_name_override       = var.app_service_name_override
  app_service_plan_name_override  = var.app_service_plan_name_override
  contributor_principal_ids       = var.service_contributor_principal_ids
  app_service_environment_enabled = var.app_service_environment_enabled
  ip_restrictions                 = var.ip_restrictions

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  tags = var.tags
}

module "keyvault" {
  source = "../../modules/azure/keyvault"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  keyvault_contributor_principal_ids = var.service_contributor_principal_ids

  keyvault_ip_whitelist = var.warehouse_ip_whitelist[*].ip_address

  keyvault_secret_readers = {
    "App Service" : module.app_service.app_service_identity_principal_id
  }

  keyvault_secret_contributors = {} # KRAPP local.service_contributor_principal_ids_map

  keyvault_admin_principal_ids = var.keyvault_admin_principal_ids

  tags = var.tags
}

module "sql_admin_group" {
  source = "../../modules/azure/ad-group"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  group_purpose = "${var.instance}_sql_admin"

  group_member_principal_ids = concat(
    var.sql_admin_group_owner_principal_ids,
    var.sql_admin_group_member_principal_ids,
    [
      module.app_service.app_service_identity_principal_id
    ]
  )

  group_owner_principal_ids = var.sql_admin_group_owner_principal_ids
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secret_app_service_configuration

  key_vault_id = module.keyvault.key_vault_id
  name         = each.key
  value        = each.value

  lifecycle {
    ignore_changes = [value]
  }
}

locals {
  databases = {
    for db_name, db_details in var.databases : db_name => {
      sku_name                  = db_details.sku_name
      max_size_gb               = db_details.max_size_gb
      name_override             = try(db_details.name_override, null)
      contributor_principal_ids = [module.sql_admin_group.group_id]
    }
  }

  service_contributor_principal_ids_map = {
    for id in var.service_contributor_principal_ids : id => id
  }
}

module "database_server" {
  source = "../../modules/azure/datawarehouse"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  resource_group_info = {
    id       = module.base_setup.resource_group_id
    location = module.base_setup.resource_group_location
    name     = module.base_setup.resource_group_name
  }

  ad_sql_admin_id                         = module.sql_admin_group.group_id
  ad_sql_admin_display_name               = module.sql_admin_group.group_display_name
  key_vault_id                            = module.keyvault.key_vault_id
  tenant_id                               = var.tenant_id
  monitor_alert_emails                    = var.sql_monitor_alert_emails
  warehouse_ip_whitelist                  = var.warehouse_ip_whitelist
  warehouse_subnet_whitelist              = module.network_base.subnet_id
  datawarehouse_contributor_principal_ids = local.service_contributor_principal_ids_map
  audit_storage_account_name_override     = var.db_server_audit_storage_account_name_override
  allow_sql_login                         = length(var.sql_logins) > 0
  databases                               = local.databases

  tags = var.tags
}

provider "mssql" {
  hostname   = module.database_server.sql_server_fqdn
  azure_auth = {}
}

data "mssql_database" "databases" {
  for_each = module.database_server.db_info
  name     = each.value.name
}

module "group_sql_user" {
  for_each           = data.mssql_database.databases
  source             = "../../modules/mssql/external-user"
  entra_display_name = module.sql_admin_group.group_display_name
  mssql_db_info = {
    id   = each.value.id
    name = "DB_NAME"
  }
}

module "sql_logins" {
  # TODO: Implement db / role assignment
  for_each = toset(var.sql_logins)
  source   = "../../modules/mssql/sql-login"
  username = each.value
}

module "role_assignments" {
  for_each = toset(var.sql_logins)
  source   = "../../modules/mssql/db-role-assignment"

  mssql_principal_name = each.value

  mssql_db_info = {
    name = "DB_NAME"
  }
}
