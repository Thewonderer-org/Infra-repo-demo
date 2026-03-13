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

variable "global_cell" {
  description = "Global cell name"
  type        = string
  default     = "${{ values.global_cell }}"
}

variable "owner" {
  description = "Owner"
  type        = string
  default     = "${{ values.owner }}"
}

variable "cell_folder_id" {
  description = "GCP Folder ID for the cell (e.g., folders/123456789)"
  type        = string
}
