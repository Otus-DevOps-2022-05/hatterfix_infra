#!/bin/bash

#ARGS
name="reddit-vm"
hostname="reddit-vm"
platform="standard-v2"
image="ubuntu-1604-lts"
subnet="default-ru-central1-a"
memory="1G"
cores="2"
fraction="5"
size="15GB"

yc compute instance create \
  --platform=$platform \
  --name $name \
  --hostname $hostname \
  --memory=$memory \
  --cores=$cores \
  --core-fraction=$fraction \
  --create-boot-disk image-folder-id=standard-images,image-family=$image,size=$size \
  --network-interface subnet-name=$subnet,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=yc-boot.yaml
