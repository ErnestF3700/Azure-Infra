resource "azurerm_bastion_host" "this" {
  name                      = local.name
  location                  = local.location
  resource_group_name       = local.resource_group_name
  sku                       = var.sku
  scale_units               = var.scale_units
  copy_paste_enabled        = var.copy_paste_enabled
  file_copy_enabled         = var.file_copy_enabled
  ip_connect_enabled        = var.ip_connect_enabled
  kerberos_enabled          = var.kerberos_enabled
  shareable_link_enabled    = var.shareable_link_enabled
  tunneling_enabled         = var.tunneling_enabled
  session_recording_enabled = var.session_recording_enabled
  tags                      = local.tags

  ip_configuration {
    name                 = var.ip_configuration_name
    subnet_id            = local.subnet_id
    public_ip_address_id = local.public_ip_id
  }
}
