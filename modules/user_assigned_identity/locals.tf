locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
