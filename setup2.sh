#!/bin/bash

echo "Setup 2"
echo "THIS IS MEANT TO RUN IN A GITHUB CODESPACE"
echo "DON'T RUN THIS OUTSIDE OF THE CODESPACE UNLESS YOU KNOW WHAT YOU ARE DOING"
echo "Starting in 10 seconds"
sleep 10

echo "---- Installing KasmVNC ----"
CODENAME=$(lsb_release -cs)
KASMVNC_URL=$(curl -s https://api.github.com/repos/kasmtech/KasmVNC/releases/latest \
  | grep "browser_download_url.*${CODENAME}.*amd64.deb" \
  | cut -d '"' -f 4)

echo "Downloading: $KASMVNC_URL"
wget -O kasmvncserver.deb "$KASMVNC_URL"
sudo apt install -y ./kasmvncserver.deb

echo "---- Creating xstartup ----"
mkdir -p ~/.vnc

cat << EOF > ~/.vnc/xstartup
#!/bin/sh
set -x
pulseaudio --start --exit-idle-time=-1 --log-target=file:/tmp/pulseaudio.log
sleep 1

pactl load-module module-null-sink sink_name=VirtualSink sink_properties=device.description="Virtual_Sink"
pactl set-default-sink VirtualSink
pactl set-default-source VirtualSink.monitor

exec dbus-launch --exit-with-session startxfce4
EOF

chmod +x ~/.vnc/xstartup

echo "---- Installing Firefox ----"
cd /tmp
wget 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' -O firefox.tar.xz
tar -xJf firefox.tar.xz
sudo mv firefox /opt/firefox
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
