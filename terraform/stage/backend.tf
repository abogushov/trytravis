terraform {
  backend "gcs" {
    bucket = "storage-bucket-abogushov-infra-state"
    prefix = "terraform/state/stage"
  }
}
