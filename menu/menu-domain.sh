#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear 
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;100;33m        • DOMAIN MENU •            \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "" 
echo -e " [\e[36m•1\e[0m] Mengubah Domain VPS"
echo -e " [\e[36m•2\e[0m] Auto Pointing [ Free Doman ]"
echo -e " [\e[36m•3\e[0m] Perpanjang Sertifikat DOMAIN"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mKEMBALI KE MENU\033[0m"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • Untuk-Keluar"
echo -e   ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; add-host ;;
2) clear ; cf ;;
3) clear ; certv2ray ;;
0) clear ; menu ;;
x) exit ;;
*) echo "Anda salah tekan" ; sleep 1 ; menu-domain ;;
esac
