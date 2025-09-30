resource "google_project_service" "run_api" {
  service = "run.googleapis.com"
}

resource "google_cloud_run_v2_service" "frontend" {
  name     = "frontend-service"
  location = var.region

  template {
    containers {
      image = var.image_url
    }

    service_account = var.service_account_email
  }

  depends_on = [google_project_service.run_api]
}
