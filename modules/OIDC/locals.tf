locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)

  parent_id = trimspace(var.parent_id)

  issuer = trimspace(var.issuer)

  subject = trimspace(var.subject)

  audiences = sort(distinct([
    for audience in var.audiences :
    trimspace(audience)
  ]))
}
