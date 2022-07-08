resource "yandex_compute_instance" "app" {
  count = var.counts
  name  = "reddit-app${count.index}"

  labels = {
    tags = "reddit-app"
  }
    resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  platform_id = "standard-v2"

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "yandex_vpc_network" "app-network" {
name = "reddit-app-network"
}
resource "yandex_vpc_subnet" "app-subnet" {
name = "reddit-app-subnet"
zone = "ru-central1-a"
network_id = "${yandex_vpc_network.app-network.id}"
v4_cidr_blocks = ["192.168.10.0/24"]
}
