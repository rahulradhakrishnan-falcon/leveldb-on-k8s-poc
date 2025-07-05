resource "helm_release" "velero" {
  name       = "velero"
  namespace  = var.velero_namespace
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "10.0.8"

  values = [
    yamlencode({
      credentials = {
        useSecret      = true
        existingSecret = null
        secretContents = {
          cloud = google_service_account_key.velero.private_key
        }
      }
      

      configuration = {
        backupStorageLocation = [{
          name     = "default"
          provider = "gcp"
          bucket   = var.bucket_name
          config = {
            serviceAccount = "/credentials/cloud"
          }
        }]
        volumeSnapshotLocation = [{
          name     = "default"
          provider = "gcp"
        }]
      }

      initContainers = [{
        name  = "velero-plugin-for-gcp"
        image = "velero/velero-plugin-for-gcp:v1.7.0"
        volumeMounts = [{
          mountPath = "/target"
          name      = "plugins"
        }]
      }]
      metrics = {
        enabled = true
        serviceMonitor = {
          enabled = true
        }
      }
    })
  ]

  depends_on = [google_service_account_key.velero]
}



resource "null_resource" "velero_schedule" {
  provisioner "local-exec" {
    command = <<EOT
kubectl apply -f - <<EOF
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: leveldb-daily-backup
  namespace: leveldb
spec:
  schedule: "* * * * *"
  template:
    ttl: "240h"
    includedNamespaces:
      - leveldb
EOF
EOT
  }

  depends_on = [helm_release.velero]
}
