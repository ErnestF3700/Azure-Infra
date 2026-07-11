locals {
  scope = trimspace(var.scope)

  role_definition_name = (
    var.role_definition_name == null
    ? null
    : trimspace(var.role_definition_name)
  )

  role_definition_id = (
    var.role_definition_id == null
    ? null
    : trimspace(var.role_definition_id)
  )

  principal_id   = trimspace(var.principal_id)
  principal_type = var.principal_type

  condition         = var.condition
  condition_version = var.condition_version

  skip_service_principal_aad_check = var.skip_service_principal_aad_check
}
