
# LevelDB k8s Deployment with Resilience, Backup, and Observability

## 🚀 Overview

This project demonstrates a **Kubernetes-native** high availability and backup-ready setup for a LevelDB-based application, with:

- **Resilient architecture** capable of auto-healing and recovery.
- **Restic + LVM-based Velero** integration for snapshot backups.
- **Terraform-driven IaC** for reproducibility and portability.
- **CI/CD with GitHub Actions**.
- **Monitoring with Stackdriver (Cloud Monitoring & Logging)**.
- **GCP-first setup**, but portable to any CNCF-compliant cloud like AWS, Azure, etc.

---

## 📐 High-Level Architecture Flow

![High-Level Architecture](./assets/architecture.png)

## ✅ Functional Highlights

### 📦 Resilience and Recovery
LevelDB is deployed as a Kubernetes StatefulSet with GCE Persistent Disks to ensure data persistence during node or pod failures. Readiness and liveness probes are configured for automated health checks and recovery.

### 💾 Backup & Restore
Backups are handled using Velero with Restic, leveraging LVM snapshots on the node for consistent and efficient volume-level backups, supporting up to 2 TB per pod. Snapshots run every 6 hours to meet the defined RPO. Restore procedures are fully automated and optimized to minimize performance impact.

### 📈 Scalability

LevelDB is inherently single-node and does not support clustering or concurrent writes, making horizontal scaling unfeasible in Kubernetes. Since GCE Persistent Disks are `ReadWriteOnce`, they cannot be shared across multiple pods. Vertical scaling is implemented using Kubernetes VPA to automatically adjust CPU and memory limits for optimal performance of the single LevelDB instance.

For applications that require high availability and horizontal scalability, a better alternative is **Apache Cassandra**. It is a distributed, masterless database that supports replication, clustering, and fault tolerance — making it a strong fit for scalable, production-grade Kubernetes deployments.


### 🚚 Migration Strategy
To minimize downtime during migration, start by redirecting **all new writes** to the LevelDB instance running on Kubernetes, while continuing to serve **reads from the legacy instance**. Once write traffic is stabilized, begin migrating historical data from the old instance to the new one in batches.

After the data is fully copied and verified, gradually shift read traffic to the Kubernetes instance and decommission the legacy node. This staged approach ensures a smooth transition with minimal impact on ongoing operations.

### 🔍 Monitoring & Observability
Integrated with Stackdriver for logs and metrics collection. Alerts are configured for pod restarts, node issues, and backup failures. Developers can inspect logs via Logs Explorer and use dashboards for debugging.

### 🔐 Security & Tooling

The Kubernetes cluster is secured using role-based access control (RBAC) and Google Cloud IAM with least-privilege principles. Backups created by Velero are encrypted at rest in Google Cloud Storage. All service accounts — including those used by Terraform, GitHub Actions, and Velero — are granted only the minimal set of permissions required for their respective tasks.



## 📐 Backup  Flow

![Backup Flow](./assets/backup_process.png)

## 📂 Project Structure & Documentation

This project is organized into the following components:

| Folder         | Description                                                                                     |
|----------------|-------------------------------------------------------------------------------------------------|
| [`application/`](./application/README.md)   | Contains the LevelDB application code and Dockerfile used to build the container image. |
| [`helm_chart/`](./helm_chart/README.md)     | Helm chart used to deploy the LevelDB app on Kubernetes with StatefulSet and PVCs.       |
| [`Infrastructure/`](./Infrastructure/README.md) | Terraform code to provision GCP infrastructure: GKE, Artifact Registry, IAM, Velero, etc. |

Each folder includes its own `README.md` with detailed setup, usage, and configuration instructions.
