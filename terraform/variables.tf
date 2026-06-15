variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
}

variable "artifact_registry_repo" {
  description = "Artifact Registry Repository Name"
  type        = string
}

variable "artifact_registry_format" {
  description = "Artifact Registry Format"
  type        = string
  default     = "DOCKER"
}
