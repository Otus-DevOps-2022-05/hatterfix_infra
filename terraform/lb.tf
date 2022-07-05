resource "yandex_lb_target_group" "reddit_group" {
  name      = "app-lb"
  folder_id = var.folder_id

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app.network_interface.0.ip_address
  }
    target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app2.network_interface.0.ip_address
  }
}
resource "yandex_lb_network_load_balancer" "lbalance" {
  name = "test-balancer"
  type = "external"

  listener {
    name = "checker"
    port = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit_group.id
    healthcheck {
      name = "healthcheck"
        http_options {
          port = 9292
        }
    }
  }
}
