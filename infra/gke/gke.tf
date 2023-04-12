resource "google_container_cluster" "cluster" {
  name = "${var.PREFIX}-cluster-${var.ENVIRONMENT}"
  description = "GKE cluster for knative"
  location = var.REGION
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  node_config {
    disk_size_gb = var.NODE_DISK_SIZE_GB
  }
}

resource "google_service_account" "service_accout" {
  account_id = "${var.PREFIX}-np-sa-${var.ENVIRONMENT}"
  display_name = "Nodepool service account"
}

resource "google_container_node_pool" "cluster_nodes" {
  name = "${var.PREFIX}-nodepool-${var.ENVIRONMENT}"
  location = var.REGION
  cluster = google_container_cluster.cluster.name
  node_count = var.NODE_COUNT
  node_config {
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = google_service_account.service_accout.email
    machine_type = var.VM_SIZE
    disk_size_gb = var.NODE_DISK_SIZE_GB
    tags = ["gke-node", "${var.PROJECT}", "${var.ENVIRONMENT}"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      env = var.PROJECT
    }
  }
}