resource "local_file" "k8s_inventory" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    control_plane = yandex_compute_instance.controlplane,
    worker        = yandex_compute_instance.worker,
    ingress       = yandex_compute_instance_group.ingress_k8s
  })
  filename = "${abspath(path.module)}/hosts.yaml"
}

resource "local_file" "k8s_cluster" {
  content  = templatefile("${path.module}/k8s-cluster.tftpl", {
    control_plane = yandex_compute_instance.controlplane,
    ingress       = yandex_compute_instance_group.ingress_k8s
  })
  filename = "${abspath(path.module)}/k8s-cluster.yaml"
}

resource "local_file" "kubectl" {
  content  = templatefile("${path.module}/ip.tftpl", {
    control_plane = yandex_compute_instance.controlplane
  })
  filename = "${abspath(path.module)}/ip_control_plane.cfg"
}
