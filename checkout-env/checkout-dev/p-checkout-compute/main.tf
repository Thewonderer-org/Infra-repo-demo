terraform {
  required_version = ">= 1.12.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.0"
    }
  }
}

# Hardcoded cluster configuration
locals {
  endpoint = "34.83.148.135"
  cluster_ca_certificate = <<-EOT
-----BEGIN CERTIFICATE-----
MIIELTCCApWgAwIBAgIRAMa7Ic37hNutgJacSB7/ETgwDQYJKoZIhvcNAQELBQAw
LzEtMCsGA1UEAxMkYTY3MTliMGItNzc5Ny00ZGExLTllMjAtMGVmYWJjMjY0ZDRl
MB4XDTI1MDMwNjExNDQ1NVoXDTMwMDMwNTEyNDQ1NVowLzEtMCsGA1UEAxMkYTY3
MTliMGItNzc5Ny00ZGExLTllMjAtMGVmYWJjMjY0ZDRlMIIBojANBgkqhkiG9w0B
AQEFAAOCAY8AMIIBigKCAYEA8N1TsU6v3cOQWdwvpuwucH+UBkVHjx2nN1q/ZIyZ
NxC1ZIFsD7X6IIKYp5XJp28Pky9Q4xRrLH6ycBWNCzYdjdR+N5yF4V5a+lrD6B4s
Z43r5mVx3KDjkJCMHs0xC74f56eHf/53rOpxUQWMrWbpU0t7DPD/8PoA2uxuMBEm
t9vr4KBf+3Kv93bWp3yVrvPxPBT01/7nvLcHCTfDWd/c4xz8l5wY4BwAfDBE/G7S
XQ+pLOYgdXqQ01Hx+fwZ2M/9dPn4IaOOjxq3kUXGVBZwH8a0qsKvEDW5Ln9PWHFP
e4r0aqPMBWa9vM3K5Bp/2PzW3gW5HQhRqpA7b0G3DDKqRD0+KCqy6/k2XG1fz+Qm
fFZR9m5G8MBHCVRmN+K1TQXg4CtVYVWNdDlKZqJNbgOpD5eJAGDGZj6XzpYDaY5N
j5Z5oZnNvC0nKPk8vvHsR9H3QzMY3+zyW7T9VJ/wfPwNEEGTBRx4pWQ3n8P5rB1h
jlBCN7dKv/lS2n3RAp5eTkZNAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwICpDAPBgNV
HRMBAf8EBTADAQH/MB0GA1UdDgQWBBTqLWi2BYW7UODPjJjAD4uIZq9vdDANBgkq
hkiG9w0BAQsFAAOCAYEAmqV/z0k0y1hOLuVATJB5oSSmVGGILhGF5+5R5KQHQ0Wb
vr0sGKUx27VCJHsJ0p1E0bVmBJxHNq3h1/LLr7nYHaTj+dXH+2fJVhKyQVi8Cjdq
G8kR3STi7gkVHc9PdvWH/DpVlSkHVBHNJqLZ6lkNZIz8TqDFZKOcX9XYMG9yfO+h
gf9jy+d6sGGI6EIjXNJ7m3EBEPRqHBGKjmywsVhI8hqhQ9FqRLbLlPz76v3fELy2
qgUCrQxPRHqBzs3P5D8f3F0sUdLv4M7VRLPtqMwHZE4KUOQp2NaGMpZjbVdPKevG
MKkU4V9f9DL5EB3jdWCPCLsNdUtpEGmPLHZp6n9O5y3f0x6yYqV7Jl9K4SIxOXAl
ypNTQ7hxTDUIQzccyTh3/DdqMZt/kjLYKKmGSKB/bRlNJCwBVKe9qEdSA6aQKvWO
2g5dPNzI3mSDGjqNDxNXjDvlVNcLlZH4H1p3jqVDVAYJslNqpH+PqmrfLnBhqQcX
3z2Y9DcPNWvDp8/zqTrE
-----END CERTIFICATE-----
EOT
}

# Get GCP credentials
data "google_client_config" "default" {}

# Configure Google provider
provider "google" {
  project = var.gcp_project_id
}

# Configure Kubernetes provider using GCP authentication
provider "kubernetes" {
  host                   = "https://${local.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = local.cluster_ca_certificate
}

# Create namespace
resource "kubernetes_namespace" "this" {
  metadata {
    name = "p-checkout-compute-dev"

    labels = {
      "portfolio"   = "checkout"
      "project"     = "compute"
      "environment" = "dev"
      "owner"       = "rashmi"
      "managed-by"  = "terraform"
    }
  }
}

# Add resource quota
resource "kubernetes_resource_quota" "this" {
  metadata {
    name      = "p-checkout-compute-quota"
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
