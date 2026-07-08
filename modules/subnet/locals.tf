locals {
  name                 = trimspace(var.name)
  virtual_network_name = trimspace(var.virtual_network_name)
  resource_group_name  = trimspace(var.resource_group_name)
  address_prefixes     = [for cidr in var.address_prefixes : trimspace(cidr)]
  service_endpoints    = sort(tolist(var.service_endpoints))
  service_endpoint_policy_ids = sort([
    for id in var.service_endpoint_policy_ids : trimspace(id)
  ])
  delegations = {
    for name, delegation in var.delegations : trimspace(name) => {
      service_delegation = {
        name = trimspace(delegation.service_delegation.name)
        actions = sort([
          for action in delegation.service_delegation.actions : trimspace(action)
        ])
      }
    }
  }
}
