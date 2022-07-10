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
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
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
    source      = "${path.module}/files//puma.service"
    destination = "/tmp/puma.service"
  }
  #run bash on remote instance:
provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
