resource "google_service_account" "velero" {
  account_id   = "velero"
  display_name = "Velero Service Account"
  project      = var.project_name
}

resource "google_project_iam_member" "velero_roles" {
  for_each = toset([
    "roles/storage.objectAdmin",
    "roles/compute.storageAdmin",
    "roles/iam.serviceAccountUser"
  ])
  project = var.project_name
  role    = each.value
  member  = "serviceAccount:${google_service_account.velero.email}"
}

resource "google_service_account_key" "velero" {
  service_account_id = google_service_account.velero.name
}


