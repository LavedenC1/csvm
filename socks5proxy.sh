#!/bin/bash

set -e
setup=0

if [[ $setup == 1 ]]; then
    echo "---- Installing Chisel ----"
    curl https://i.jpillora.com/chisel! | bash

    echo "---- Installing Cloudflared ----"
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
    echo "---- Setup done ----"
    echo "Edit the script and change \$setup to 0"

    sleep 3
fi


echo "Connect with the cloudlfare url in the logs"
echo "chisel client https://*.trycloudflare.com socks"

sleep 5

chisel server --socks5 & cloudflared tunnel --url http://localhost:8080
