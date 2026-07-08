resource "azurerm_virtual_network_gateway" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name
  type                = var.gateway_type
  vpn_type            = var.vpn_type
  sku                 = var.sku
  generation          = var.generation
  active_active       = var.active_active
  bgp_enabled         = var.enable_bgp
  tags                = local.tags

  dynamic "ip_configuration" {
    for_each = local.ip_configurations

    content {
      name                          = ip_configuration.value.name
      public_ip_address_id          = ip_configuration.value.public_ip_id
      private_ip_address_allocation = var.private_ip_address_allocation
      subnet_id                     = local.subnet_id
    }
  }
}
