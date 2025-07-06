
---

### 📁 `Infrastructure/README.md`

```markdown
# 🏗️ Infrastructure as Code (Terraform)

This folder contains all Terraform configuration needed to provision the cloud infrastructure for the LevelDB application.

## 🌐 Provisioned Resources

- GCP Project (if needed)
- Artifact Registry (for container images)
- GKE Cluster (Kubernetes Engine)
- Node pools with optional LVM support
- IAM roles and service accounts
- Helm chart deployment via Terraform
- Velero backup setup (with Restic + LVM)
- VPC, Subnets, and GCS buckets (if required)

## 📂 Structure

- `main.tf` / `modules/` — Core infrastructure
- `terraform.tfvars` — Environment-specific config
- `outputs.tf` — Outputs like cluster name, image registry, etc.

## 🚀 Usage

```bash
terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"

## 🗂️ Terraform State Management

Terraform state is stored remotely in a Google Cloud Storage (GCS) bucket configured in `backend.tf`.

### 🔐 Locking & Versioning

The GCS bucket has **object versioning enabled** to support state locking and recovery. This prevents concurrent operations from corrupting the state file and provides historical versions in case of failure.

> ⚠️ Ensure the bucket is created before running `terraform init`. You can provision it manually or via Terraform in a bootstrap phase.

### ✅ Example

```hcl
terraform {
  backend "gcs" {
    bucket  = "leveldb-terraform-state"
    prefix  = "terraform/state"
  }
}
