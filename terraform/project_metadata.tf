resource "google_compute_project_metadata" "default" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}\nappuser3:${file(var.public_key_path)}"
  }
}
