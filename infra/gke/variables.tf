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

variable "PREFIX" {
  type = string
  description = "Prefix for cloud resources creation"
}

variable "ENVIRONMENT" {
  type = string
  description = "Environment (dev/staging/prod)"
  default = "dev"
}

variable "NODE_COUNT" {
  type = number
  description = "Number of Nodes in your K8s cluster"
  default = 1
}

variable "VM_SIZE" {
  type = string
  description = "Size of the VM to create"
  default = "e2-medium"
}

variable "NODE_DISK_SIZE_GB" {
  type = number
  description = "The size in GB of the storage on each node"
  default = 30
}