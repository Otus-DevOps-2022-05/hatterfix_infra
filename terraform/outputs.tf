output "internal_ip_address_app" {
  description = "Instance app internal IP:"
  value = yandex_compute_instance.app.network_interface.0.ip_address
}
output "external_ip_address_app" {
  description = "Instance app external IP:"
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
