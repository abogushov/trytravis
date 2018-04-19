resource "google_compute_global_forwarding_rule" "default" {
  name       = "default-forwarding-rule"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "default-proxy"
  description = "description"
  url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  name            = "default-url-map"
  default_service = "${google_compute_backend_service.default.self_link}"
}

resource "google_compute_backend_service" "default" {
  name        = "default-backend"
  port_name   = "puma"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = ["${google_compute_http_health_check.default.self_link}"]

  backend {
    group = "${google_compute_instance_group.default.self_link}"
  }
}

resource "google_compute_http_health_check" "default" {
  name               = "default-http-health-check"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 10
  port               = "9292"
}

resource "google_compute_instance_group" "default" {
  name = "default-instance-group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "puma"
    port = "9292"
  }

  zone = "${var.zone}"
}
