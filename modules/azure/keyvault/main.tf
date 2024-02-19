data "azurerm_client_config" "current" {}

locals {
  resource_abbreviation = "kv"
  tenant_id             = var.tenant_id != "" ? var.tenant_id : data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault" "this" {
  name                            = var.keyvault_name_override != null ? var.keyvault_name_override : module.defaults.resource_name
  location                        = var.resource_group_info.location
  resource_group_name             = var.resource_group_info.name
  tenant_id                       = local.tenant_id
  sku_name                        = "standard"
  soft_delete_retention_days      = 30
  purge_protection_enabled        = true
  enabled_for_template_deployment = true
  # Blanket ACL rule until we have a real use for it.
  network_acls {
    bypass         = "AzureServices"
    ip_rules       = var.keyvault_ip_whitelist
    default_action = "Deny"
  }

  tags = local.tags
}

locals {
  keyvault_admin_principal_ids = toset( # toset ensures that the list is unique
    compact(                            # compact removes any null values
      concat(                           # concat flattens any lists passed to it into a single list
        [
          data.azurerm_client_config.current.object_id, # This is the current user / provisioning identity
          var.keyvault_admin_principal_id
          # BACKWARD COMPATIBILITY: This is the old way of doing it
        ],
        var.keyvault_admin_principal_ids
      ) # /concat
    )   # /compact
  )     # /toset
}

resource "azurerm_key_vault_access_policy" "admin" {
  for_each = toset(local.keyvault_admin_principal_ids)

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = local.tenant_id
  object_id    = each.value

  # TODO: These need review
  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "ManageContacts",
    "ManageIssuers",
    "GetIssuers",
    "ListIssuers",
    "SetIssuers",
    "DeleteIssuers",
    "Purge",
  ]

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "GetRotationPolicy",
    "SetRotationPolicy",
    "Rotate",
    "Encrypt",
    "Decrypt",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign",
    "Purge",
    "Release",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge",
  ]

  depends_on = [
    # We add this dependency to ensure that - during destroy - the Key Vault is deleted before this access policy
    # otherwise we risk losing the ability to delete the Key Vault.
    azurerm_key_vault.this
  ]
}

resource "azurerm_key_vault_access_policy" "reader" {
  for_each = var.keyvault_secret_readers

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = local.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [
    # We add this dependency to ensure that - during destroy - the Key Vault is deleted before this access policy
    # otherwise we risk losing the ability to delete the Key Vault.
    azurerm_key_vault.this
  ]
}

resource "azurerm_key_vault_access_policy" "contributor" {
  for_each     = var.keyvault_secret_contributors
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = local.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Recover",
    "Restore",
    "Set",
  ]

  depends_on = [
    # We add this dependency to ensure that - during destroy - the Key Vault is deleted before this access policy
    # otherwise we risk losing the ability to delete the Key Vault.
    azurerm_key_vault.this
  ]
}

resource "azurerm_role_assignment" "kv_admin" {
  # TODO: Is this needed? We are currently not using RBAC on the Key Vault.
  for_each = local.keyvault_admin_principal_ids

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value
}
