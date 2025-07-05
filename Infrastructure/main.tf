module "gcp_gke" {
  source                         = "./modules/gcp_gke"
  cluster_name                   = var.cluster_name
  region                         = var.region
  cluster_autoscaling_enabled    = var.cluster_autoscaling_enabled
  cluster_autoscaling_min_cpu    = var.cluster_autoscaling_min_cpu
  cluster_autoscaling_max_cpu    = var.cluster_autoscaling_max_cpu
  cluster_autoscaling_min_memory = var.cluster_autoscaling_min_memory
  cluster_autoscaling_max_memory = var.cluster_autoscaling_max_memory
  project_name                   = var.project_name
}

module "artifact_registry" {
  source        = "./modules/gcp_registry"
  repository_id = var.registry_name
  project_name  = var.project_name
}

module "helm" {
  source              = "./modules/helm"
  namespace           = var.namespace
  cluster_name        = var.cluster_name
  helm_release        = var.helm_release
  chart               = var.chart
  region              = var.region
  project_name        = var.project_name
  leveldb_helm_values = var.leveldb_helm_values
}

module "velero" {
  source           = "./modules/velero"
  project_name     = var.project_name
  bucket_name      = var.bucket_name
  region           = var.region
  cluster_name     = var.cluster_name
  velero_namespace = var.namespace
}

