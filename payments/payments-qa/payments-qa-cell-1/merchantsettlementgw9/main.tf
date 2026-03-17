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
    prefix = "gcp-projects/merchantsettlementgw9"
  }
}

# Configure Google provider
provider "google" {}

# Sanitize owner for GCP label requirements
locals {
  # Convert to lowercase, replace non-alphanumeric with hyphens, remove consecutive hyphens
  owner_sanitized = lower(replace(replace(replace("user:account/rashmi.hegde", "/[^a-zA-Z0-9]/", "-"), "/--+/", "-"), "/^-+|-+$/", ""))
  # Ensure it starts with a letter (prepend 'u' if it doesn't)
  owner_label = can(regex("^[a-z]", local.owner_sanitized)) ? local.owner_sanitized : "u-${local.owner_sanitized}"
}

# Create GCP Project in the cell folder
resource "google_project" "project" {
  name            = "merchantsettlementgw9"
  project_id      = "merchantsettlementgw9"
  folder_id       = var.cell_folder_id
  labels = {
    portfolio    = "payments"
    environment  = "qa"
    global_cell  = replace("cell-1", "-", "_")
    owner        = local.owner_label
    managed_by   = "terraform"
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
