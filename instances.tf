resource "google_compute_instance" "builder" {
  name         = "builder"
  machine_type = "e2-small"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
      // Ephemeral public IP
    }
  }

  tags = toset(google_compute_firewall.builder.source_tags)
}

resource "google_compute_instance" "prod" {
  name         = "prod"
  machine_type = "e2-small"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
      // Ephemeral public IP
    }
  }

  tags = toset(google_compute_firewall.webserver.source_tags)
}

resource "google_compute_instance" "dev" {
  name         = "dev"
  machine_type = "e2-small"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
      // Ephemeral public IP
    }
  }

  tags = toset(google_compute_firewall.webserver.source_tags)
}