variable "project_id" {
  description = "GCP Project ID to create"
  type        = string
  default     = "riskanalysissoftware123"
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
  default     = "user:account/rashmi.hegde"
}

variable "cell_folder_id" {
  description = "GCP Folder ID for the cell (e.g., folders/123456789)"
  type        = string
}
