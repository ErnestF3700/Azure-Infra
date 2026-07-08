locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)
  tags                = { for key, value in var.tags : trimspace(key) => trimspace(value) }
}
