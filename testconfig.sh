 passwd=$1
    #passwdba624=$passwd
    config="{
      \"inbounds\": [
        {
          \"port\": 8443,
          \"protocol\": \"shadowsocks\",
          \"settings\": {
            \"method\": \"aes-128-gcm\",
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
systemctl stop firewalld
systemctl disable firewalld
echo "Is ok!"
