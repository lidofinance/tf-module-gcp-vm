# Create IP
resource "google_compute_address" "ext_ip" {
  count        = var.external_ip ? 1 : 0
  name         = "ext-ip-${var.name}"
  description  = "External IP for ${var.name} in ${var.env} environment"
  address_type = "EXTERNAL"
  region       = substr(var.zone, 0, length(var.zone) - 2)
}

# Create additional disk
resource "google_compute_disk" "ext_disk" {
  count    = var.extra_disk_size == 0 ? 0 : 1
  name     = var.extra_disk_name == "" ? "${var.name}-extra" : var.extra_disk_name
  type     = var.extra_disk_type # pd-balanced, pd-balanced, pd-ssd
  snapshot = var.extra_disk_snapshot == "" ? "" : var.extra_disk_snapshot
  zone     = var.zone
  labels   = var.labels
  size     = var.extra_disk_size
}

# Create snapshot policy
resource "google_compute_resource_policy" "ext_disk" {
  count  = var.backup_enable && var.extra_disk_size != 0 ? 1 : 0
  name   = var.extra_disk_name == "" ? "${var.name}-backup-policy" : "${var.extra_disk_name}-backup-policy"
  region = substr(var.zone, 0, length(var.zone) - 2)
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.snapshot_schedule_days_in_cycle
        start_time    = var.snapshot_schedule_start_time
      }
    }
    retention_policy {
      max_retention_days    = var.snapshot_schedule_max_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "ext_disk" {
  count = var.backup_enable && var.extra_disk_size != 0 ? 1 : 0
  name  = google_compute_resource_policy.ext_disk[0].name
  disk  = google_compute_disk.ext_disk[0].name
  zone  = var.zone
}

# Create instance
resource "google_compute_instance" "vm" {
  name                      = var.name
  machine_type              = var.machine_type
  zone                      = var.zone
  deletion_protection       = var.deletion_protection
  description               = var.description
  allow_stopping_for_update = var.stopping_for_update
  labels                    = var.labels
  tags                      = var.tags

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
    auto_delete = var.boot_disk_auto_delete
  }

  dynamic "attached_disk" {
    for_each = var.extra_disk_size == 0 ? [] : [1]
    content {
      source      = google_compute_disk.ext_disk[0].id
      device_name = var.name
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    stack_type = "IPV4_ONLY"
    dynamic "access_config" {
      for_each = var.external_ip == false ? [] : [1]
      content {
        nat_ip = google_compute_address.ext_ip[0].address
      }
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys == "" ? "" : join("\n", [for key in var.ssh_keys : "${key.user}:${key.publickey}"])
  }

  dynamic "service_account" {
    for_each = var.service_account_email == false ? [] : [1]
    content {
      email  = var.service_account_email
      scopes = ["cloud-platform"]
    }

  }

  depends_on = [
    google_compute_address.ext_ip,
    google_compute_disk.ext_disk
  ]

}

