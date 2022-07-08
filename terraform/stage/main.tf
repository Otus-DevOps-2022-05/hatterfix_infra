terraform {
  required_providers {
    #Set provider version that will be installed.
    #If use "~> 0.35" will be installed higher ver.
    yandex = "0.35"
  }
  required_version = "0.12.19"
}
#cloud connection id's:
provider "yandex" {
  version                  = "0.35"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = module.vpc.app_subnet_id
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.app_subnet_id
}

module "vpc" {
  source          = "../modules/vpc"
}
