#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

SCRIPT=$(readlink -f $0)
DIR=`dirname $SCRIPT`

cp etc/apt/preferences.d/pve_override /etc/apt/preferences.d/geexmox_pve_override
echo "deb [trusted=yes] file:"$DIR/result ./ > /etc/apt/sources.list.d/geexmox_local.list

apt-get update

