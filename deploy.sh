#!/bin/bash
echo "Installing git:"
PACKS="git"
USER="yc-user"
apt-get update
apt-get install $PACKS -y

echo "clone remote branch monolith to our folder:"

git clone -b monolith https://github.com/express42/reddit.git

pwd

ls -l

echo "move to reddit project folder:"

cd ~/reddit/

echo "install bundle dependencies:"

/usr/bin/bundle install

echo "run app:"

puma -d
