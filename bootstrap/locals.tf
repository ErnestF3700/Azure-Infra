locals {

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Project   = "Azure-Infra"
    },
    var.tags
  )

}
