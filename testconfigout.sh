    ssport=$1
    sspasswd=$2
    vlport=$3
    vlpasswd=$4
    vlpath=$5

    localip=$(curl -s https://ipinfo.io/ip)
    #passwdba624=$passwd
        config="{
        \"log\": {
            \"access\": \"/var/log/xray/access.log\",
            \"error\": \"/var/log/xray/error.log\",
            \"loglevel\": \"warning\"
        },
        \"inbounds\": [
            {
            \"tag\": \"s1616\",
            \"port\": "\"$ssport\"",
            \"protocol\": \"shadowsocks\",
            \"settings\": {
                \"method\": \"aes-128-gcm\",
                \"password\": "\"$sspasswd\"",
                \"network\": \"tcp,udp\"
            }
            },
            {
            \"tag\": \"v1818\",
            \"port\": "\"$vlport\"",
            \"protocol\": \"VLESS\",
            \"settings\": {
                \"clients\": [
                {
                    \"id\": "\"$vlpasswd\"",
                    \"alterId\": 0
                }
                ],
                \"decryption\": \"none\"
            },
            \"streamSettings\": {
                \"network\": \"ws\",
                \"wsSettings\": {
                \"path\": "\"$vlpath\""
                }
            }
            }
        ],
        \"outbounds\": [
            {
            \"tag\": \"16888\", 
            \"protocol\": \"freedom\",
            \"sendThrough\": "\"$localip\"",
            \"settings\": {}
            }
        ],
        \"routing\": {
            \"domainStrategy\": \"IPIfNonMatch\",
            \"rules\": [
            {
                \"inboundTag\": [\"s1616\"],
                \"outboundTag\": \"16888\",
                \"type\": \"field\"
            },
            {
                \"inboundTag\": [\"v1818\"],
                \"outboundTag\": \"16888\",
                \"type\": \"field\"
            }
        ]
        },
        \"dns\": {
            \"servers\": [
            \"https+local://1.1.1.1/dns-query\",
            \"1.1.1.1\",
            \"1.0.0.1\",
            \"8.8.8.8\",
            \"8.8.4.4\",
            \"localhost\",
            \"2001:4860:4860::8888\",
            \"2001:4860:4860::8844\"
            ]
        }
        }"
    
echo  "$config" > /usr/local/etc/xray/config.json
sudo systemctl restart xray
systemctl restart xray
sudo ufw disable
ufw disable
systemctl stop firewalld
systemctl disable firewalld
echo "Is ok!"
