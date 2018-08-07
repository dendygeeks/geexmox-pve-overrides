#!/bin/bash

cd "`dirname $0`/incoming"
shopt -s nullglob

for pkg in *.deb
do
	find ../pool -name $pkg | grep "$pkg" >/dev/null && rm "$pkg"
done
