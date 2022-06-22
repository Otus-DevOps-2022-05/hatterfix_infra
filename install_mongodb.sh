#!/bin/bash

echo "Installing mongodb  pack:"
PACKS="mongodb"
apt-get update
apt-get install $PACKS -y

echo "run & put mongodb to autostart:"
systemctl start mongodb
systemctl enable mongodb
