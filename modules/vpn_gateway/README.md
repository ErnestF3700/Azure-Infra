# Azure Virtual Network Gateway module

Creates one Azure Virtual Network Gateway for Site-to-Site VPN or ExpressRoute
connectivity. The module uses existing network and public IP resources and does
not create public IP addresses, local network gateways, VPN connections, virtual
networks, or `GatewaySubnet`.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

The calling configuration must configure the AzureRM provider. This module does
not contain a provider block or backend configuration.

## Naming

Supply the complete gateway name through `name`. CAF guidance uses the `vgw-`
abbreviation for Virtual Network Gateways, for example
`vgw-hub-prod-weu-001`. The module validates Azure naming constraints without
imposing an organization-specific naming structure.

## Site-to-Site VPN example

```hcl
module "hub_vpn_gateway" {
  source = "./modules/vpn_gateway"

  name                = "vgw-hub-prod-weu-001"
  resource_group_name = "rg-connectivity-prod-weu-001"
  location            = "westeurope"
  gateway_type        = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw2AZ"
  generation          = "Generation2"
  enable_bgp          = true

  subnet_id   = module.gateway_subnet.id
  public_ip_id = module.vpn_gateway_public_ip.id

  tags = {
    environment = "production"
    managed_by  = "terraform"
    workload    = "connectivity"
  }
}
```

## Active-active VPN example

```hcl
module "hub_vpn_gateway" {
  source = "./modules/vpn_gateway"

  name                   = "vgw-hub-prod-weu-001"
  resource_group_name    = "rg-connectivity-prod-weu-001"
  location               = "westeurope"
  gateway_type           = "Vpn"
  vpn_type               = "RouteBased"
  sku                    = "VpnGw2AZ"
  generation             = "Generation2"
  active_active          = true
  enable_bgp             = true
  subnet_id              = module.gateway_subnet.id
  public_ip_id           = module.primary_public_ip.id
  secondary_public_ip_id = module.secondary_public_ip.id
}
```

## ExpressRoute example

```hcl
module "expressroute_gateway" {
  source = "./modules/vpn_gateway"

  name                = "vgw-er-hub-prod-weu-001"
  resource_group_name = "rg-connectivity-prod-weu-001"
  location            = "westeurope"
  gateway_type        = "ExpressRoute"
  vpn_type            = "RouteBased"
  sku                 = "ErGw2AZ"
  generation          = "Generation2"
  subnet_id           = module.gateway_subnet.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Virtual Network Gateway. | `string` | n/a | yes |
| resource_group_name | Resource group containing the gateway. | `string` | n/a | yes |
| location | Azure region for the gateway. | `string` | n/a | yes |
| gateway_type | Gateway type: `Vpn` or `ExpressRoute`. | `string` | `"Vpn"` | no |
| vpn_type | Routing type: `RouteBased` or `PolicyBased`. | `string` | `"RouteBased"` | no |
| sku | Gateway SKU compatible with `gateway_type`. | `string` | n/a | yes |
| generation | Gateway generation. | `string` | `"Generation2"` | no |
| active_active | Enable active-active VPN mode. | `bool` | `false` | no |
| enable_bgp | Enable BGP. | `bool` | `false` | no |
| private_ip_address_allocation | Gateway interface allocation method; Azure currently supports only `Dynamic`. | `string` | `"Dynamic"` | no |
| subnet_id | Resource ID of the existing `GatewaySubnet`. | `string` | n/a | yes |
| public_ip_id | Primary Public IP ID; required for VPN and omitted for ExpressRoute. | `string` | `null` | no |
| secondary_public_ip_id | Secondary Public IP ID required by active-active VPN mode. | `string` | `null` | no |
| tags | Tags assigned to the gateway. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the Virtual Network Gateway. |
| name | Name of the Virtual Network Gateway. |
| location | Azure region containing the gateway. |
| resource_group_name | Resource group containing the gateway. |
| vpn_gateway | Complete Azure Virtual Network Gateway resource object. |

## Design notes

- Gateway provisioning can take 30 minutes or longer; avoid replacing the
  gateway for routine configuration changes.
- Active-active VPN gateways require two distinct public IP addresses. This is
  enforced when `active_active` is enabled. ExpressRoute gateways omit Public IP
  IDs as required by AzureRM.
- The subnet resource ID must identify a subnet named exactly `GatewaySubnet`.
- Connections, local network gateways, and route propagation are intentionally
  managed outside this module to keep lifecycle and permissions focused.
- Confirm SKU and generation availability in the target region before deployment.
