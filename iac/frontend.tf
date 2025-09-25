resource "google_cloud_run_service" "frontend" {
  name     = "frontend-service"
  location = "europe-west1"
  project  = "cs1-mzn-12345"  # ✅ AANGEPAST

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Iedereen mag de Cloud Run service aanroepen (optioneel activeren)
# resource "google_cloud_run_service_iam_member" "noauth" {
#   location = google_cloud_run_service.frontend.location
#   service  = google_cloud_run_service.frontend.name
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }
