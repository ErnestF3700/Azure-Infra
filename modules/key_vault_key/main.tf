resource "azurerm_key_vault_key" "this" {
  name         = local.name
  key_vault_id = local.key_vault_id

  key_type = local.key_type

  key_size = contains(["RSA", "RSA-HSM"], local.key_type) ? local.key_size : null
  curve    = contains(["EC", "EC-HSM"], local.key_type) ? local.curve : null

  key_opts = local.key_opts

  expiration_date = local.expiration_date
  not_before_date = local.not_before_date

  dynamic "rotation_policy" {
    for_each = local.rotation_policy == null ? [] : [local.rotation_policy]

    content {
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry

      automatic {
        time_after_creation = try(
          rotation_policy.value.automatic.time_after_creation,
          null
        )

        time_before_expiry = try(
          rotation_policy.value.automatic.time_before_expiry,
          null
        )
      }
    }
  }

  tags = local.tags
}
