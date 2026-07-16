# Azure NAT Gateway Public IP Association Terraform Module

Production-ready Terraform module for Azure NAT Gateway Public IP Associations.

## Features

- Azure NAT Gateway Public IP Association
- Input validation
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "nat_gateway_public_ip_association" {
  source = "./modules/nat_gateway_public_ip_association"

  nat_gateway_id       = module.nat_gateway.id
  public_ip_address_id = module.public_ip.id
}
```

## Outputs

- id
- association
