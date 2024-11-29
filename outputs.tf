output "vm_ext_ip" {
  value = var.external_ip ? google_compute_address.ext_ip[0].address : null
}

output "vm_int_ip" {
  value = google_compute_instance.vm.network_interface.0.network_ip
}

output "vm_name" {
  value = google_compute_instance.vm.name
}

output "labels" {
  value = google_compute_instance.vm.labels
}

output "team" {
  value = google_compute_instance.vm.labels["team"]
}
