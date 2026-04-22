#!/bin/bash

echo "THIS IS MEANT TO RUN IN A GITHUB CODESPACE"
echo "DON'T RUN THIS OUTSIDE OF THE CODESPACE UNLESS YOU KNOW WHAT YOU ARE DOING"
echo "Starting in 10 seconds"
sleep 10

set -e

echo "---- Installing xcfe and x11 essentials ----"
sudo apt update && sudo apt -y upgrade
sudo apt install -y xfce4 xfce4-goodies dbus-x11 curl wget ssl-cert

echo "---- Certificate Generation ----"
sudo make-ssl-cert generate-default-snakeoil --force-overwrite
sudo chown root:ssl-cert /etc/ssl/private/ssl-cert-snakeoil.key
sudo chmod 640 /etc/ssl/private/ssl-cert-snakeoil.key
sudo usermod -aG ssl-cert $USER
newgrp ssl-cert
