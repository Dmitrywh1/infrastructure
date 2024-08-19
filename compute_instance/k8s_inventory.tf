resource "local_file" "k8s_inventory" {
  version = "2.5.1"
  content  = templatefile("${path.module}/hosts.tftpl", {
    control_plane = yandex_compute_instance.controlplane,
    worker        = yandex_compute_instance.worker,
    ingress       = yandex_compute_instance_group.ingress_k8s
  })
  filename = "${abspath(path.module)}/hosts.yaml"
}