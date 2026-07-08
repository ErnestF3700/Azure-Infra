variable "name" {
  description = "Private DNS Zone name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.name))
    error_message = "The DNS zone name must be a valid DNS domain."
  }
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "soa_record" {
  description = "Optional custom SOA record."

  type = object({
    email        = string
    expire_time  = number
    minimum_ttl  = number
    refresh_time = number
    retry_time   = number
    ttl          = number
    tags         = map(string)
  })

  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
