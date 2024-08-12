resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.storage.bucket.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = var.storage.bucket.sa_role
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "morgot" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.storage.bucket.bucket_name
  max_size   = var.storage.bucket.bucket_size
  acl        = var.storage.bucket.acl
}