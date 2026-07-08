# Azure Virtual Network Peering module

Creates one directional Azure Virtual Network Peering from an existing local
Virtual Network to an existing remote Virtual Network. It supports hub-and-spoke,
cross-region global peering, and cross-subscription peering.

Azure peerings are directional. For bidirectional connectivity, instantiate this
module once in each direction. This module does not create virtual networks, VPN
gateways, route tables, or subnets.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

The calling configuration must configure the AzureRM provider. This reusable
module does not contain a provider block or backend configuration.

## Naming

Supply the complete peering name through `name`. CAF guidance uses the `peer-`
abbreviation. Directional names such as `peer-spoke-to-hub-prod-weu` make the
relationship clear while allowing each organization to apply its own convention.

## Usage

```hcl
module "spoke_to_hub_peering" {
  source = "./modules/vnet_peering"

  name                      = "peer-spoke-to-hub-prod-weu"
  resource_group_name       = "rg-spoke-prod-weu-001"
  virtual_network_name      = "vnet-spoke-prod-weu-001"
  remote_virtual_network_id = module.hub_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}
```

For a cross-subscription peering, pass a fully qualified remote Virtual Network
resource ID and configure the module's AzureRM provider for the subscription that
contains the local Virtual Network. The deployment identity must have the
required peering permissions on both networks.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Virtual Network Peering. | `string` | n/a | yes |
| resource_group_name | Name of the resource group containing the local Virtual Network. | `string` | n/a | yes |
| virtual_network_name | Name of the local Virtual Network. | `string` | n/a | yes |
| remote_virtual_network_id | Resource ID of the remote Virtual Network. | `string` | n/a | yes |
| allow_virtual_network_access | Allow access between the peered networks. | `bool` | `true` | no |
| allow_forwarded_traffic | Allow forwarded traffic from the remote network. | `bool` | `false` | no |
| allow_gateway_transit | Allow the remote network to use the local gateway. | `bool` | `false` | no |
| use_remote_gateways | Use the remote network's gateway. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the Virtual Network Peering. |
| name | Name of the Virtual Network Peering. |
| state | Current state of the Virtual Network Peering. |
| remote_virtual_network_id | Resource ID of the remote Virtual Network. |
| vnet_peering | Complete Azure Virtual Network Peering resource object. |

## Hub-and-spoke guidance

- On a hub-to-spoke peering, enable `allow_gateway_transit` when spokes must use
  the hub gateway.
- On the corresponding spoke-to-hub peering, enable `use_remote_gateways`.
- Enable `allow_forwarded_traffic` only where traffic must traverse a firewall or
  other network virtual appliance.
- `allow_gateway_transit` and `use_remote_gateways` are mutually exclusive on a
  single peering and are validated accordingly.
- Gateway-transit settings require a compatible gateway topology. Azure permits
  a Virtual Network to use remote gateways from only one peering.

## Least privilege

Grant the deployment identity only the peering actions required on the local and
remote Virtual Networks. For cross-subscription or cross-tenant deployments,
explicitly authorize access to both networks at the narrowest practical scope.
