#!/bin/bash

INSTALLDIR=`dirname $0`

echo "Setting up lpadmin group membership"
adduser superuser lpadmin
deluser user lpadmin

echo "Unpacking files"
tar -C / -pxvzf "$INSTALLDIR/printer_files.tar.gz"

echo "Installing python 2.6"
dpkg -i /opt/bibos/printer_install/*.deb

echo "Adding printers:"
echo "Sort/Hvid"
lpadmin -p "SorthvidPrinter" -E -v "sqport://10.37.7.102/secure" -P /opt/bibos/printer_install/sorthvid.ppd
echo "Farve"
lpadmin -p "FarvePrinter" -E -v "sqport://10.37.7.102/secure" -P /opt/bibos/printer_install/farve.ppd
echo "Setting SorthvidPrinter as default printer"
lpadmin -d "SorthvidPrinter"