#!/bin/bash
set -eu -o pipefail

echo "Installing awscli..."
sudo apt-get install -y awscli

echo "Installing cloud formation helpers..."
wget https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-1.4-8.tar.gz
tar zxf aws-cfn-bootstrap-1.4-8.tar.gz
(
  cd aws-cfn-bootstrap-1.4
  sudo pip2 install --upgrade .
)

cat > cfn-hup.service <<EOF
[Unit]
Description=Cloud formation helper daemon
[Service]
ExecStart=/usr/local/bin/cfn-hup
Restart=always
Type=simple
[Install]
WantedBy=multi-user.target
EOF
sudo cp cfn-hup.service /etc/systemd/system/cfn-hup.service
sudo ln -s /usr/local /opt/aws  # Buildkite scripts assume /opt/aws/bin/...

# Avoid python3
sudo sed -i 's#!/usr/bin/env python#!/usr/bin/env python2#' /opt/aws/bin/cfn-*

echo "Installing zip utils..."
sudo apt-get install -y zip unzip

echo "Installing bats..."
sudo apt-get install -y git
sudo git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local

echo "Installing bk elastic stack bin files..."
sudo chmod +x /tmp/conf/bin/bk-*
sudo mv /tmp/conf/bin/bk-* /usr/local/bin

echo "Configuring awscli to use v4 signatures..."
sudo aws configure set s3.signature_version s3v4
