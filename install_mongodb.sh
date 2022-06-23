#!/bin/bash

echo "Installing mongodb  pack:"
PACKS="libcurl3 git"
USER="yc-user"
DEBPATH="/home/$USER/MongoDB/4.2/"
DEBINST="mongodb-org-tools_4.2.10_amd64.deb mongodb-org-mongos_4.2.10_amd64.deb mongodb-org-server_4.2.10_amd64.deb mongodb-org-shell_4.2.10_amd64.deb mongodb-org_4.2.10_amd64.deb"

apt-get update
apt-get install $PACKS -y

echo "clone Mongodb repo:"

git clone https://github.com/hatterfix/MongoDB.git

echo "move & install mongo:"

cd $DEBPATH

dpkg -i $DEBINST

echo "run & put mongodb to autostart:"
systemctl start mongod
systemctl enable mongod
