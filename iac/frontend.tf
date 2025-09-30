resource "google_cloud_run_service" "frontend" {
  name     = "frontend-service"
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url

        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.postgres_instance.private_ip_address
        }
        env {
          name  = "DB_PORT"
          value = "5432"
        }
        env {
          name  = "DB_NAME"
          value = google_sql_database.default.name
        }
        env {
          name  = "DB_USER"
          value = google_sql_user.appuser.name
        }
        env {
          name = "DB_PASSWORD"
          value_from {
            secret_key_ref {
              name = "db-password"
              key  = "latest"
            }
          }
        }
      }
      service_account_name = var.service_account_email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
