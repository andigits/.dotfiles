#!/bin/bash

# install.sh
# add new fonets for all users

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

FOLDER="/usr/local/share/fonts/truetype/source-code-pro-ttf"
[ -d $FOLDER ] || mkdir -p $FOLDER

fonts=$(cd `dirname $0` && pwd)
pushd $fonts

unzip -n SourceCodePro.zip *.ttf -d $FOLDER

popd

fc-cache -f
