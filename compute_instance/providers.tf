terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.124.0"
    }
  }
  required_version = ">=1.5"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "morgotq-tfstate"
    region = "ru-central1"
    key    = "compute_instance_terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true

  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = var.authorized_key #file("../authorized_key.json")
}
