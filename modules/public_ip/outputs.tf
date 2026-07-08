resource "azurerm_public_ip" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  allocation_method = local.allocation_method
  sku               = local.sku
  sku_tier          = local.sku_tier
  ip_version        = local.ip_version

  zones = local.zones

  domain_name_label = local.domain_name_label
  reverse_fqdn      = local.reverse_fqdn

  edge_zone = local.edge_zone

  idle_timeout_in_minutes = local.idle_timeout_in_minutes

  tags = local.tags
}
