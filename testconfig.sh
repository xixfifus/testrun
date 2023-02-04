 passwd=$1
    #passwdba624=$passwd
    config="{
      \"inbounds\": [
        {
          \"port\": 8443,
          \"protocol\": \"shadowsocks\",
          \"settings\": {
            \"method\": \"2022-blake3-aes-128-gcm\",
            \"password\": "\"$passwd\"",
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
    
echo  "$config" > /usr/local/etc/xray/config.json
sudo systemctl restart xray
sudo ufw disable
echo "Is ok!"
