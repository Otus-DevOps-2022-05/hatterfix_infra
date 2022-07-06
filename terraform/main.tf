terraform {
  required_providers {
    #Set provider version that will be installed.
    #If use "~> 0.35" will be installed higher ver.
    yandex = "0.35"
  }
  required_version = "0.12.19"
}
#cloud connection id's:
provider "yandex" {
  version                  = "0.35"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
#instance-1 resource description section:
resource "yandex_compute_instance" "app" {
  count = var.counts
  name  = "reddit-app${count.index}"
  #add pubkey to user from local file:
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  platform_id = "standard-v2"

  boot_disk {
    initialize_params {
      #my packer-base image ID
      image_id = var.image_id
    }
  }

  network_interface {
    #my ru-central1-a ID
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat       = true

  }
  #provisioners instance connection details:
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  #provisioners remote instance actions:
  #copy unitd:
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  #run bash on remote instance:
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "reddit-app-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.app-network.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
