resource "google_compute_network" "default" {
  name = "default-net"
}

resource "google_compute_firewall" "builder" {
  name    = "builder-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["builder"]
}

resource "google_compute_firewall" "webserver" {
  name    = "webserver-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["webserver"]
}
