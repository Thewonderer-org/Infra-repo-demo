variable "project_id" {
  description = "GCP Project ID to create"
  type        = string
  default     = "testing"
}

variable "portfolio" {
  description = "Portfolio name"
  type        = string
  default     = "checkout"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "global_cell" {
  description = "Global cell name"
  type        = string
  default     = "cell-1"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "rashmi"
}

variable "organization_id" {
  description = "GCP Organization ID"
  type        = string
}
