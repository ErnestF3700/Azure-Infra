resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

resource "azurerm_management_lock" "this" {
  count = var.management_lock_enabled ? 1 : 0

  name       = local.management_lock_name
  scope      = azurerm_resource_group.this.id
  lock_level = var.management_lock_level
  notes      = trimspace(var.management_lock_notes)
}
