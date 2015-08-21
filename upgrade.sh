#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

. include/common.sh

# Check whether the logon user is a root account?
Check_Is_Root_Account

cur_dir=$(pwd)
action=$1
shopt -s extglob
Upgrade_Date=$(date +"%Y%m%d%H%M%S")

. version.sh
. config.sh

. include/main.sh
. include/init.sh
. include/upgrade_nginx.sh
. include/upgrade_php.sh
. include/upgrade_mysql.sh
. include/upgrade_mariadb.sh
. include/upgrade_mysql2mariadb.sh

Check_OS_Is_64Bit
Get_Linux_Dist_Name

Display_Upgrade_Menu()
{
    echo ""
    echo "1) Upgrade Nginx"
    echo "2) Upgrade MySQL"
    echo "3) Upgrade MariaDB"
    echo "4) Upgrade PHP for LNMP"
    echo "5) Upgrade PHP for LNAMP or LAMP" 
    echo "6) Upgrade MySQL to MariaDB"
    echo "exit: Exit current script"
    echo ""
    echo "###################################################"
    echo ""
    read -p "Enter your choice (1, 2, 3, 4, 5, 6 or exit): " action
    echo ""
}

clear
echo ""
echo "+------------------------------------------------------------------------+"
echo "|                                                                        |"
Echo_Blue_Ex "|" "             LNMP/LAMP/LNAMP Upgrade Script for Linux Server            " "|"
echo "|                                                                        |"
echo "|                           Version: ${LNMP_Ver}                                 |"
echo "|                           Host OS: ${DISTRO}                            "
echo "|                                                                        |"
echo "|                         Author by: Licess                              |"
echo "|                       Modified by: shines77                            |"
echo "|                     Last Modified: ${LNMP_LastModified}                          |"
echo "|                                                                        |"
echo "+------------------------------------------------------------------------+"
echo "|    A tool to upgrade Nginx, MySQL/Mariadb, PHP for LNMP/LAMP/LNAMP     |"
echo "+------------------------------------------------------------------------+"
echo "|     For more information please visit http://lnamp.cloudbuses.com      |"
echo "+------------------------------------------------------------------------+"
echo ""

if [ "${action}" == "" ]; then
    Display_Upgrade_Menu
fi

case "${action}" in
    1|[nN][gG][iI][nN][xX])
        Upgrade_Nginx 2>&1 | tee /root/upgrade_nginx${Upgrade_Date}.log
        ;;
    2|[mM][yY][sS][qQ][lL])
        Upgrade_MySQL 2>&1 | tee /root/upgrade_mysq${Upgrade_Date}.log
        ;;
    3|[mM][aA][rR][iI][aA][dD][bB])
        Upgrade_MariaDB 2>&1 | tee /root/upgrade_mariadb${Upgrade_Date}.log
        ;;
    4|[pP][hH][pP])
        Stack="lnmp"
        Upgrade_PHP 2>&1 | tee /root/upgrade_lnmp_php${Upgrade_Date}.log
        ;;
    5|[pP][hH][pP][aA])
        Upgrade_PHP 2>&1 | tee /root/upgrade_a_php${Upgrade_Date}.log
        ;;
    6|[mM]2[mM])
        Upgrade_MySQL2MariaDB 2>&1 | tee /root/upgrade_mysql2mariadb${Upgrade_Date}.log
        ;;
    [eE][xX][iI][tT])
        exit 1
        ;;
    *)
        echo "Usage: ./upgrade.sh {nginx|mysql|mariadb|m2m|php|phpa}"
        exit 1
        ;;
esac
