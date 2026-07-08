locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)

  soa_record = var.soa_record

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
