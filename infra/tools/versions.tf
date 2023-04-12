terraform {
  backend "remote" {
    organization = "kryfitek"
    workspaces {
      name = "tekn-tools"
    }
  }

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}