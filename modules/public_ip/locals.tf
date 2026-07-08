locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  allocation_method = var.allocation_method
  sku               = var.sku
  sku_tier          = var.sku_tier
  ip_version        = var.ip_version

  zones = var.zones

  domain_name_label = (
    var.domain_name_label == null
    ? null
    : trimspace(var.domain_name_label)
  )

  reverse_fqdn = (
    var.reverse_fqdn == null
    ? null
    : trimspace(var.reverse_fqdn)
  )

  edge_zone = (
    var.edge_zone == null
    ? null
    : trimspace(var.edge_zone)
  )

  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
