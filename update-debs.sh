#!/bin/bash

cd "`dirname $0`"
ls incoming/*.deb 2>/dev/null || exit 0

reprepro includedeb stretch incoming/*.deb
