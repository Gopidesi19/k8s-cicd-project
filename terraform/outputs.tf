output "enabled_services" {
  description = "Enabled APIs"
  value       = keys(google_project_service.services)
}

output "vpc_name" {
  description = "VPC Name"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "Subnet Name"
  value       = google_compute_subnetwork.subnet.name
}

output "gke_cluster_name" {
  description = "GKE Cluster Name"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_endpoint" {
  description = "GKE Cluster Endpoint"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "artifact_registry_repository" {
  description = "Artifact Registry Repository Name"
  value       = google_artifact_registry_repository.docker_repo.repository_id
}

output "artifact_registry_url" {
  description = "Artifact Registry Docker URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}"
}

output "github_actions_service_account_email" {
  description = "GitHub Actions Service Account Email"
  value       = google_service_account.github_actions_sa.email
}
