resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = local.name
  resource_group_name   = local.resource_group_name
  private_dns_zone_name = local.private_dns_zone_name

  virtual_network_id = local.virtual_network_id

  registration_enabled = local.registration_enabled

  tags = local.tags
}
