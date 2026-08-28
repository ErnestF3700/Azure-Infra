environment = "dev"

location = "westeurope"

resource_group_name = "rg-platform-dev-weu"

hub_address_space = [
  "10.0.0.0/16"
]

spoke_address_space = [
  "10.10.0.0/16"
]

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Platform    = "Azure"
}
