#!/bin/bash
# // String / Request Data
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
clear
apt install jq curl -y
sub=$(</dev/urandom tr -dc a-z | head -c4)
DOMAIN=rere02.eu.org
SUB_DOMAIN=${sub}.rere02.eu.org
CF_ID=widyabakti02@gmail.com
CF_KEY=v1.0-171800f2029774576f2fa1a0-3ae8ed9ee5f993f7ed8b0978883130b83c7ded1aedf354aaed8b8e11326c0faadbba51a40e80e8a19f3f5e4bae1c12da21bdff9f2300c71a33a333e8a2ec494faf3140b34d49418f2d
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
     
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /etc/xray/domain
echo "IP=$SUB_DOMAIN" > /var/lib/SIJA/ipvps.conf
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Domain added.."
sleep 3
domain=$(cat /etc/xray/domain)
cp -r /root/domain /etc/xray/domain
read -n 1 -s -r -p "Press any key to back on genssl"

genssl 
