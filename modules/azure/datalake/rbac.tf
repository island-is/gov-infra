# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  builtin_role_assignments = concat([
    {
      # Read, write, and delete Azure Storage containers and blobs.
      name  = "Storage Blob Data Contributor"
      scope = azurerm_storage_account.this.id
    },
    {
      # Lets you view everything but will not let you delete or create a storage account
      # or contained resource. It will also allow read/write access to all data contained
      # in a storage account via access to storage account keys.
      name  = "Reader and Data Access"
      scope = azurerm_storage_account.this.id
    }
    ],
    # IFF the fileshare is enabled, assign the Storage File Data SMB Share Contributor role to it
    var.provision_fileshare == true ? [
      {
        name  = "Storage File Data SMB Share Contributor"
        scope = azurerm_storage_share.this[0].resource_manager_id
      },
      {
        name  = "Storage File Data SMB Share Reader"
        scope = azurerm_storage_share.this[0].resource_manager_id
      }
    ]
    : []
  ) # /concat
}

module "contributor_access" {
  source   = "../role-assignment"
  for_each = { for idx, role in local.builtin_role_assignments : try(role._key, role.name) => role }

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  # Either use the role_definition_id or the builtin_role_name.
  # We prefer the role_definition_id, except for built in roles
  role_definition_id = try(each.value.role_definition_id, null) != null ? each.value.role_definition_id : null
  role_name          = try(each.value.type, null) == null ? each.value.name : null
  principal_id       = try(each.value.principal_id, var.datalake_contributor_group_id)
  scope              = each.value.scope

  depends_on = [
    azurerm_storage_account.this
  ]
}

module "fileshare_role" {
  count = var.provision_fileshare == true ? 1 : 0

  source = "../role-definition"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  scope             = var.resource_group_info.id
  assignable_scopes = [var.resource_group_info.id]
  description       = <<DESC
Allows Data engineers to view File Shares
Provisioned by terraform via azure-datalakehouse
DESC
  permissions = {
    actions = [
      "Microsoft.Storage/storageAccounts/fileServices/read",
      "Microsoft.Storage/storageAccounts/fileServices/shares/read", # If omitted, shares don't show up in the portal
    ]
    data_actions = [
      # The data_actions mirror the "Storage File Data SMB Share Contributor" built-in role.
      "Microsoft.Storage/storageAccounts/fileServices/fileshares/files/read",
      "Microsoft.Storage/storageAccounts/fileServices/fileshares/files/write",
      "Microsoft.Storage/storageAccounts/fileServices/fileshares/files/delete",
    ]
  }
}

module "fileshare_contributor_role_assignment" {
  count = var.provision_fileshare == true ? 1 : 0

  source = "../role-assignment"

  org_code = var.org_code
  tier     = var.tier
  instance = var.instance

  role_definition_id = module.fileshare_role[0].role_definition_resource_id
  principal_id       = var.datalake_contributor_group_id
  scope              = azurerm_storage_account.this.id
}
