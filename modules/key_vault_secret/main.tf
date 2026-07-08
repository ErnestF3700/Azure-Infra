resource "azurerm_key_vault_secret" "this" {
  name         = local.name
  key_vault_id = local.key_vault_id

  value = local.value

  content_type = local.content_type

  expiration_date = local.expiration_date
  not_before_date = local.not_before_date

  tags = local.tags
}
