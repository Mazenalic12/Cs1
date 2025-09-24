resource "google_cloud_run_service" "frontend" { # maakt een Cloud Run service
  name     = "frontend-service"  # naam van de service
  location = "europe-west1"      # regio

  lifecycle { # regels bij destroy/apply
    prevent_destroy = false
    ignore_changes  = all  # negeert alle wijzigingen
  }

  template { # beschrijving van de container
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"  # test container image
      }
    }
  }

  traffic { # routing van traffic
    percent         = 100   # 100% naar deze versie
    latest_revision = true  # altijd laatste versie
  }
}

# Iedereen mag service oproepen
#resource "google_cloud_run_service_iam_member" "noauth" {
 # location = google_cloud_run_service.frontend.location
 # service  = google_cloud_run_service.frontend.name
 # role     = "roles/run.invoker" # rol voor aanroepen
 # member   = "allUsers"          # iedereen toegang
#}
