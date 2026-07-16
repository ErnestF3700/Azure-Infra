resource "azurerm_federated_identity_credential" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name

  parent_id = local.parent_id

  issuer = local.issuer

  subject = local.subject

  audience = local.audiences
}
