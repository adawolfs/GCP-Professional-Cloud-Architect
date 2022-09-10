// Create a compute instance

provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "bridge-cloud-362101"
  region      = "us-east1"
}
  

resource "google_compute_instance" "default" {
  name         = "rustedchipmunk"

  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-8-v20220822"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}