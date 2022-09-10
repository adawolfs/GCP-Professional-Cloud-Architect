// Create a compute instance

provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "bridge-cloud-362101"
  region      = "us-central1"
}
  

resource "google_compute_instance" "default" {
  name         = "rustedchipmunk"

  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}