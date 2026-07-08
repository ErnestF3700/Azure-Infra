locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)
  address_space       = [for cidr in var.address_space : trimspace(cidr)]
  dns_servers         = [for ip in var.dns_servers : trimspace(ip)]
  tags                = { for key, value in var.tags : trimspace(key) => trimspace(value) }

  ddos_protection_plan = var.ddos_protection_plan == null ? null : {
    id     = trimspace(var.ddos_protection_plan.id)
    enable = var.ddos_protection_plan.enable
  }
}
