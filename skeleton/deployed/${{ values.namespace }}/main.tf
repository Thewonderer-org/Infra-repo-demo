terraform {
  required_version = ">= 1.12.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Create namespace
resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace

    labels = {
      "region"     = var.region
      "cluster"    = var.cluster
      "owner"      = var.owner
      "managed-by" = "terraform"
    }
  }
}

# Add resource quota
resource "kubernetes_resource_quota" "this" {
  metadata {
    name      = "${{ values.namespace }}-quota"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    hard = {
      "requests.cpu"    = "10"
      "requests.memory" = "20Gi"
      "limits.cpu"      = "20"
      "limits.memory"   = "40Gi"
      "pods"            = "50"
    }
  }
}

output "namespace_name" {
  value = kubernetes_namespace.this.metadata[0].name
}
