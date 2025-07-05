locals {
  gcp_services = toset([
    "container.googleapis.com",
    "file.googleapis.com"
  ])
}