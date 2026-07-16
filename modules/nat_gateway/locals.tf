locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  sku_name = var.sku_name

  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  zones = sort(distinct(var.zones))

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
