resource "google_storage_bucket" "restic" {
  name          = var.bucket_name
  location      = var.region
  project       = var.project_name
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 90
    }
  }
}