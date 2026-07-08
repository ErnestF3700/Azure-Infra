resource "azurerm_virtual_network_gateway_connection" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name

  type = local.type

  virtual_network_gateway_id = local.virtual_network_gateway_id
  local_network_gateway_id   = local.local_network_gateway_id

  shared_key = local.shared_key

  enable_bgp = local.enable_bgp

  connection_mode = local.connection_mode

  dpd_timeout_seconds = local.dpd_timeout_seconds

  tags = local.tags
}
