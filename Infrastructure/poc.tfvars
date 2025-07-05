project_name                   = "testing-poc-leveldb-new"
org_id                         = "" #add org_id
billing_account                = "" #add billing_id
cluster_name                   = "leveldb-cluster"
region                         = "us-central1"
cluster_autoscaling_enabled    = true
cluster_autoscaling_min_cpu    = 1
cluster_autoscaling_max_cpu    = 2000
cluster_autoscaling_min_memory = 2
cluster_autoscaling_max_memory = 10000
registry_name                  = "leveldb-app"
namespace                      = "leveldb"
helm_release                   = "leveldb"
leveldb_helm_values = [
  {
    name  = "image.repository"
    value = "us-central1-docker.pkg.dev/testing-poc-leveldb-new/leveldb-app/leveldb-app"
  },
  {
    name  = "image.tag"
    value = "latest"
  }
]

chart       = "../helm_chart/leveldb-app"
bucket_name = "poc_restic_backup"