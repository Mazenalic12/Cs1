variable "region" {
  description = "GCP region where resources will be created"
  type        = string
  default     = "europe-west1"
}

variable "image_url" {
  description = "URL of the Docker image in Artifact Registry"
  type        = string
  default     = "europe-west1-docker.pkg.dev/cs1-mzn-12345/frontend-repo/vite-frontend"
}

variable "service_account_email" {
  description = "Email of the service account to run Cloud Run"
  type        = string
  default     = "terraform-deployer@cs1-mzn-12345.iam.gserviceaccount.com"
}
