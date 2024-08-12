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

  labels = {
    for k, v in local.labels : k => v
  }
}
