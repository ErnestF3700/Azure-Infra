# Azure Subnet Terraform module

Creates an Azure subnet with optional service endpoints, Service Endpoint Policies, delegations, and Private Link network policy configuration.

The module intentionally excludes network security group, route table, and NAT Gateway associations, as well as private endpoints and their supporting resources. Keeping those concerns separate provides clear resource ownership and independent lifecycles.

The caller must configure the AzureRM provider and Terraform backend. Subnet names follow the Azure Cloud Adoption Framework convention `snet-<workload>-<environment>-<region>`.

## Usage

```hcl
module "subnet" {
  source = "../../modules/subnet"

  name                 = "snet-app-prod-weu"
  virtual_network_name = "vnet-app-prod-weu"
  resource_group_name  = "rg-network-prod-weu"
  address_prefixes     = ["10.20.1.0/24"]

  service_endpoints = [
    "Microsoft.KeyVault",
    "Microsoft.Storage"
  ]

  service_endpoint_policy_ids = [
    azurerm_subnet_service_endpoint_storage_policy.this.id
  ]

  delegations = {
    web_server_farms = {
      service_delegation = {
        name = "Microsoft.Web/serverFarms"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }
  }

  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
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
| `name` | CAF-compliant subnet name beginning with `snet-`. | `string` | n/a | yes |
| `virtual_network_name` | CAF-compliant existing virtual network name beginning with `vnet-`. | `string` | n/a | yes |
| `resource_group_name` | CAF-compliant existing resource group name beginning with `rg-`. | `string` | n/a | yes |
| `address_prefixes` | IPv4 or IPv6 CIDR prefixes assigned to the subnet. | `list(string)` | n/a | yes |
| `service_endpoints` | Azure services for which to enable service endpoints. | `set(string)` | `[]` | no |
| `service_endpoint_policy_ids` | Service Endpoint Policy resource IDs to associate. | `set(string)` | `[]` | no |
| `delegations` | Delegations keyed by stable delegation names. | `map(object)` | `{}` | no |
| `private_endpoint_network_policies` | Private endpoint network policy mode. | `string` | `"Disabled"` | no |
| `private_link_service_network_policies_enabled` | Whether Private Link service network policies are enabled. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Resource ID of the subnet. |
| `name` | Name of the subnet. |
| `address_prefixes` | Address prefixes assigned to the subnet. |
| `virtual_network_name` | Name of the virtual network containing the subnet. |
| `resource_group_name` | Name of the resource group containing the subnet. |
| `subnet` | Complete subnet resource object. |

## Design notes

- Do not define the same subnet inline in `azurerm_virtual_network`; AzureRM warns that mixing inline and standalone subnet resources causes configuration conflicts.
- Service Endpoint Policy IDs are associated directly because AzureRM models them as subnet properties.
- Delegation actions vary by Azure service. Supply only actions documented for the selected service delegation.
- Private endpoint policies affect private endpoints in this subnet. Choose the narrowest policy mode that satisfies routing and NSG inspection requirements.
- Address-prefix membership and overlap across subnets should be governed by centralized IP address management and landing zone policy.
