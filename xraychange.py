import sys
import json

# 读取命令行参数
tag = sys.argv[1]
new_address = sys.argv[2]

# 打开文件并解析JSON
with open('/usr/local/etc/xray/config.json') as f:
    config = json.load(f)

# 遍历outbounds列表，查找指定的tag并修改address
for outbound in config['outbounds']:
    if outbound.get('tag') == tag:
        outbound['settings']['servers'][0]['address'] = new_address
        break

# 将修改后的JSON写回文件
with open('/usr/local/etc/xray/config.json', 'w') as f:
    json.dump(config, f, indent=2)
    
with open('/usr/local/etc/xray/config.json') as f:
    config = json.load(f)

# 遍历outbounds列表，查找指定的tag并修改address
for outbound in config['outbounds']:
    if outbound.get('tag') == tag:
        print("修改后"+tag+"的ip为"+outbound['settings']['servers'][0]['address'])
        break
