variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
  default     = "cs1-mzn-12345"
}

variable "region" {
  description = "Default region for resources"
  type        = string
  default     = "europe-west1"
}

variable "image_url" {
  description = "Docker image for frontend Cloud Run service"
  type        = string
  default     = "gcr.io/cs1-mzn-12345/hello:latest"
}

variable "service_account_email" {
  description = "Service account email for Cloud Run service"
  type        = string
  default     = "cs1-mzn-12345-compute@developer.gserviceaccount.com"
}
