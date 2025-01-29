variable "external_ip" {
  type        = string
  default     = false
  description = "Access configurations, i.e. IPs via which this instance can be accessed via the Internet."
}

variable "snapshot_schedule_days_in_cycle" {
  type        = number
  default     = 1
  description = "Defines a schedule with units measured in days."
}

variable "snapshot_schedule_start_time" {
  type        = string
  default     = "04:00"
  description = "Time within the window to start the operations. It must be in an hourly format 'HH:MM', where HH : [00-23] and MM : [00] GMT. eg: 21:00"
}

variable "snapshot_schedule_max_retention_days" {
  type        = number
  default     = 30
  description = "Maximum age of the snapshot that is allowed to be kept."
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Enable deletion protection on this instance."
}

variable "machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "The machine type to create."
}

variable "boot_disk_size" {
  type        = number
  default     = 50
  description = "Size for a new disk that will be created alongside the new instance."
}

variable "boot_disk_type" {
  type        = string
  default     = "pd-ssd"
  description = "The GCE disk type. Such as pd-standard, pd-balanced or pd-ssd."
}

variable "extra_disk_size" {
  type        = number
  default     = 0
  description = "Size for the additionsl disk."
}

variable "extra_disk_type" {
  type        = string
  default     = "pd-balanced"
  description = "The GCE disk type."
}

variable "extra_disk_snapshot" {
  type        = string
  default     = ""
  description = "The source snapshot used to create this disk."
}

variable "boot_disk_auto_delete" {
  type        = bool
  default     = true
  description = "Whether the disk will be auto-deleted when the instance is deleted."
}

variable "tags" {
  type        = list(any)
  default     = []
  description = "A list of network tags to attach to the instance."
}

variable "description" {
  type        = string
  default     = ""
  description = "A brief description of this resource."
}

variable "service_account_email" {
  type        = bool
  default     = false
  description = "The service account of an instance."
}

variable "ssh_keys" {
  type        = string
  default     = ""
  description = "List of public ssh keys that have access to the VM"
}

variable "backup_enable" {
  type        = bool
  default     = false
  description = "Enable backup for additional disk"
}

variable "extra_disk_name" {
  type        = string
  default     = ""
  description = "Name of the extra disk"
}

variable "stopping_for_update" {
  type        = bool
  default     = true
  description = "If true, allows Terraform to stop the instance to update its properties."
}

# No default

variable "name" {
  type        = string
  description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
}

variable "env" {
  type        = string
  description = "Environment name for instance description"
}
variable "network" {
  type        = string
  description = "Networks to attach to the instance."
}
variable "subnetwork" {
  type        = string
  description = "The name or self_link of the subnetwork to attach to interface"
}
variable "labels" {
  type        = string
  description = "A map of key/value label pairs to assign to the instance."
}
variable "image" {
  type        = string
  description = "The image from which to initialize this disk."
}
variable "zone" {
  type        = string
  description = "The zone that the machine should be created in. If it is not provided, the provider zone is used."
}
