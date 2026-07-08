locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  sku = var.sku

  dns = var.dns

  threat_intelligence_mode = var.threat_intelligence_mode

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
