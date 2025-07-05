resource "google_artifact_registry_repository" "repo" {
  project       = var.project_name
  location      = var.region
  repository_id = var.repository_id
  description   = var.description
  format        = var.format
  docker_config {
    immutable_tags = var.immutable_tags
  }
}
