resource "google_service_account" "gke" {
  project      = var.project_name
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke" {
  for_each = toset(["roles/monitoring.metricWriter",
    "roles/artifactregistry.reader",
    "roles/storage.objectUser",
    "roles/storage.bucketViewer",
    "roles/storage.objectCreator",
  "roles/logging.logWriter"])
  project = var.project_name
  role    = each.value
  member  = google_service_account.gke.member
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  project            = var.project_name
  location           = var.region
  initial_node_count = 1
  cluster_autoscaling {
    enabled = var.cluster_autoscaling_enabled
    resource_limits {
      resource_type = "cpu"
      minimum       = var.cluster_autoscaling_min_cpu
      maximum       = var.cluster_autoscaling_max_cpu
    }
    resource_limits {
      resource_type = "memory"
      minimum       = var.cluster_autoscaling_min_memory
      maximum       = var.cluster_autoscaling_max_memory
    }
  }
  node_config {
    service_account = google_service_account.gke.email
  }
}

