locals {
  name                = trimspace(var.name)
  location            = trimspace(var.location)
  resource_group_name = trimspace(var.resource_group_name)

  type                       = var.type
  virtual_network_gateway_id = trimspace(var.virtual_network_gateway_id)
  local_network_gateway_id   = trimspace(var.local_network_gateway_id)

  shared_key = (
    var.shared_key == null
    ? null
    : trimspace(var.shared_key)
  )

  enable_bgp          = var.enable_bgp
  connection_mode     = var.connection_mode
  dpd_timeout_seconds = var.dpd_timeout_seconds

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
