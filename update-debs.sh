#!/bin/bash

cd "`dirname $0`"
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
