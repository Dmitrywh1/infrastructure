resource "yandex_compute_instance" "controlplane" {
  count       = 1
  name        = "control-plane-${count.index + 1}"
  platform_id = var.vm.k8s_control_plane.platform_id

  zone = data.terraform_remote_state.vpc.outputs.subnet["zone"][count.index]

  resources {
    cores         = var.vm.k8s_control_plane.cores
    memory        = var.vm.k8s_control_plane.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm.k8s_control_plane.disk_size
    }
  }

  scheduling_policy {
    preemptible = var.vm.k8s_control_plane.preemptible
  }

  network_interface {
    subnet_id = data.terraform_remote_state.vpc.outputs.subnet.id[count.index]
    nat       = var.vm.k8s_control_plane.nat_enable
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.ssh_public_key}"
  }
}
