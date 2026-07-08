# Azure Virtual Network Terraform module

Creates an Azure Virtual Network with optional custom DNS servers and an optional Azure DDoS Protection Plan association. The module intentionally does not create subnets, network security groups, route tables, peerings, or private endpoints, allowing those resources to have independent lifecycles.

The caller must configure the AzureRM provider and Terraform backend. Virtual network names follow the Azure Cloud Adoption Framework convention `vnet-<workload>-<environment>-<region>`.

## Usage

### Spoke virtual network

```hcl
module "spoke_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-payments-prod-weu"
  resource_group_name = "rg-network-prod-weu"
  location            = "westeurope"
  address_space       = ["10.20.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "production"
    workload    = "payments"
    owner       = "network-platform"
    cost_center = "cc-1234"
    managed_by  = "terraform"
  }
}
```

### Hub virtual network with DDoS protection

```hcl
module "hub_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-connectivity-prod-weu"
  resource_group_name = "rg-connectivity-prod-weu"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan = {
    id = azurerm_network_ddos_protection_plan.this.id
  }

  tags = local.enterprise_tags
}
```

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | CAF-compliant virtual network name beginning with `vnet-`. | `string` | n/a | yes |
| `resource_group_name` | CAF-compliant existing resource group name beginning with `rg-`. | `string` | n/a | yes |
| `location` | Canonical Azure region name, such as `westeurope`. | `string` | n/a | yes |
| `address_space` | IPv4 or IPv6 CIDR prefixes assigned to the virtual network. | `list(string)` | n/a | yes |
| `dns_servers` | Custom IPv4 DNS server addresses; an empty list uses Azure-provided DNS. | `list(string)` | `[]` | no |
| `ddos_protection_plan` | DDoS plan object containing `id` and optional `enable`. | `object({ id = string, enable = optional(bool, true) })` | `null` | no |
| `tags` | Enterprise tags applied to the virtual network. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Resource ID of the virtual network. |
| `name` | Name of the virtual network. |
| `location` | Azure region of the virtual network. |
| `address_space` | Address space assigned to the virtual network. |
| `guid` | Globally unique identifier of the virtual network. |
| `resource_group_name` | Name of the resource group containing the virtual network. |

## Design notes

- Use separate modules for subnets and other network resources so they can evolve without replacing or coupling the virtual network.
- Supplying no `dns_servers` retains Azure-provided DNS. Custom DNS availability and forwarding are the caller's responsibility.
- Set `ddos_protection_plan` to `null` to omit DDoS plan association. The caller needs permission to join the supplied plan.
- Address allocation, overlap prevention across networks, and regional IP address management should be governed by the platform landing zone design.
