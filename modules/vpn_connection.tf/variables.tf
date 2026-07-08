variable "name" {
  description = "Name of the VPN Connection."
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

variable "virtual_network_gateway_id" {
  description = "Virtual Network Gateway Resource ID."
  type        = string
}

variable "local_network_gateway_id" {
  description = "Local Network Gateway Resource ID."
  type        = string
}

variable "type" {
  description = "VPN connection type."
  type        = string

  default = "IPsec"

  validation {
    condition = contains([
      "IPsec",
      "ExpressRoute",
      "Vnet2Vnet"
    ], var.type)

    error_message = "Unsupported connection type."
  }
}

variable "shared_key" {
  description = "Shared IPSec key."
  type        = string
  default     = null
}

variable "enable_bgp" {
  description = "Enable BGP."
  type        = bool
  default     = false
}

variable "connection_mode" {
  description = "Connection mode."
  type        = string
  default     = "Default"

  validation {
    condition = contains([
      "Default",
      "InitiatorOnly",
      "ResponderOnly"
    ], var.connection_mode)

    error_message = "Invalid connection mode."
  }
}

variable "dpd_timeout_seconds" {
  description = "Dead Peer Detection timeout."
  type        = number
  default     = 45

  validation {
    condition = (
      var.dpd_timeout_seconds >= 9 &&
      var.dpd_timeout_seconds <= 3600
    )

    error_message = "DPD timeout must be between 9 and 3600 seconds."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
