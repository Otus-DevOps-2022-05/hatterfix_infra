terraform {
  required_providers {

    yandex = "0.35"
  }
  required_version = "0.12.8"
}

provider "yandex" {
version   = "0.35"
token = "AQAAAABiRgsdAATuwcG98aBcH0_UmNpNcKboKAM"
cloud_id = "<b1ggm1096pprqloi3qe2"
folder_id = "b1gb9b379sd4f3hc8sc1"
zone = "ru-central1-a"
}
resource "yandex_compute_instance" "app" {
  name = "reddit-app"

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
      # my packer-base image ID
      image_id = "fd84rgtv70aufps6aak2"
    }
  }

  network_interface {
    # my ru-central1-a ID
    subnet_id = "e9b83j34mkv9etq0q9kc"
    nat       = true
  }

  provisioner "file" {
  source = "files/puma.service"
  destination = "/tmp/puma.service"
  }
}
