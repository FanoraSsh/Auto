#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Auto Script Version 1.1.0"
#link izin ip vps
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

# Color Validation
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(systemctl status ssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]${NC}"
else
status_xray="${RB}[ OFF ]${NC}"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]${NC}"
else
status_nginx="${RB}[ OFF ]${NC}"
fi
if [[ $ssh_service == "running" ]]; then
status_ssh="${GB}[ ON ]${NC}"
else
status_ssh="${RB}[ OFF ]${NC}"
fi
# // Clear
#jumlah user
SSH1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
echo -e "\033[1;93m┌─────────────────────────────────────────────────┐\033[0m" | lolcat
echo -e "      ${WB}━━━━━ [ Bandwidth Monitoring ] ━━━━━${NC}" | lolcat
echo -e "  ${BICyan} Today ${NC}: ${GREEN}$ttoday             ${BICyan} Monyhly ${NC}: ${GREEN}$ttmon" | lolcat
echo -e "\033[1;93m└─────────────────────────────────────────────────┘\033[0m" | lolcat
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e "\E[39;1;92m                    ⇱ STATUS SERVICE ⇲                        \E[0m" | lolcat
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e "${BICyan}┌──────────────────────────────────────────────────┐${NC}" | lolcat
echo -e "  ${BICyan} NGINX ${NC}: ${GREEN}$status_nginx  SSH ${NC}: ${GREEN}$status_ssh ${BICyan} XRAY  ${NC}: ${GREEN}$status_xray"
echo -e "${BICyan}└──────────────────────────────────────────────────┘${NC}" | lolcat
echo -e "\033[1;93m┌─────────────────────────────────────────────────┐\033[0m" 
 echo -e "\033[1;93m│\033[0m            ${RED}SCRIPT BY RERECHAN STORE $NC \033[1;93m           │\033[0m"  | lolcat
 echo -e "\033[1;93m└─────────────────────────────────────────────────┘\033[0m"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "      ██████╗ ░███████╗ ██████╗░ ███████╗" | lolcat
echo -e "      ██╔══██╗ ██╔════╝ ██╔══██╗ ██╔════╝" | lolcat
echo -e "      ██████╔╝ █████╗░ ░██████╔╝ █████╗░░" | lolcat
echo -e "      ██╔══██╗ ██╔══╝░░ ██╔══██╗ ██╔══╝░░" | lolcat
echo -e "      ██║░░██║ ███████╗ ██║░░██║ ███████╗" | lolcat
echo -e "      ╚═╝░░╚═╝ ╚══════╝ ╚═╝░░╚═╝ ╚══════╝" | lolcat
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m•01\e[0m] SSH Menu            [\e[36m•08\e[0m] Speedtest"
echo -e " [\e[36m•02\e[0m] XRAY Menu           [\e[36m•09\e[0m] Tentang Script"
echo -e " [\e[36m•03\e[0m] Trojan Menu         [\e[36m•10\e[0m] Auto Reboot"
echo -e " [\e[36m•04\e[0m] Seting Menu         [\e[36m•11\e[0m] Restart All"
echo -e " [\e[36m•05\e[0m] Panel Domain        [\e[36m•12\e[0m] Edit Baner"
echo -e " [\e[36m•06\e[0m] Hapus RAM Cache     [\e[36m•13\e[0m] Cek Badwith"
echo -e " [\e[36m•07\e[0m] Status Server       [\e[36m•14\e[0m] Monitor Cpu"
echo -e ""
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e " \e[33mClient Name   \E[0m: $nama"
echo -e " \e[33mScrip Version \E[0m: latest version"
echo -e " \e[33mScrip Expired \E[0m: $tanggal"
echo -e "\e[33m Ip VPS        \e[0m: $ipvps"
echo -e " ${YB}Domain${NC}        ${WB}: $domain${NC}"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e   ""
read -p " Pilih menu :  "  opt
echo -e   ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; xmenu ;;
3) clear ; tmenu ;;
4) clear ; menu-set ;;
5) clear ; menu-domain ;;
6) clear ; clearcache ;;
7) clear ; running ;;
8) clear ; speedtest ; exit ;;
9) clear ; about ; exit ;;
10) clear ; auto-reboot ; exit ;;
11) clear ; restart ; exit ;;
12) clear ; nano /etc/baner.rere ; exit ;;
13) clear ; bw ; exit ;;
14) clear ; htop ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) menu ;;
esac
