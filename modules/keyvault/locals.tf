locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)
  tenant_id           = trimspace(var.tenant_id)

  sku_name = lower(var.sku_name)

  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  enable_rbac_authorization     = var.enable_rbac_authorization
  public_network_access_enabled = var.public_network_access_enabled

  network_acls = var.network_acls

  tags = {
    for key, value in var.tags :
    trimspace(key) => trimspace(value)
  }
}
