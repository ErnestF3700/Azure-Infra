locals {
  name         = trimspace(var.name)
  key_vault_id = trimspace(var.key_vault_id)

  value           = var.value
  content_type    = var.content_type
  expiration_date = var.expiration_date
  not_before_date = var.not_before_date

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
