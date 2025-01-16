#!/bin/bash
clear
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
blue='\033[0;34m'
ungu='\033[0;35m'
Green="\033[32m"
Red="\033[31m"
WhiteB="\e[5;37m"
BlueCyan="\e[5;36m"
Green_background="\033[42;37m"
Red_background="\033[41;37m"
Suffix="\033[0m"


echo -e "${BlueCyan}==================================================${NC}"
echo -e "${yellow}                     tema settings"
echo -e "${BlueCyan}__________________________________________________${NC}"
echo -e "${WhiteB}"
echo "[1]. SIMPLE TEMA 1"
echo "[2]. TEMA 2"
echo "[3]. TEMA 3"
echo "[4]. TEMA 4"
echo "[5]. TEMA 5"
echo -e "${BlueCyan}"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; rm -fr /usr/bin/menu ; wget -O /usr/bin/menu "https://raw.githubusercontent.com/Rerechan02/Example/main/tema/1.sh" ; chmod +x /usr/bin/* ; menu ;;
2) clear ; rm -fr /usr/bin/menu ; wget -O /usr/bin/menu "https://raw.githubusercontent.com/Rerechan02/Example/main/tema/2.sh" ; chmod +x /usr/bin/* ; menu ;;
3) clear ; rm -fr /usr/bin/menu ; wget -O /usr/bin/menu "https://raw.githubusercontent.com/Rerechan02/Example/main/tema/3.sh" ; chmod +x /usr/bin/* ; menu ;;
4) clear ; rm -fr /usr/bin/menu ; wget -O /usr/bin/menu "https://raw.githubusercontent.com/Rerechan02/Example/main/tema/4.sh" ; chmod +x /usr/bin/* ; menu ;;
5) clear ; rm -fr /usr/bin/menu ; wget -O /usr/bin/menu "https://raw.githubusercontent.com/Rerechan02/Example/main/tema/5.sh" ; chmod +x /usr/bin/* ; menu ;;
esac