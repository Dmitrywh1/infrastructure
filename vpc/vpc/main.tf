terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  labels = length(keys(var.labels)) >0 ? var.labels: {
    "env"=var.env_name
    "project"="undefined"
  }
}

resource "yandex_vpc_network" "production" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
  count          = length(var.subnets)
  name           = var.env_name == null ? "${var.subnets[count.index].zone}" : "${var.env_name}-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.production.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
  route_table_id = yandex_vpc_route_table.rt.id

  labels = {
    for k, v in local.labels : k => v
  }
}

resource "yandex_vpc_route_table" "rt" {
  folder_id  = var.folder_id
  name       = "k8s-route-table"
  network_id = yandex_vpc_network.production.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.folder_id
  name           = "nat-gateway-k8s"
  shared_egress_gateway {}
}
