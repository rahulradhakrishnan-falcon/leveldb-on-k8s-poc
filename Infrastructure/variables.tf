variable "project_name" {}
variable "org_id" {}
variable "billing_account" {}
variable "cluster_name" {}
variable "region" {}
variable "cluster_autoscaling_enabled" {}
variable "cluster_autoscaling_min_cpu" {}
variable "cluster_autoscaling_max_cpu" {}
variable "cluster_autoscaling_min_memory" {}
variable "cluster_autoscaling_max_memory" {}
variable "registry_name" {}
variable "namespace" {}
variable "helm_release" {}
variable "chart" {}
variable "leveldb_helm_values" {
  type = list(object({
    name  = string
    value = string
  }))
}
variable "bucket_name" {}
