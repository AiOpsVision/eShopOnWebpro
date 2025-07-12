#!/bin/bash
set -e

apt-get update -y && apt-get upgrade -y

apt-get install -y python3 python3-pip

apt-get install -y curl git unzip apt-transport-https ca-certificates software-properties-common

apt-get install -y ufw || true

ufw allow 5000/tcp || true
ufw allow OpenSSH || true
ufw --force enable || true

chmod 700 /home/ubuntu/.ssh || true
chown ubuntu:ubuntu /home/ubuntu/.ssh -R || true

echo "Provisioning done at $(date)" > /var/log/provisioning.log
