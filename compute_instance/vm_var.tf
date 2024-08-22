variable "access_key" {
  type        = string
}

variable "secret_key" {
  type        = string
}

variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "vm_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OC"
}

variable "ssh_public_key" {
  type        = string
}

variable "authorized_key" {
  type        = string
}

variable "worker_count"{
  type        = number
}

variable "controlplane_count"{
  type        = number
}

variable "vm" {
  type = map(object({
    name          = string
    platform_id   = string
    cores         = number
    memory        = number
    core_fraction = number
    nat_enable    = bool
    preemptible   = bool
    disk_size     = number
  }))
  default = {
    worker = {
      name          = "worker"
      platform_id   = "standard-v2"
      cores         = 2
      memory        = 4
      core_fraction = 5
      nat_enable    = false
      preemptible   = true
      disk_size     = 60
    }
    k8s_control_plane = {
      name          = "k8s-control-plane"
      platform_id   = "standard-v2"
      cores         = 2
      memory        = 4
      core_fraction = 5
      nat_enable    = false
      preemptible   = true
      disk_size     = 50
    }
  }
}

variable "metadata" {
  type = map
  default = {
    serial-port-enable = 1
  }
}
