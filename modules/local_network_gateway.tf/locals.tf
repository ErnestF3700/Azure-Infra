locals {
  name                = trimspace(var.name)
  location            = trimspace(var.location)
  resource_group_name = trimspace(var.resource_group_name)

  gateway_address = trimspace(var.gateway_address)

  address_space = [
    for cidr in var.address_space : trimspace(cidr)
  ]

  bgp_settings = var.bgp_settings

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
