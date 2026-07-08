locals {
  name                  = trimspace(var.name)
  private_dns_zone_name = trimspace(var.private_dns_zone_name)
  resource_group_name   = trimspace(var.resource_group_name)
  virtual_network_id    = trimspace(var.virtual_network_id)

  registration_enabled = var.registration_enabled

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
