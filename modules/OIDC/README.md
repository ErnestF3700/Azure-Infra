# Azure Federated Identity Credential Terraform Module

Production-ready Terraform module for Azure Federated Identity Credentials.

## Features

- Azure Federated Identity Credential
- GitHub Actions OIDC
- Azure DevOps OIDC
- Terraform Cloud OIDC
- Configurable audiences
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "github_oidc" {
  source = "./modules/OIDC"

  name                = "github-main"
  resource_group_name = module.resource_group.name

  parent_id = module.user_assigned_identity.id

  issuer = "https://token.actions.githubusercontent.com"

  subject = "repo:my-org/my-repo:ref:refs/heads/main"
}
```
