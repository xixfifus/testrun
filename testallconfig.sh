#!/bin/bash

passwd=$1
config="{
  \"inbounds\": [
    {
      \"port\": 8443,
      \"protocol\": \"shadowsocks\",
      \"settings\": {
        \"method\": \"2022-blake3-aes-128-gcm\",
        \"password\": \"$passwd\",
        \"network\": \"tcp,udp\"
      }
    }
  ],
  \"outbounds\": [
    {
      \"protocol\": \"freedom\"
    }
  ]
}"

# Write the configuration to the file
echo "$config" > /usr/local/etc/xray/config.json

# Restart xray service
if [[ -f /etc/systemd/system/xray.service ]]; then
  sudo systemctl restart xray
elif [[ -f /etc/init.d/xray ]]; then
  sudo service xray restart
else
  echo "Error: xray service not found."
  exit 1
fi

# Allow incoming traffic on port 8443
if [[ -x "$(command -v ufw)" ]]; then
  sudo ufw allow 8443/tcp
elif [[ -x "$(command -v firewall-cmd)" ]]; then
  sudo firewall-cmd --add-port=8443/tcp --permanent
  sudo firewall-cmd --reload
else
  echo "Warning: Firewall not found. Please manually allow incoming traffic on port 8443."
fi

echo "Done."
