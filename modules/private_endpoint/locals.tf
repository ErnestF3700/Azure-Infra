locals {
  name                = trimspace(var.name)
  location            = trimspace(var.location)
  resource_group_name = trimspace(var.resource_group_name)

  subnet_id = trimspace(var.subnet_id)

  private_connection_resource_id = trimspace(var.private_connection_resource_id)

  subresource_names = sort(var.subresource_names)

  private_dns_zone_group = var.private_dns_zone_group

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
