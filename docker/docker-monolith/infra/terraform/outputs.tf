#output "external_ip_address_lb" {
#  value = yandex_lb_network_load_balancer.lb.listener[*].external_address_spec[*].address
#}

#output "external_ip_address_app" {
#  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
#}
#output "external_ip_address_db" {
#  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
#}

output "external_ip_address_docker" {
  value = yandex_compute_instance.docker.*.network_interface.0.nat_ip_address
}
