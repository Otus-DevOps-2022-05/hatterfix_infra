#!/bin/bash

echo "Installing ruby & bundle packs:"

PACKS="ruby-full ruby-bundler build-essential libcurl3 git"
USER="yc-user"
DEBPATH="/srv/MongoDB/4.2/"
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

echo "clone remote branch monolith to our folder:"

git clone -b monolith https://github.com/express42/reddit.git


echo "move to reddit project folder:"

cd reddit/

echo "install bundle dependencies:"


/usr/bin/bundle install

echo "run app:"

puma -d
