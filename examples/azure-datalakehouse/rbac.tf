data "azuread_user" "datalakehouse_contributors" {
  # A collection of AD Users that are allowed to access the Data Lakehouse.
  count               = length(var.datalakehouse_contributors)
  user_principal_name = var.datalakehouse_contributors[count.index]
}

locals {
  ad_owners = toset(
    concat([
      # The Data Factory Service Principal
      # module.datafactory.service_principal_object_id,
      # The applying user / provisioner managed identity
      data.azurerm_client_config.current.object_id,
      ],
      # List of AD Object ID's of additional owners
      var.datalakehouse_admins
    ) # /concat
  )   # /toset
}

module "warehouse_admin_group" {
  count  = local.warehouse_enabled ? 1 : 0
  source = "../../modules/azure/ad-group"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  existing_group_name = var.warehouse_config.admin_group_name

  group_purpose             = "warehouse-admin"
  group_owner_principal_ids = local.ad_owners

  depends_on = [
    data.azurerm_client_config.current,
  ]
}

module "data_engineer_user_group" {
  source = "../../modules/azure/ad-group"

  count = local.data_factory_enabled || local.warehouse_enabled ? 1 : 0

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  existing_group_name       = var.datalakehouse_contributor_group_name
  group_owner_principal_ids = local.ad_owners

  group_purpose     = "datalake-contributor"
  group_description = <<DESC
  Data Engineers can contribute to the ${var.org_code}-${var.tier} Data Lakehouse.
  DESC

  depends_on = [data.azuread_user.datalakehouse_contributors]
}

module "data_engineer_role" {
  count = local.data_factory_enabled ? 1 : 0

  source = "../../modules/azure/role-definition"

  org_code = var.org_code
  tier     = var.tier
  instance = format("%s-%s", var.instance, "data-engineer")

  scope = module.base_setup.resource_group_id

  assignable_scopes = [
    module.base_setup.resource_group_id
  ]

  permissions = {
    actions = [
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Web/ServerFarms/write",
      "Microsoft.Web/Sites/write",
      "Microsoft.Logic/workflows/read",
      "Microsoft.Logic/workflows/write",
      "Microsoft.Logic/workflows/delete",
      # Allow Data Engineers to subscripe to Storage Account Events
      "Microsoft.EventGrid/EventSubscriptions/write",
      # Allow Data Engineers to create alerts
      "Microsoft.Insights/actiongroups/write",
      "Microsoft.Insights/alertRules/write",
      "Microsoft.Insights/metricAlerts/write",
    ]
  }

  description = <<DESC
Allows Data engineers to provision Logic Apps
Provisioned by terraform via azure-datalakehouse
DESC
}

locals {
  # This is a list of role assignments that should be applied to the Data Engineers
  data_engineer_role_assignments = concat([
    {
      purpose              = "Can view resources"
      role_definition_name = "Reader"
      principal_id         = module.data_engineer_user_group[0].group_id
      scope                = module.base_setup.resource_group_id
    },
    ],
    local.data_factory_enabled ? [
      {
        purpose              = "Can edit Logic Apps"
        role_definition_name = "Logic App Contributor"
        principal_id         = module.data_engineer_user_group[0].group_id
        scope                = module.base_setup.resource_group_id
      },
      {
        purpose            = "Data Lakehouse Engineering"
        role_definition_id = module.data_engineer_role[0].role_definition_resource_id
        principal_id       = module.data_engineer_user_group[0].group_id
        scope              = module.base_setup.resource_group_id
      }
    ] : [] # Empty list if data factory is not enabled
  )
}

module "data_engineer_group_role_assignments" {
  for_each = { for r in local.data_engineer_role_assignments : r.purpose => r }

  source = "../../modules/azure/role-assignment"

  org_code = var.org_code
  tier     = var.tier
  instance = "infra-provisioner"

  principal_id       = each.value.principal_id
  scope              = each.value.scope
  role_name          = try(each.value.role_definition_name, null)
  role_definition_id = try(each.value.role_definition_id, null)
  description        = "${each.value.purpose} - provisioned by terraform via ${basename(path.cwd)}"
}
