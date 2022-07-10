variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable counts {
  description = "instance count"
  default     = "1"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}

variable subnet_id {
description = "Subnets for modules"
}

variable private_key_path {
  description = "Path to private key for provisioner access"
}
variable ip_mongod {
description = "private mongod IP"
}
