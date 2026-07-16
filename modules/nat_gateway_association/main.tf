resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = local.subnet_id
  nat_gateway_id = local.nat_gateway_id
}
