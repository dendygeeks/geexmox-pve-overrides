#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cp etc/apt/preferences.d/pve_override /etc/apt/preferences.d/geexmox
echo "deb [trusted=yes] file:" `dirname $0`/result ./ > /etc/apt/sources.list.d/geexmox

apt-get update

