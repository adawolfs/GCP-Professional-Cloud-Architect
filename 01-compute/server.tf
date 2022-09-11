// Create a compute instance

provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "bridge-cloud-362101"
  region      = "us-east1"
}

data "google_client_openid_userinfo" "me" {
}

resource "google_os_login_ssh_public_key" "cache" {
  user =  data.google_client_openid_userinfo.me.email
  key = file("~/.ssh/adawolfs.pub")
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