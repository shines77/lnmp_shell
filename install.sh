#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

. include/common.sh

# Check whether the login user is a root account?
if [ $(id -u) != "0" ]; then
    Echo_Red "Error: You must be a root logon to run this script, please use root to install the lnamp."
    exit 1
fi

cur_dir=$(pwd)
Stack=$1
if [ "${Stack}" = "" ]; then
    Stack="lnamp"
else
    Stack=$1
fi

. version.sh
. config.sh

. include/main.sh
. include/init.sh
. include/mysql.sh
. include/mariadb.sh
. include/php.sh
. include/nginx.sh
. include/apache.sh
. include/end.sh

Get_Linux_Distribution_Name

if [ "${DISTRO}" = "unknow" ]; then
    Echo_Red "Error: Unable to get Linux distribution name, or do NOT support the current distribution."
    exit 1
fi

clear
echo ""
echo "+------------------------------------------------------------------------+"
echo "|                                                                        |"
echo "|              LNMP/LAMP/LNAMP Shell Script for Linux Server             |"
echo "|                                                                        |"
echo "|                          Version: ${LNAMP_Ver}                                  |"
echo "|                          Host OS: ${DISTRO}                             "
echo "|                                                                        |"
echo "|                        Author by: Licess                               |"
echo "|                      Modified by: shines77                             |"
echo "|                    Last Modified: 2015-08-04                           |"
echo "|                                                                        |"
echo "+------------------------------------------------------------------------+"
echo "|        A tool to auto-compile & install LNMP/LAMP/LNAMP on Linux       |"
echo "+------------------------------------------------------------------------+"
echo "|     For more information please visit http://lnamp.cloudbuses.com      |"
echo "+------------------------------------------------------------------------+"
echo ""

Init_Install()
{
    Press_Install
    Print_Sys_Info
    if [ "${DISTRO}" = "RHEL" ]; then
        RHEL_Modify_Source
    fi
    Get_Linux_Distribution_Version
    if [ "${DISTRO}" = "Ubuntu" ]; then
        Ubuntu_Modify_Source
    fi
    Set_Timezone
    if [ "$PM" = "yum" ]; then
        CentOS_InstallNTP
        CentOS_RemoveAMP
        CentOS_Dependent
    elif [ "$PM" = "apt" ]; then
        Debian_InstallNTP
        Xen_Hwcap_Setting
        Debian_RemoveAMP
        Debian_Dependent
    fi
    Disable_Selinux
    Check_Download_Files
    Install_Autoconf
    Install_Libiconv
    Install_Libmcrypt
    Install_Mhash
    Install_Mcrypt
    Install_Freetype
    Install_Curl
    Install_Pcre
    if [ "${SelectMalloc}" = "2" ]; then
        Install_Jemalloc
    elif [ "${SelectMalloc}" = "3" ]; then
        Install_TCMalloc
    fi
    if [ "$PM" = "yum" ]; then
        CentOS_Lib_Opt
    elif [ "$PM" = "apt" ]; then
        Debian_Lib_Opt
        Debian_Check_MySQL
    fi
    if [ "${DBSelect}" = "1" ]; then
        Install_MySQL_51
    elif [ "${DBSelect}" = "2" ]; then
        Install_MySQL_55
    elif [ "${DBSelect}" = "3" ]; then
        Install_MySQL_56
    elif [ "${DBSelect}" = "4" ]; then
        Install_MariaDB_5
    elif [ "${DBSelect}" = "5" ]; then
        Install_MariaDB_10
    fi
    Export_PHP_Autoconf
}

LNAMP_Stack()
{
    Apache_Selection
    Init_Install
    if [ "${ApacheSelect}" = "1" ]; then
        Install_Apache_22
    else
        Install_Apache_24
    fi
    if [ "${PHPSelect}" = "1" ]; then
        Install_PHP_52
    elif [ "${PHPSelect}" = "2" ]; then
        Install_PHP_53
    elif [ "${PHPSelect}" = "3" ]; then
        Install_PHP_54
    elif [ "${PHPSelect}" = "4" ]; then
        Install_PHP_55
    elif [ "${PHPSelect}" = "5" ]; then
        Install_PHP_56
    fi
    Install_Nginx
    Creat_PHP_Tools
    Add_LNAMP_Startup
    Check_LNAMP_Install
}

LNMP_Stack()
{
    Init_Install
    if [ "${PHPSelect}" = "1" ]; then
        Install_PHP_52
    elif [ "${PHPSelect}" = "2" ]; then
        Install_PHP_53
    elif [ "${PHPSelect}" = "3" ]; then
        Install_PHP_54
    elif [ "${PHPSelect}" = "4" ]; then
        Install_PHP_55
    elif [ "${PHPSelect}" = "5" ]; then
        Install_PHP_56
    fi
    Install_Nginx
    Creat_PHP_Tools
    Add_LNMP_Startup
    Check_LNMP_Install
}

LAMP_Stack()
{
    Apache_Selection
    Init_Install
    if [ "${ApacheSelect}" = "1" ]; then
        Install_Apache_22
    else
        Install_Apache_24
    fi    
    if [ "${PHPSelect}" = "1" ]; then
        Install_PHP_52
    elif [ "${PHPSelect}" = "2" ]; then
        Install_PHP_53
    elif [ "${PHPSelect}" = "3" ]; then
        Install_PHP_54
    elif [ "${PHPSelect}" = "4" ]; then
        Install_PHP_55
    elif [ "${PHPSelect}" = "5" ]; then
        Install_PHP_56
    fi
    Creat_PHP_Tools
    Add_LAMP_Startup
    Check_LAMP_Install
}

case "${Stack}" in   
    lnmp)
        Dispaly_Selection
        LNMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    lamp)
        Dispaly_Selection
        LAMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    lnamp)
        Dispaly_Selection
        LNAMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    test)
        Dispaly_Selection
        Apache_Selection
        ;;
    timezone)
        Set_Timezone
        ;;
    *)
        Echo_Red "Usage: $0 {lnmp|lamp|lnamp}"
        ;;
esac
