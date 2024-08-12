resource "yandex_container_registry" "morgotq" {
  name      = var.registry_name
  folder_id = var.folder_id
}