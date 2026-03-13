variable "project_id" {
  description = "GCP Project ID to create"
  type        = string
  default     = "projectattempt"
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

variable "owner" {
  description = "Owner"
  type        = string
  default     = "rashmi"
}

variable "organization_id" {
  description = "GCP Organization ID"
  type        = string
}
