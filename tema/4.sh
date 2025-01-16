#!/bin/bash
# =========================================
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")

vmc=$(grep -c -E "^### " "/etc/xray/config.json")

ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")

ssx=$(grep -c -E "^## " "/etc/xray/config.json")

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);


#link izin ip vps
url_izin='https://raw.githubusercontent.com/Rerechan02/iziznscript/main/ip'

# Mendapatkan IP VPS saat ini
ip_vps=$(curl -s ifconfig.me)

# Mendapatkan isi file izin.txt dari URL
izin=$(curl -s "$url_izin")

# Memeriksa apakah konten izin.txt berhasil didapatkan
if [[ -n "$izin" ]]; then
  while IFS= read -r line; do
    # Memisahkan nama VPS, IP VPS, dan tanggal kadaluwarsa
    nama=$(echo "$line" | awk '{print $1}')
    ipvps=$(echo "$line" | awk '{print $2}')
    tanggal=$(echo "$line" | awk '{print $3}')

    # Memeriksa apakah IP VPS saat ini cocok dengan IP VPS yang ada di izin.txt
    if [[ "$ipvps" == "$ip_vps" ]]; then
      echo "Nama VPS: $nama"
      echo "IP VPS: $ipvps"
      echo "Tanggal Kadaluwarsa: $tanggal"
      break
    fi
  done <<< "$izin"

  # Memeriksa apakah IP VPS ditemukan dalam izin.txt
  if [[ "$ipvps" != "$ip_vps" ]]; then
    echo "IP VPS tidak ditemukan dalam izin.txt"
    exit 0
  fi
else
  echo "Konten izin.txt tidak berhasil didapatkan dari URL"
  exit 0
fi


clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
export ungu='\033[0;35m'
# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="XdrgVPN"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // SSH Websocket Proxy
ssh_ws=$( systemctl status dropbear | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}aktif${NC}"
else
    status_ws="${RED}tidak aktif${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}Aktif${NC}"
else
    status_nginx="${RED}Tidak aktif${NC}"
fi

# // SSH Websocket Proxy
xray=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}aktif${NC}"
else
    status_xray="${RED}tidak aktif${NC}"
fi
clear
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}       ⇱ SCRIPT FREE SERVER VPN ⇲                 ${NC}"
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "□ Current Domain      = $( cat /etc/xray/domain )"
echo -e "□ Server IP           = $ipvps"
echo -e "□ Clients Name        = $nama"
echo -e "□ Expired Script VPS  = $tanggal"
echo -e "□ AutoScript By       =  ${GREEN}( FN )${NC}"

echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}                ⇱ STATUS LAYANAN ⇲                 ${NC}"
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "  ${GREEN}SSH WebSocket${NC}:[${status_ws}]  ${GREEN}XRAY${NC}:[${status_xray}]  ${GREEN}NGINX${NC} : [${status_nginx}]"
echo -e "${ungu}┌───────────────────────────────────────────────┐${NC}"
echo -e "${ungu}│\033[0m ${BOLD}${YELLOW}              SSH user  XRAY user"
echo -e "${ungu}│\033[0m ${Blue}                   $ssh1      $vmc     $NC"
echo -e "${ungu}└───────────────────────────────────────────────┘${NC}"
echo -e "${CYAN}                 ❇️  V.3.0.0 LTS ❇️"
echo -e ""
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}                   ⇱ FN ⇲                 ${NC}"
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "${GREEN}[01]${NC} • ${COLOR1}SSH & OVPN${NC}  ${GREEN}[04]${NC} • ${COLOR1}CEK SERVICE ALL VPN${NC}"
echo -e "${GREEN}[02]${NC} • ${COLOR1}XRAY${NC}        ${GREEN}[05]${NC} • ${COLOR1}ISETING${NC}"          
echo -e "${GREEN}[03]${NC} • ${COLOR1}TROJAN${NC}      ${GREEN}[06]${NC} • ${COLOR1}TEMA VPS${NC}"
echo -e " ${RED}"
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}                  ⇱ FN ⇲              ${NC}"
echo -e "${ungu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e ""

echo -ne " Select menu : "; read opt
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; xmenu ;;
03 | 3) clear ; tmenu ;;
04 | 4) clear ; running ;;
05 | 5) clear ; menu-set ;;
06 | 6) clear ; tema ;;
00 | 0) clear ; exit ;;
*) clear ; menu ;;
esac
