output "ips_and_name_vm" {
  value = [
    [
      for i in yandex_compute_instance.worker : {
      name     = i.name
      local_ip = i.network_interface[0].ip_address
      }
    ],
    [
      for i in yandex_compute_instance.controlplane : {
      name     = i.name
      local_ip = i.network_interface[0].ip_address
      }
    ],
    [
      for i in yandex_compute_instance_group.ingress_k8s : {
      name     = i.instances[0].name
      local_ip = i.instances[0].network_interface[0].ip_address
      }
    ]
  ]
}