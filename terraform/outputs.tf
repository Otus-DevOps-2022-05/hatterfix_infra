output "inst_app_internal_IP" {
  description = "Instance app internal IP:"
  value = yandex_compute_instance.app.network_interface.0.ip_address
}
output "inst_app_external_IP" {
  description = "Instance app external IP:"
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
