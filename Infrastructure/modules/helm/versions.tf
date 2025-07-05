provider "google" {
  project = var.project_name
  region  = var.region
}

data "google_client_config" "default" {}

data "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
}

provider "kubernetes" {
  host                   = data.google_container_cluster.gke_cluster.endpoint
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes = {
    host                   = data.google_container_cluster.gke_cluster.endpoint
    cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.42.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}