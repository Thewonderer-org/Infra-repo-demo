variable "namespace" {
  description = "Namespace name"
  type        = string
  default     = "${{ values.namespace }}"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "${{ values.region }}"
}

variable "cluster" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "${{ values.cluster }}"
}

variable "owner" {
  description = "Owner of the namespace"
  type        = string
  default     = "${{ values.owner }}"
}
