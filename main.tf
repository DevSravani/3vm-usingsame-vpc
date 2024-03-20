#plugin 
provider "google" {
  credentials = "key.json"
  project     = "empyrean-engine-417717"
  region      = "us-west1"
  #zone       = "us-central1-a"
}
resource "google_compute_network" "vpc_network" {
  name = "my-vpc"
  #zone       = "us-central1-a"
  auto_create_subnetworks = true

}
resource "google_compute_subnetwork" "subnetwork" {
  name    = "my-subnetwork"
  network = google_compute_network.vpc_network.name
  #zone          = "us-west1-a"
  ip_cidr_range = "10.0.0.0/24"

}
resource "google_compute_instance" "vm_instances" {

  #name         = "my-vm"
  count        = 3
  name         = "vm-${count.index + 1}"
  zone         = "us-west1-a"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"

    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {

    }
  }

}
