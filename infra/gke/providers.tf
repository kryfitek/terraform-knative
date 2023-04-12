provider "google" {
  project = var.PROJECT
  region = var.REGION
  credentials = "${file(var.CREDENTIALS)}"
}