variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for db"
  default     = "reddit-db-base"
}

variable vpc_ip {
  description = "Allowed ip for app"
  default     = "0.0.0.0/0"
}

variable env {
  description = "Environment"
  default     = "test"
}
