variable "instance_group" {
  type = map(object({
    instance_group_name  = string
    delete_protecton     = bool
    platform_id          = string
    memory               = number
    cores                = number 
    boot_disk_mode       = string
    boot_disk_size       = number
    network_settings     = string
    allocation_policy    = list(string)
    fixed_scale          = number
    sa_id                = string
  }))
  default = {
    k8s_ingress = {
      instance_group_name  = "k8s_ingress"
      delete_protecton     = false
      platform_id          = "standard-v2"
      memory               = 4
      cores                = 3
      boot_disk_mode       = "READ_WRITE"
      boot_disk_size       = 50
      network_settings     = "STANDARD"
      allocation_policy    = ["ru-central1-a"]
      fixed_scale          = 1
      sa_id                = "ajeuja7fffuf40etotat"
    }
  }
}

variable "lb" {
  type = map(object({
    name              = string
    listener_name     = string
    port              = number
    ip_version        = string
    health_check_name = string
    health_check_port = number
  }))
  default = {
    network = {
      name              = "nlb-k8s"
      listener_name     = "nlb-k8s"
      port              = 80
      ip_version        = "ipv4"
      health_check_name = "http"
      health_check_port = 80
    }
  }
}

variable "sa_ig" {
  type        = map(string)
  default     = {
    name   = "sa-ig"
    role   = "admin"
  }
}