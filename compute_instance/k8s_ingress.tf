resource "yandex_compute_instance_group" "ingress_k8s" {
  count               = 1
  name                = "ingress-${count.index + 1}"
  folder_id           = var.folder_id
  service_account_id  = var.instance_group.k8s_ingress.sa_id
  deletion_protection = var.instance_group.k8s_ingress.delete_protecton
  instance_template {
    platform_id = var.instance_group.k8s_ingress.platform_id
    resources {
      memory = var.instance_group.k8s_ingress.memory
      cores  = var.instance_group.k8s_ingress.cores
    }
    boot_disk {
      mode = var.instance_group.k8s_ingress.boot_disk_mode
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
        size     = var.instance_group.k8s_ingress.boot_disk_size
      }
    }
    network_interface {
      subnet_ids = [data.terraform_remote_state.vpc.outputs.subnet.id[count.index]]
      nat        = true
    }
    metadata = {
      ssh-keys           = "ubuntu:${var.ssh_public_key}"
      serial-port-enable = var.metadata.serial-port-enable
    }
    network_settings {
      type = var.instance_group.k8s_ingress.network_settings
    }
  }

  scale_policy {
    fixed_scale {
      size = var.instance_group.k8s_ingress.fixed_scale
    }
  }

  allocation_policy {
    zones = var.instance_group.k8s_ingress.allocation_policy
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

#   health_check {
#   interval = 5
#   timeout = 2
#   unhealthy_threshold = 2
#   healthy_threshold = 2

#   tcp_options {
#     port = 80
#   }
# }

  load_balancer {
    target_group_name        = "ingress-k8s"
    target_group_description = "Group for ingress k8s"
  }

}

resource "yandex_lb_network_load_balancer" "lb-k8s" {
  name = var.lb.network.name

  listener {
    name = var.lb.network.listener_name
    port = var.lb.network.port
    external_address_spec {
      ip_version = var.lb.network.ip_version
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ingress_k8s[0].load_balancer.0.target_group_id

    healthcheck {
      name = var.lb.network.health_check_name
    }
  }
}