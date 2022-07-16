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
  # commented for ansible-2
#   #provisioners remote instance actions:
#   #copy unitd:
# provisioner "file" {
#     content     = templatefile("${path.module}/files/mongod.conf", { ip_mongod = yandex_compute_instance.db.0.network_interface.0.ip_address})
#     destination = "/tmp/mongod.conf"
#   }
#   #run bash on remote instance:
# provisioner "remote-exec" {
#     script = "${path.module}/files/replace_mongo_conf.sh"
#   }
}
