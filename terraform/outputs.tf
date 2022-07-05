output "inst_app_internal_IP" {
  description = "Instance app internal IP:"
  value       = yandex_compute_instance.app.network_interface.0.ip_address
}
output "inst_app_external_IP" {
  description = "Instance app external IP:"
  value       = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
output "balancer_external_IP" {
  description = "Balancer app external IP:"
  value       =  yandex_lb_network_load_balancer.lbalance.listener.*.external_address_spec[0].*.address
}
