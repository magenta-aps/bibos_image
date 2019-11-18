#!/usr/bin/env bash

if [ -z $1 ]
then
    DESTINATION='/'
else
    DESTINATION=$1
fi

# First, special handling of Gnome Control Center
pushd /usr/bin/ > /dev/null
#Try gnome (ubuntu 12)
cp gnome-control-center gnome-control-center.real
#Try unity (ubuntu 14)
cp unity-control-center unity-control-center.real
popd > /dev/null

# Now do the deed
cp -r ../overwrites/* $DESTINATION

# Permissions fixup
chmod 0440 ${DESTINATION}etc/sudoers.d/keep-proxy

# Remove Bluetooth indicator applet from Borger user
DIR=$(dirname $(realpath $0 ))
"$DIR/../../admin_scripts/image_core/remove_bluetooth_applet.sh"

chown root:adm /usr/bin/unity-control-center
chmod o-x /usr/bin/unity-control-center
chmod g+rx,o-x /usr/bin/unity-control-center

