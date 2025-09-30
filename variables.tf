variable "region" {
  description = "GCP region where resources will be created"
  type        = string
  default     = "europe-west1"
}

variable "image_url" {
  description = "URL of the Docker image in Artifact Registry"
  type        = string
  # Vervang deze waarde als je het zeker weet
  default     = "europe-west1-docker.pkg.dev/cs1-mzn-12345/frontend-repo/vite-frontend"
}
