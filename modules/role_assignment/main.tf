resource "azurerm_role_assignment" "this" {
  scope = local.scope

  role_definition_name = local.role_definition_name
  role_definition_id   = local.role_definition_id

  principal_id   = local.principal_id
  principal_type = local.principal_type

  condition         = local.condition
  condition_version = local.condition == null ? null : local.condition_version

  skip_service_principal_aad_check = local.skip_service_principal_aad_check

  lifecycle {
    precondition {
      condition = (
        (var.role_definition_name != null && var.role_definition_id == null) ||
        (var.role_definition_name == null && var.role_definition_id != null)
      )

      error_message = "Specify either role_definition_name or role_definition_id."
    }
  }
}
