# Bootstrap

This Terraform configuration bootstraps the Azure backend required to store Terraform state.

## Resources

- Resource Group
- Storage Account
- Blob Container

## Usage

```bash
terraform init
terraform plan
terraform apply
```

After deployment, configure the backend in:

```
envs/dev/backend.tf
envs/uat/backend.tf
envs/prod/backend.tf
```
