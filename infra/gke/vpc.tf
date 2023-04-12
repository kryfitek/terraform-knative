resource "google_compute_network" "vpc" {
  name = "${var.PREFIX}-vpc-${var.ENVIRONMENT}"
  auto_create_subnetworks = "false"
  description = "Virtual network for knative k8s cluster"
}

resource "google_compute_subnetwork" "subnet" {
  name = "${var.PREFIX}-subnet-${var.ENVIRONMENT}"
  region = var.REGION
  network = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}