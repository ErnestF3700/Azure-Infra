# Azure Subnet Route Table Association module

Creates one association between an existing Azure subnet and an existing Azure
Route Table.

This focused module does not create route tables, subnets, routes, network
security groups, NAT gateways, or virtual networks. Keeping the association in
its own module allows its lifecycle and permissions to remain independent from
the associated resources.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

The calling configuration must configure the AzureRM provider. This reusable
module does not contain a provider block or Terraform backend configuration.

## Usage

```hcl
module "hub_subnet_route_table_association" {
  source = "./modules/route_table_association"

  subnet_id      = module.hub_subnet.id
  route_table_id = module.hub_route_table.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnet_id | Resource ID of the Azure subnet to associate with the Route Table. | `string` | n/a | yes |
| route_table_id | Resource ID of the Azure Route Table to associate with the subnet. | `string` | n/a | yes |

Both inputs are validated as fully qualified Azure resource IDs, including the
expected `Microsoft.Network` resource types.

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the Subnet Route Table Association. |
| association | Complete Azure Subnet Route Table Association resource object. |

## Design notes

- Azure associations do not have a configurable name, location, or tags. Their
  identity is derived from the subnet and Route Table resource IDs.
- The module accepts existing resource IDs, which supports resources managed by
  Terraform, separate states, or other approved provisioning systems.
- CAF naming conventions apply to the subnet, virtual network, resource group,
  and Route Table supplied by callers; the association itself has no name.
- Assign the calling identity only the permissions required to read the Route
  Table and update the target subnet association.
