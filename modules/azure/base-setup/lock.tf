# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
resource "azurerm_management_lock" "this" {
  count      = var.lock == true ? 1 : 0
  name       = "lock-${module.defaults.resource_name}"
  scope      = local.resource_group_info.id
  lock_level = "CanNotDelete"
  notes      = "Protect ${module.defaults.resource_name} from deletion."
}
