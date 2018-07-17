#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

wget https://dendygeeks.github.io/geexmox-pve-overrides/etc/apt/preferences.d/geexmox -O /etc/apt/preferences.d/geexmox
wget https://dendygeeks.github.io/geexmox-pve-overrides/etc/apt/sources.list.d/geexmox.list -O /etc/apt/sources.list.d/geexmox.list

apt-get update

