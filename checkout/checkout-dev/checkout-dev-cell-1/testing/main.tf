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

# Construct the cell folder name
locals {
  cell_folder_name = "checkout-dev-cell-1"
}

# Look up the cell folder ID by display name using gcloud
data "external" "cell_folder" {
  program = ["bash", "-c", <<-EOT
    FOLDER_NAME="${local.cell_folder_name}"
    ORG_ID="$${1}"

    # Search for folder by display name
    FOLDER_ID=$(gcloud resource-manager folders list --organization=$${ORG_ID} --format="value(name)" --filter="displayName:$${FOLDER_NAME}")

    if [ -z "$${FOLDER_ID}" ]; then
      echo "Error: Folder '$${FOLDER_NAME}' not found in organization $${ORG_ID}" >&2
      exit 1
    fi

    echo "{\"folder_id\": \"$${FOLDER_ID}\"}"
  EOT
  , var.organization_id]
}

# Create GCP Project in the cell folder
resource "google_project" "project" {
  name            = "testing"
  project_id      = "testing"
  folder_id       = data.external.cell_folder.result.folder_id
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
