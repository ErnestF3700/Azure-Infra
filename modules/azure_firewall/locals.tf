
locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  sku_name = var.sku_name
  sku_tier = var.sku_tier

  firewall_policy_id = (
    var.firewall_policy_id == null
    ? null
    : trimspace(var.firewall_policy_id)
  )

  dns_servers = var.dns_servers

  ip_configuration = {
    name                 = trimspace(var.ip_configuration.name)
    subnet_id            = trimspace(var.ip_configuration.subnet_id)
    public_ip_address_id = trimspace(var.ip_configuration.public_ip_address_id)
  }

  management_ip_configuration = var.management_ip_configuration

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
