variable "name" {
  description = "Firewall Policy name."
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

variable "sku" {
  description = "Firewall Policy SKU."
  type        = string
  default     = "Standard"

  validation {
    condition = contains([
      "Standard",
      "Premium"
    ], var.sku)

    error_message = "sku must be Standard or Premium."
  }
}

variable "threat_intelligence_mode" {
  description = "Threat Intelligence mode."
  type        = string
  default     = "Alert"

  validation {
    condition = contains([
      "Alert",
      "Deny",
      "Off"
    ], var.threat_intelligence_mode)

    error_message = "Invalid Threat Intelligence mode."
  }
}

variable "dns" {
  description = "Optional DNS configuration."

  type = object({
    proxy_enabled = bool
    servers       = list(string)
  })

  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
