provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_project_service" "sql" {
  service = "sqladmin.googleapis.com"
}

resource "google_project_service" "vpcaccess" {
  service = "vpcaccess.googleapis.com"
}

# VPC Network
resource "google_compute_network" "main-vpc" {
  name                    = "main-vpc"
  auto_create_subnetworks = false
}

# Web subnet
resource "google_compute_subnetwork" "web" {
  name          = "web-subnet"
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.main-vpc.id
}

# DB subnet
resource "google_compute_subnetwork" "db" {
  name          = "db-subnet"
  ip_cidr_range = "10.10.2.0/24"
  region        = var.region
  network       = google_compute_network.main-vpc.id
}

# Firewall: allow web-subnet to reach db-subnet on port 5432
resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-web-to-db-postgres"
  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["10.10.1.0/24"]
  target_tags   = ["db"]
}
