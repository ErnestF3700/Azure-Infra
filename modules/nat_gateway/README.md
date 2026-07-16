# Azure NAT Gateway Terraform Module

Production-ready Terraform module for Azure NAT Gateway.
azurerm_public_ip 1st
azurerm_nat_gateway 2nd

## Features

- Azure NAT Gateway
- Standard SKU
- Idle timeout configuration
- Availability Zones
- Enterprise tagging
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "nat_gateway" {
  source = "./modules/nat_gateway"

  name                = "nat-prod-weu"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  idle_timeout_in_minutes = 10

  zones = ["1"]

  tags = {
    Environment = "prod"
    Platform    = "network"
  }
}
```
