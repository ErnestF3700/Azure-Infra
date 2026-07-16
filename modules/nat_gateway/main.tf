resource "azurerm_nat_gateway" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  sku_name = local.sku_name

  idle_timeout_in_minutes = local.idle_timeout_in_minutes

  zones = local.zones

  tags = local.tags
}
