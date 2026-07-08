# Azure Route Table module

Creates one Azure Route Table with optional BGP route propagation and tags. The
module intentionally does not create routes, subnet associations, virtual
appliances, NAT gateways, or network security groups.

The module is suitable for route tables used by hub and spoke virtual networks,
AKS, VPN gateways, Azure Firewall, and virtual machine workloads.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

The calling configuration must define and configure the AzureRM provider. This
module does not configure a provider or Terraform backend.

## Naming

Supply the complete route table name through `name`. Azure Cloud Adoption
Framework guidance uses the `rt-` resource abbreviation. A typical name is
`rt-hub-prod-weu-001`. The module validates Azure platform naming constraints
without imposing an organization-specific naming structure.

## Usage

```hcl
provider "azurerm" {
  features {}
}

module "hub_route_table" {
  source = "./modules/route_table"

  name                          = "rt-hub-prod-weu-001"
  resource_group_name           = "rg-connectivity-prod-weu-001"
  location                      = "westeurope"
  bgp_route_propagation_enabled = true

  tags = {
    environment = "production"
    managed_by  = "terraform"
    workload    = "connectivity"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Azure Route Table. | `string` | n/a | yes |
| resource_group_name | Name of the resource group in which to create the Route Table. | `string` | n/a | yes |
| location | Azure region in which to create the Route Table. | `string` | n/a | yes |
| bgp_route_propagation_enabled | Whether routes learned through BGP are propagated to the Route Table. | `bool` | `true` | no |
| tags | Map of tags to assign to the Route Table. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the Route Table. |
| name | Name of the Route Table. |
| location | Azure region in which the Route Table is deployed. |
| resource_group_name | Name of the resource group containing the Route Table. |
| route_table | Complete Azure Route Table resource object. |

## Design notes

- BGP route propagation is enabled by default, matching the AzureRM resource
  behavior. Disable it only when the network routing design requires isolation
  from gateway-learned routes.
- Apply enterprise governance, required tag policies, locks, and role
  assignments outside this focused module at the appropriate platform scope.
- Routes and subnet associations should be managed by dedicated modules so their
  lifecycles and permissions remain independently controlled.
