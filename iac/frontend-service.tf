resource "google_cloud_run_v2_service" "frontend" {
  name     = "frontend-service"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.image_url

      ports {
        container_port = 80
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    service_account = var.service_account_email
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
