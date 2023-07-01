 passwd=$1
    #passwdba624=$passwd
    config="{
               \"inbounds\": [
                  {
                    \"port\": 2052, //监听端口
                    \"protocol\": "vless",
                    \"settings\": {
                      \"clients\": [
                        {
                          \"id": "0a652466-dd56-11e9-aa37-5600024c1d6a\", //修改为自己的UUID
                          \"email": "2052@gmail.com\"
                        }
                      ],
                      \"decryption\": \"none\"
                    },
                    \"streamSettings\": {
                      \"network\": \"kcp\",
                      \"security\": \"none\",
                      \"kcpSettings\": {
                        \"uplinkCapacity\": 100,
                        \"downlinkCapacity\": 100,
                        \"congestion\": true, //启用拥塞控制
                        \"seed\": \"60VoqhfjP79nBQyU\" //修改为自己的seed密码
                      }
                    },
                    \"sniffing\": {
                      \"enabled\": true,
                      \"destOverride\": [
                        \"http\",
                        \"tls\"
                      ]
                    }
                  }
                ],
                \"routing\": {
                  \"rules\": [
                    {
                      \"type\": \"field\",
                      \"protocol\": [
                        \"bittorrent\"
                      ],
                      \"outboundTag\": \"blocked\"
                    }
                  ]
                },
                \"outbounds\": [
                  {
                    \"protocol\": \"freedom\",
                    \"settings\": {}
                  },
                  {
                    \"tag\": \"blocked\",
                    \"protocol\": \"blackhole\",
                    \"settings\": {}
                  }
                ]
              }


    
echo  "$config" > /usr/local/etc/xray/config.json
sudo systemctl restart xray
sudo ufw disable
systemctl stop firewalld
systemctl disable firewalld
echo "Is ok!"
