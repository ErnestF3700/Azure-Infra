locals {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  ip_configurations = concat(
    [
      {
        name         = "primary"
        public_ip_id = var.public_ip_id
      }
    ],
    var.active_active ? [
      {
        name         = "secondary"
        public_ip_id = var.secondary_public_ip_id
      }
    ] : []
  )
}
