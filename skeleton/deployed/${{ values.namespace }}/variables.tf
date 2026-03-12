variable "project" {
  description = "Project name"
  type        = string
  default     = "${{ values.project }}"
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

# GCP Authentication Variables
variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}
