variable "project_id" {
  description = "GCP Project ID to create"
  type        = string
  default     = "${{ values.project_id }}"
}

variable "portfolio" {
  description = "Portfolio name"
  type        = string
  default     = "${{ values.portfolio }}"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "${{ values.environment }}"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "${{ values.owner }}"
}

variable "organization_id" {
  description = "GCP Organization ID"
  type        = string
}
