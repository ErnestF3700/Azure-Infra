locals {
  resource_group_name = trimspace(var.name)
  location            = trimspace(var.location)
  tags                = { for key, value in var.tags : trimspace(key) => trimspace(value) }
  management_lock_name = var.management_lock_name == null ? (
    "lock-${local.resource_group_name}"
  ) : trimspace(var.management_lock_name)
}
