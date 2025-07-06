terraform {
  backend "gcs" {
    bucket  = "leveldb-terraform-state"       # Replace with your bucket name
    prefix  = "terraform/state"                # Path within the bucket
  }
}
