 passwd=$1
    #passwdba624=$passwd
    config="```
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "tag": "8443",
      "port": 8443,
      "protocol": "shadowsocks",
      "settings": {
        "method": "aes-128-gcm",
        "password": "HjanADnd9QIi5DTAlW533Q==",
        "network": "tcp,udp"
      }
    },
    {
      "tag": "16888",
      "listen": "127.0.0.1",
      "port": 16888,
      "protocol": "VLESS",
      "settings": {
        "clients": [
          {
            "id": "061fec8b-9120-4204-bcce-399aa2ef518c",
            "alterId": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "DreamAutoApi16888"
        }
      }
    }
 ],
  "outbounds": [
    {
      "tag": "16888", 
      "protocol": "freedom",
      "settings": {}
    }
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {
        "inboundTag": ["16888"],
        "outboundTag": "16888",
        "type": "field"
      },
      {
        "inboundTag": ["8443"],
        "outboundTag": "16888",
        "type": "field"
      }
   ]
  },
  "dns": {
    "servers": [
      "https+local://1.1.1.1/dns-query",
      "1.1.1.1",
      "1.0.0.1",
      "8.8.8.8",
      "8.8.4.4",
      "localhost",
      "2001:4860:4860::8888",
      "2001:4860:4860::8844"
    ]
  }
}
```"
    
echo  "$config" > /usr/local/etc/xray/config.json
sudo systemctl restart xray
sudo ufw disable
systemctl stop firewalld
systemctl disable firewalld
echo "Is ok!"
