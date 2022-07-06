resource "yandex_compute_instance" "db" {
  count = var.counts
  name  = "reddit-db${count.index}"

  labels = {
    tags = "reddit-db"
  }

    resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  platform_id = "standard-v2"

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
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
