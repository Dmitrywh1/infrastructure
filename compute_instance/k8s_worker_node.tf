data "yandex_compute_image" "ubuntu" {
  family = var.vm_compute_image
}

resource "yandex_compute_instance" "worker" {
  count       = var.worker_count
  name        = "worker-${count.index + 1}"
  platform_id = var.vm.worker.platform_id

  zone = data.terraform_remote_state.vpc.outputs.subnet["zone"][count.index]

  resources {
    cores         = var.vm.worker.cores
    memory        = var.vm.worker.memory
    core_fraction = var.vm.worker.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm.worker.disk_size
    }
  }

  scheduling_policy {
    preemptible = var.vm.worker.preemptible
  }

  network_interface {
    subnet_id = data.terraform_remote_state.vpc.outputs.subnet.id[count.index]
    nat       = var.vm.worker.nat_enable
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.ssh_public_key}"
  }
}