resource "google_sql_database_instance" "postgres_instance" {
  name             = "my-postgres-db"
  database_version = "POSTGRES_14"
  region           = "europe-west1"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.self_link
    }
  }

  deletion_protection = false

  depends_on = [
    google_service_networking_connection.private_vpc_connection,
    google_project_service.sqladmin
  ]
}

resource "google_sql_user" "default" {
  name     = "dbuser"
  instance = google_sql_database_instance.postgres_instance.name
  password = "Welkom01!"
}

resource "google_sql_database" "my_db" {
  name     = "app_database"
  instance = google_sql_database_instance.postgres_instance.name
}
