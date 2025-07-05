variable "repository_id" {
  description = "ID of the Artifact Registry repository (name)"
  type        = string
}

variable "description" {
  description = "Description of the repo"
  type        = string
  default     = "Artifact registry for LevelDB app"
}

variable "region" {
  description = "Region for the registry (e.g., us-central1)"
  type        = string
  default     = "us-central1"
}

variable "format" {
  description = "Repository format (e.g., DOCKER)"
  type        = string
  default     = "DOCKER"
}

variable "immutable_tags" {
  description = "If true, tags cannot be changed"
  type        = bool
  default     = false
}

variable "project_name" {}