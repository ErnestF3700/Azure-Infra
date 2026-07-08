resource "azurerm_local_network_gateway" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name

  gateway_address = local.gateway_address
  address_space   = local.address_space

  dynamic "bgp_settings" {
    for_each = local.bgp_settings == null ? [] : [local.bgp_settings]

    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.bgp_peering_address
      peer_weight         = bgp_settings.value.peer_weight
    }
  }

  tags = local.tags
}
