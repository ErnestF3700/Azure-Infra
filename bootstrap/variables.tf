variable "resource_group_name" {
  description = "Bootstrap Resource Group name."
  type        = string
  default     = "rg-tfstate"

  validation {
    condition     = length(var.resource_group_name) > 2
    error_message = "Invalid Resource Group name."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "westeurope"
}

variable "storage_account_prefix" {
  description = "Storage Account prefix."
  type        = string
  default     = "sttfstate"

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.storage_account_prefix))
    error_message = "Only lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Terraform state container."
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
