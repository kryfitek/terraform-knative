provider "google" {
  project = var.PROJECT
  region = var.REGION
  credentials = var.CREDENTIALS
}

data "terraform_remote_state" "tekn_gke" {
  backend = "remote"
  config = {
    organization = var.ORGANIZATION
    workspaces = {
      name = var.WORKSPACE_GKE
    }
  }
}

data "google_client_config" "default" {
}

data "google_container_cluster" "cluster" {
  name = data.terraform_remote_state.tekn_gke.outputs.kubernetes_cluster_name
  location = data.terraform_remote_state.tekn_gke.outputs.region
  project = data.terraform_remote_state.tekn_gke.outputs.project
}

provider "kubernetes" {
  host = "https://${data.google_container_cluster.cluster.endpoint}"
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
  )
  token = data.google_client_config.default.access_token
}

# provider "helm" {
#   kubernetes {
#     host = "https://${data.google_container_cluster.cluster.endpoint}"
#     cluster_ca_certificate = base64decode(
#       data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
#     )
#     token = data.google_client_config.default.access_token
#   }
# }