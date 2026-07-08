# Azure Network Security Group Terraform module

Creates an Azure Network Security Group without security rules or resource associations. This separation gives rules, subnet associations, and network interface associations independent lifecycles and avoids competing ownership of inline and standalone rules.

The caller must configure the AzureRM provider and Terraform backend. Network security group names follow the Azure Cloud Adoption Framework convention `nsg-<workload>-<environment>-<region>`.

## Usage

```hcl
module "network_security_group" {
  source = "../../modules/nsg"

  name                = "nsg-aks-prod-weu"
  resource_group_name = "rg-aks-prod-weu"
  location            = "westeurope"

  tags = {
    environment = "production"
    workload    = "aks"
    owner       = "platform-team"
    cost_center = "cc-1234"
    managed_by  = "terraform"
  }
}
```

Security rules and associations can reference the module output:

```hcl
resource "azurerm_network_security_rule" "https_inbound" {
  name                        = "AllowHttpsInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.network_security_group.resource_group_name
  network_security_group_name = module.network_security_group.name
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
| `name` | CAF-compliant network security group name beginning with `nsg-`. | `string` | n/a | yes |
| `resource_group_name` | CAF-compliant existing resource group name beginning with `rg-`. | `string` | n/a | yes |
| `location` | Canonical Azure region name, such as `westeurope`. | `string` | n/a | yes |
| `tags` | Enterprise tags applied to the network security group. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Resource ID of the network security group. |
| `name` | Name of the network security group. |
| `location` | Azure region of the network security group. |
| `resource_group_name` | Name of the resource group containing the network security group. |

## Design notes

- The module is suitable for NSGs used with AKS, virtual machines, Bastion, VPN Gateway, Azure Firewall, private endpoints, and SQL workloads.
- Security rules are intentionally excluded. Manage them as standalone `azurerm_network_security_rule` resources or through a dedicated rules module.
- Subnet and network interface associations are intentionally excluded so consumers can manage attachment lifecycles independently.
- Apply least-privilege rules at the consuming layer and avoid broad source, destination, protocol, and port ranges unless explicitly required.
