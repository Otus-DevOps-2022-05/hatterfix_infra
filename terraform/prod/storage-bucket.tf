terraform {
  required_providers {
    #Set provider version that will be installed.
    #If use "~> 0.35" will be installed higher ver.
    yandex = "0.35"
  }
    required_version = "0.12.19"

    backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-app-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJET4fC106BE2GZcGKnZCZt"
    secret_key = "YCMbwe8cLgNgXrQxv11HmWiZRMyn3YfG4AgQRl9-"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
