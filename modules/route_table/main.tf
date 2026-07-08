resource "azurerm_route_table" "this" {
  name                          = local.name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled
  tags                          = local.tags
}
