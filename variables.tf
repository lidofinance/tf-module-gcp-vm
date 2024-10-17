variable "external_ip" {
  default = false
}

variable "deletion_protection" {
  default = false
}

variable "machine_type" {
  default = "e2-standard-2"
}

variable "boot_disk_size" {
  default = 50
}

variable "boot_disk_type" {
  default = "pd-ssd"
}

variable "extra_disk_size" {
  default = 0
}

variable "extra_disk_type" {
  default = "pd-balanced"
}

variable "extra_disk_snapshot" {
  default = ""
}

variable "boot_disk_auto_delete" {
  default = true
}

variable "tags" {
  default = []
}

variable "description" {
  default = ""
}

variable "service_account_email" {
  default = false
}

variable "ssh_keys" {
  description = "List of public ssh keys that have access to the VM"
  default     = ""
}

variable "backup_enable" {
  default = false
}

variable "extra_disk_name" {
  description = "Name of the extra disk"
  default     = ""
}

# No default

variable "name" {}
variable "env" {}
variable "network" {}
variable "subnetwork" {}
variable "labels" {}
variable "image" {}
variable "zone" {}
