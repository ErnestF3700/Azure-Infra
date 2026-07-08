resource "azurerm_key_vault" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  tenant_id = local.tenant_id
  sku_name  = local.sku_name

  purge_protection_enabled      = local.purge_protection_enabled
  soft_delete_retention_days    = local.soft_delete_retention_days
  enable_rbac_authorization     = local.enable_rbac_authorization
  public_network_access_enabled = local.public_network_access_enabled

  network_acls {
    bypass                     = local.network_acls.bypass
    default_action             = local.network_acls.default_action
    ip_rules                   = local.network_acls.ip_rules
    virtual_network_subnet_ids = local.network_acls.virtual_network_subnet_ids
  }

  tags = local.tags
}
