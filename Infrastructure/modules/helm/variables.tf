variable "project_name" {}
variable "region" {}
variable "cluster_name" {}
variable "helm_release" {}
variable "chart" {}
variable "create_namespace" {
  default = true
}
variable "namespace" {}
variable "leveldb_helm_values" {
  type = list(object({
    name  = string
    value = string
  }))
}

