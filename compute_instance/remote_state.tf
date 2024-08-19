data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "morgotq-tfstate"
    region = "ru-central1"
    key    = "vpc_terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true

    access_key = var.access_key
    secret_key = var.secret_key

   }
 }
