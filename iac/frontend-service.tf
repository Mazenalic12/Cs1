provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Maak de service account aan
resource "google_service_account" "terraform_deployer" {
  account_id   = "terraform-deployer"
  display_name = "Terraform Deployer"
}

# 2. Activeer de Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"
}

# 3. Cloud Run service
resource "google_cloud_run_v2_service" "frontend" {
  name     = "frontend"
  location = var.region

  template {
    containers {
      image = var.image_url
    }

    service_account = google_service_account.terraform_deployer.email
  }

  depends_on = [
    google_project_service.run_api
  ]
}
