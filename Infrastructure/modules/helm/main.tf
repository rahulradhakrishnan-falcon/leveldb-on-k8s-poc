resource "helm_release" "leveldb" {
  name             = var.helm_release
  chart            = var.chart
  create_namespace = var.create_namespace
  namespace        = var.namespace
  set              = var.leveldb_helm_values
}

