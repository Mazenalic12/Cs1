resource "google_cloud_run_v2_service" "frontend" {
  name     = "frontend"
  location = "europe-west1"
  project  = var.project_id

  template {
    containers {
      image = "europe-west1-docker.pkg.dev/cs1-mzn-12345/frontend-repo/vite-frontend"
      ports {
        container_port = 80
      }
    }

    service_account = google_service_account.terraform_deployer.email
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.run_api]
}
