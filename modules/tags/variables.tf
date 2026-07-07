variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "uat", "prod"], lower(var.environment))
    error_message = "Environment must be one of: dev, uat, prod."
  }
}

variable "project" {
  description = "Project name."
  type        = string

  validation {
    condition     = length(var.project) > 0
    error_message = "Project cannot be empty."
  }
}

variable "owner" {
  description = "Resource owner."
  type        = string

  validation {
    condition     = length(var.owner) > 0
    error_message = "Owner cannot be empty."
  }
}

variable "cost_center" {
  description = "Cost center identifier."
  type        = string

  validation {
    condition     = length(var.cost_center) > 0
    error_message = "Cost center cannot be empty."
  }
}

variable "additional_tags" {
  description = "Additional custom tags."
  type        = map(string)
  default     = {}
}
