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
  private_key_path = var.private_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = module.vpc.app_subnet_id
  ip_mongod       = module.db.all_inst_db_internal_IPs
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.app_subnet_id
}

module "vpc" {
  source = "../modules/vpc"
}

resource "local_file" "dynamic_inventory" {
  content = templatefile("../files/ansible_inventory",
    {
      appserver = module.app.all_inst_app_external_IPs
      dbserver = module.db.all_inst_db_external_IPs
    }
  )
  filename = "../../ansible/environments/prod/inventory.json"
}

resource "local_file" "mongo_bind_ip" {
  content = templatefile("../files/mongo_bind_ip",
    {
      mongo_bind_ip = module.db.all_inst_db_internal_IPs
    }
  )
  filename = "../../ansible/environments/prod/group_vars/db"
}

resource "local_file" "db_host_for_app" {
  content = templatefile("../files/db_host",
    {
      db_host = module.db.all_inst_db_internal_IPs
    }
  )
  filename = "../../ansible/environments/prod/group_vars/app"
}
