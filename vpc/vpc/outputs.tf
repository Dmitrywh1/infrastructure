output "vpc_subnet" {
  value = {
    name       = yandex_vpc_subnet.subnet[*].name,
    zone       = yandex_vpc_subnet.subnet[*].zone,
    network_id = yandex_vpc_subnet.subnet[*].network_id,
    cidr       = yandex_vpc_subnet.subnet[*].v4_cidr_blocks
    id         = yandex_vpc_subnet.subnet[*].id
  }
}

output "vpc" {
  value = {
    id       = yandex_vpc_network.production.id
  }
}