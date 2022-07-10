#!/bin/bash

#replace mongod.conf with bindIP var
sudo mv  /tmp/mongod.conf /etc/mongod.conf
sudo systemctl restart mongod
