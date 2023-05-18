import json
import subprocess
import shutil
import sys

passwd = sys.argv[1]
config = {
    "inbounds": [
        {
            "port": 8443,
            "protocol": "shadowsocks",
            "settings": {
                "method": "2022-blake3-aes-128-gcm",
                "password": passwd,
                "network": "tcp,udp"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}

# Write the configuration to the file
with open("/usr/local/etc/xray/config.json", "w") as config_file:
    json.dump(config, config_file)

# Restart xray service
if shutil.which("systemctl"):
    subprocess.run(["systemctl", "restart", "xray"], check=True)
elif shutil.which("service"):
    subprocess.run(["service", "xray", "restart"], check=True)
else:
    print("Error: xray service not found.")
    sys.exit(1)

# Allow incoming traffic on port 8443
if shutil.which("ufw"):
    subprocess.run(["ufw", "allow", "8443/tcp"], check=True)
elif shutil.which("firewall-cmd"):
    subprocess.run(["firewall-cmd", "--add-port=8443/tcp", "--permanent"], check=True)
    subprocess.run(["firewall-cmd", "--reload"], check=True)
else:
    print("Warning: Firewall not found. Please manually allow incoming traffic on port 8443.")

print("Done.")
