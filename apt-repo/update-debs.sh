#!/bin/bash

cd "`dirname $0`"
ls incoming/*.deb 2>/dev/null || exit 0
rm -rf result
mkdir result
cp incoming/*.deb result/
cd result

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz

cd -
