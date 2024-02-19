resource "azurerm_management_lock" "this" {
  count      = var.lock == true ? 1 : 0
  name       = format("lock-${local.resource_group_name}")
  scope      = local.resource_group_info.id
  lock_level = "CanNotDelete"
  notes      = "Protect ${local.resource_group_name} from deletion."
}
