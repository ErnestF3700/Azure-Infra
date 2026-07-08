# Azure Subnet Network Security Group Association Terraform module

Associates one existing Azure Network Security Group with one existing Azure subnet.

The module intentionally does not create the subnet, Network Security Group, security rules, route table resources, NAT Gateway resources, or private endpoints. Keeping the association independent provides a clear ownership boundary and allows the subnet and Network Security Group to have separate lifecycles.

The caller must configure the AzureRM provider and Terraform backend.

## Usage

```hcl
module "nsg_association" {
  source = "../../modules/nsg_association"

  subnet_id                 = module.subnet.id
  network_security_group_id = module.network_security_group.id
}
```

When consuming the modules in the same configuration, resource references establish the required dependency automatically.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `subnet_id` | Resource ID of the existing Azure subnet. | `string` | n/a | yes |
| `network_security_group_id` | Resource ID of the existing Azure Network Security Group. | `string` | n/a | yes |

Both inputs validate the complete Azure resource ID hierarchy, including the subscription GUID, resource group, provider namespace, and expected resource type.

## Outputs

| Name | Description |
|------|-------------|
| `id` | Resource ID of the subnet Network Security Group association. |
| `association` | Complete association resource object. |

## Design notes

- Azure permits only one Network Security Group association per subnet. Ensure that no other Terraform resource or deployment system manages the same association.
- The executing identity needs only the permissions required to read and join the referenced subnet and Network Security Group.
- Use resource outputs rather than manually assembled IDs whenever the subnet and Network Security Group are managed by Terraform.
