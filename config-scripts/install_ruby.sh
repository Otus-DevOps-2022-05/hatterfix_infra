#!/bin/bash

echo "Installing ruby & bundle packs:"

PACKS="ruby-full ruby-bundler build-essential"
apt-get update
apt-get install $PACKS -y
