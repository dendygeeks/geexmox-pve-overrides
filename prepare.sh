#!/bin/sh
grep -E 'http://download.proxmox.com/debian/pve\s+buster\s+pve-no-subscription' /etc/apt/sources.list.d/* || { sudo wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg && \
  echo 'deb [arch=amd64] http://download.proxmox.com/debian/pve buster pve-no-subscription' | sudo tee -a /etc/apt/sources.list.d/pve-install-repo.list && sudo apt-get update ; }

sudo apt update
sudo apt upgrade -y
