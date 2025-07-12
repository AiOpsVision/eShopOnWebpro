#!/bin/bash
set -e

apt-get update -y && apt-get upgrade -y

apt-get install -y python3 python3-pip

apt-get install -y curl git unzip apt-transport-https ca-certificates software-properties-common gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

ufw allow OpenSSH || true
ufw --force enable || true

chmod 700 /home/ubuntu/.ssh || true
chown ubuntu:ubuntu /home/ubuntu/.ssh -R || true

echo "DB Provisioning done at $(date)" > /var/log/db_provisioning.log
