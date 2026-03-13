terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "harness-cell-factory-tfstate"
    prefix = "gcp-projects"
  }
}

# Configure Google provider
provider "google" {}

# Create GCP Project in the cell folder
resource "google_project" "project" {
  name            = "merchantprocessingapps"
  project_id      = "merchantprocessingapps"
  folder_id       = var.cell_folder_id
  labels = {
    portfolio   = "checkout"
    environment = "dev"
    global-cell = "cell-1"
    owner       = replace("rashmi", ".", "-")
    managed-by  = "terraform"
  }
}

output "project_id" {
  value       = google_project.project.project_id
  description = "The GCP project ID"
}

output "project_number" {
  value       = google_project.project.number
  description = "The GCP project number"
}
