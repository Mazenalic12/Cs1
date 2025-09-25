terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = "cs1-mzn-12345"   # ✅ JOUW NIEUWE PROJECT ID
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

# ---- APIs activeren ----
resource "google_project_service" "servicenetworking" {
  project            = "cs1-mzn-12345"  # ✅ AANGEPAST
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "sqladmin" {
  project            = "cs1-mzn-12345"  # ✅ AANGEPAST
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

# ---- Netwerk configuratie ----
resource "google_compute_network" "vpc_network" {
  name                    = "main-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web_subnet" {
  name          = "web-subnet"
  ip_cidr_range = "10.10.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db-subnet"
  ip_cidr_range = "10.10.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.10.0.0/16"]
}

# ---- Private Service Connection ----
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "services/servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  depends_on = [
    google_project_service.servicenetworking
  ]
}
