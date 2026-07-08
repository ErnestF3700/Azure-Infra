locals {
  name         = trimspace(var.name)
  key_vault_id = trimspace(var.key_vault_id)

  key_type = var.key_type
  key_size = var.key_size
  curve    = var.curve

  key_opts = sort(distinct(var.key_opts))

  expiration_date = var.expiration_date
  not_before_date = var.not_before_date

  rotation_policy = var.rotation_policy

  tags = {
    for key, value in var.tags :
    trimspace(key) => trimspace(value)
  }
}
