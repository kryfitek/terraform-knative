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

variable "REGISTRY_USERNAME" {
  type = string
  description = "The username to use for docker hub authentication"
}

variable "REGISTRY_PASSWORD" {
  type = string
  description = "The password to use for docker hub authentication"
}

variable "REGISTRY_EMAIL" {
  type = string
  description = "The email to use for docker hub authentication"
}

variable "REGISTRY_SERVER" {
  type = string
  description = "The server to use for docker hub authentication"
}