
variable "name" {
  description = "Azure Firewall name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "sku_name" {
  description = "Firewall SKU."
  type        = string
  default     = "AZFW_VNet"

  validation {
    condition = contains([
      "AZFW_VNet",
      "AZFW_Hub"
    ], var.sku_name)

    error_message = "sku_name must be AZFW_VNet or AZFW_Hub."
  }
}

variable "sku_tier" {
  description = "Firewall SKU tier."
  type        = string
  default     = "Standard"

  validation {
    condition = contains([
      "Basic",
      "Standard",
      "Premium"
    ], var.sku_tier)

    error_message = "Invalid SKU tier."
  }
}

variable "firewall_policy_id" {
  description = "Optional Firewall Policy."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "Optional custom DNS servers."
  type        = list(string)
  default     = []
}

variable "ip_configuration" {
  description = "Firewall IP configuration."

  type = object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  })
}

variable "management_ip_configuration" {
  description = "Optional management IP configuration."

  type = object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  })

  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
