variable "PROJECT" {
  type = string
  description = "GKE project identification"
}

variable "REGION" {
  type = string
  description = "GKE project region"
  default = "us-east1"
}

variable "CREDENTIALS" {
  type = string
  description = "GKE project service account credentials"
}

variable "ORGANIZATION" {
  type = string
  description = "Terraform organization"
}

variable "WORKSPACE_GKE" {
  type = string
  description = "Terraform workspace for gke cluster"
}