terraform {
  required_providers {
#Set provider version that will be installed.
#If use "~> 0.35" will be installed higher ver.
    yandex = "0.35"
  }
  required_version = "0.12.8"
}
#cloud connection id's:
provider "yandex" {
version   = "0.35"
token = "AQAAAABiRgsdAATuwcG98aBcH0_UmNpNcKboKAM"
cloud_id = "<b1ggm1096pprqloi3qe2"
folder_id = "b1gb9b379sd4f3hc8sc1"
zone = "ru-central1-a"
}
#instance resource description section:
resource "yandex_compute_instance" "app" {
  name = "reddit-app"
#add pubkey to user from local file:
   metadata = {
   ssh-keys = "ubuntu:${file("~/.ssh/3kIT_ed_ND.pub")}"
  }

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

platform_id="standard-v2"

  boot_disk {
    initialize_params {
      #my packer-base image ID
      image_id = "fd84rgtv70aufps6aak2"
    }
  }

  network_interface {
    #my ru-central1-a ID
    subnet_id = "e9b83j34mkv9etq0q9kc"
    nat       = true
  }
#provisioners instance connection details:
  connection {
  type = "ssh"
  host = yandex_compute_instance.app.network_interface.0.nat_ip_address
  user = "ubuntu"
  agent = false
  private_key = file("~/.ssh/3kIT_ed_ND")
  }
#provisioners remote instance actions:
#copy unitd:
  provisioner "file" {
  source = "files/puma.service"
  destination = "/tmp/puma.service"
  }
#run bash on remote instance:
  provisioner "remote-exec" {
  script = "files/deploy.sh"
  }
}
