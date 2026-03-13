variable "project" {
  description = "Project name"
  type        = string
  default     = "compute"
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

# GCP Authentication Variables
variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}
