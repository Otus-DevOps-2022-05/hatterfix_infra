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
    key        = "stage/terraform.tfstate"
    access_key = "YCAJEn8KfuarMkd2HewHw8CKe"
    secret_key = "YCPjRS5mc_0_KLfMD0LsfN1u93wQghBlOMI4ArDW"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
