#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Auto Script Version 1.1.0"
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2
COLOR1='\033[0;35m'
COLOR2='\033[0;39m'
clear
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
 echo -e "\033[1;93m│\033[0m            ${RED}SCRIPT BY FANORAPREM STORE $NC \033[1;93m           │\033[0m"  | lolcat
 echo -e "\033[1;93m└─────────────────────────────────────────────────┘\033[0m"
 echo -e "${GREEN}┌──────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│  \033[0m ${BOLD}${YELLOW}SSH     VMESS       VLESS      TROJAN          │\033[0m"  | lolcat
echo -e "${GREEN}│  \033[0m ${Blue} $ssh1        $vma           $vla          $tra               $NC  │\033[0m"  | lolcat
echo -e "${GREEN}└──────────────────────────────────────────────────┘${NC}"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m•01\e[0m] SSH & OpenVPN Menu  [\e[36m•11\e[0m] Speedtest"
echo -e " [\e[36m•02\e[0m] Xray Menu           [\e[36m•12\e[0m] Tentang Script"
echo -e " [\e[36m•03\e[0m] Trojan Menu         [\e[36m•13\e[0m] Slowdns Install"
echo -e " [\e[36m•04\e[0m] Auto Reboot         [\e[36m•14\e[0m] Restart All"
echo -e " [\e[36m•05\e[0m] About Script        [\e[36m•15\e[0m] Edit Baner"
echo -e " [\e[36m•06\e[0m] Hapus RAM Cache     [\e[36m•16\e[0m] Cek Badwith"
echo -e " [\e[36m•07\e[0m] Status Server       [\e[36m•17\e[0m] Monitor Cpu"
echo -e " [\e[36m•08\e[0m] Panel Domain        [\e[36m•18\e[0m] Bot Telegram"
echo -e " [\e[36m•09\e[0m] Port Menu           [\e[36m•19\e[0m] Dns Menu"
echo -e " [\e[36m•10\e[0m] Webmin Menu         [\e[36m•20\e[0m] Bypas Streaming"
echo -e ""
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e " ${YB}Client Name   \E[0m: $nama"
echo -e " ${YB}Scrip Version \E[0m: latest version"
echo -e " ${YB}Scrip Expired \E[0m: $tanggal"
echo -e " ${YB}Ip VPS        \e[0m: $ipvps"
echo -e " ${YB}Domain${NC}        ${WB}: $domain${NC}"
echo -e "\e[33m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
echo -e   ""
read -p " Pilih menu :  "  opt
echo -e   ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; xmenu ;;
3) clear ; tmenu ;;
4) clear ; auto-reboot ;;
5) clear ; menu-trojan ;;
6) clear ; clearcache ;;
7) clear ; running ;;
8) clear ; menu-domain ; exit ;;
9) clear ; port-change ; exit ;;
10) clear ; menu-webmin ; exit ;;
11) clear ; speedtest ; exit ;;
12) clear ; about ; exit ;;
13) clear ; auto-reboot ; exit ;;
14) clear ; restart ; exit ;;
15) clear ; nano /etc/issue.net ; exit ;; #ssh-vpn banner.conf
16) clear ; bw ; exit ;;
17) clear ; htop ; exit ;;
18) clear ; python3 -m xolpanel ; exit ;;
19) clear ; dns ; exit ;;
20) clear ; netf ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) menu ;;
esac
