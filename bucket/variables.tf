variable "cloud_id" {
  type        = string
  default     = ""
}

variable "folder_id" {
  type        = string
  default     = ""
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "authorized_key" {
  type        = string
}

variable "storage" {
  type = map(object({
    sa_name          = string
    sa_role          = string
    bucket_name      = string
    bucket_size      = number
    acl              = string
  }))
  default = {
    bucket = {
      sa_name        = "tf-storage-sa_account"
      sa_role        = "editor"
      bucket_name    = "morgotq-tfstate"
      bucket_size    = 1048576
      acl            = "private"
    }
  }
}

variable "registry_name" {
  type    = string
  default = "morgotq-registry"
}