resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.artifact_registry_repo
  description   = "Docker repository for Flask GKE application"
  format        = var.artifact_registry_format

  depends_on = [
    google_project_service.services
  ]
}
