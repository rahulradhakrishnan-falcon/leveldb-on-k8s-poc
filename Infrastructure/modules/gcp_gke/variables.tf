variable "cluster_name" {}
variable "region" {}
variable "cluster_autoscaling_enabled" {
  default = true
}
variable "cluster_autoscaling_min_cpu" {
  default = 1
}
variable "cluster_autoscaling_max_cpu" {
  default = 2000
}
variable "cluster_autoscaling_min_memory" {
  default = 2
}
variable "cluster_autoscaling_max_memory" {
  default = 10000
}
variable "project_name" {}