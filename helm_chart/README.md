
---

### 📁 `helm_chart/README.md`

```markdown
# 🧭 Helm Chart for LevelDB Application

This folder contains the Helm chart that deploys the LevelDB application to a Kubernetes cluster.

## 📄 Structure

- `Chart.yaml` — Chart metadata
- `values.yaml` — Default configuration values
- `templates/` — Kubernetes resource templates (StatefulSet, Service, etc.)

## 🚀 Features

- Deploys LevelDB as a `StatefulSet`
- Mounts a PersistentVolumeClaim per pod
- Uses the Docker image built from the `application/` folder
- Includes readiness and liveness probes

