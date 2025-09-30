resource "google_sql_database_instance" "postgres_instance" {
  name             = "my-postgres-db"
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-custom-1-3840"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main-vpc.self_link
    }
  }
}

# Default database
resource "google_sql_database" "default" {
  name     = "appdb"
  instance = google_sql_database_instance.postgres_instance.name
}

# App user
resource "google_sql_user" "appuser" {
  name     = "appuser"
  instance = google_sql_database_instance.postgres_instance.name
  password = "ChangeMeStrongPassword!" # beter via secret manager
}
