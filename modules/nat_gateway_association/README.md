# Azure NAT Gateway Association Terraform Module

Production-ready Terraform module for Azure Subnet NAT Gateway Associations.

## Features

- Azure Subnet NAT Gateway Association
- Input validation
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "nat_gateway_association" {
  source = "./modules/nat_gateway_association"

  subnet_id      = module.subnet.id
  nat_gateway_id = module.nat_gateway.id
}
```

## Outputs

- id
- association
