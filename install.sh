#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

. include/common.sh

# Check whether the logon user is a root account?
Check_Is_Root_Account

cur_dir=$(pwd)
Stack=$1
if [ "${Stack}" = "" ]; then
    Stack="lnmp"
else
    Stack=$1
fi

. version.sh
. config.sh

. include/main.sh
. include/init.sh
. include/memory_allocator.sh
. include/mysql.sh
. include/mariadb.sh
. include/php.sh
. include/nginx.sh
. include/apache.sh
. include/end.sh

Get_Linux_Dist_Name

if [ "${DISTRO}" = "unknow" ]; then
    Echo_Red "Error: Unable to get the Linux distribution name, or do NOT support the current distribution."
    exit 1
fi

clear
echo ""
echo "+------------------------------------------------------------------------+"
echo "|                                                                        |"
Echo_Blue_Ex "|" "              LNMP/LAMP/LNAMP Shell Script for Linux Server             " "|"
echo "|                                                                        |"
echo "|                           Version: ${LNAMP_Ver}                                 |"
echo "|                           Host OS: ${DISTRO}                            "
echo "|                                                                        |"
echo "|                         Author by: Licess                              |"
echo "|                       Modified by: shines77                            |"
echo "|                     Last Modified: ${LNAMP_LastModified}                          |"
echo "|                                                                        |"
echo "+------------------------------------------------------------------------+"
echo "|       A tool to auto-compile & install LNMP/LAMP/LNAMP on Linux        |"
echo "+------------------------------------------------------------------------+"
echo "|     For more information please visit http://lnamp.cloudbuses.com      |"
echo "+------------------------------------------------------------------------+"
echo ""

# Echo_Color_Test
# Echo_Color_Ex_Test

Test_Random

Init_Install()
{
    Press_Install
    Print_Sys_Info
    
    if [ "${DISTRO}" = "RHEL" ]; then
        RHEL_Modify_Source
    fi
    Get_Linux_Dist_Version
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

    Install_MemoryAllocator

    if [ "$PM" = "yum" ]; then
        CentOS_Lib_Opt
    elif [ "$PM" = "apt" ]; then
        Debian_Lib_Opt
        Debian_Check_MySQL
    fi

    Install_MySQL
    Export_PHP_Autoconf
}

LNMP_Stack()
{
    Init_Install

    Install_PHP

    Install_Nginx
    Create_PHP_Tools
    Add_LNMP_Startup
    Check_LNMP_Install
}

LAMP_Stack()
{
    Init_Install

    Install_Apache
    Install_PHP

    Create_PHP_Tools
    Add_LAMP_Startup
    Check_LAMP_Install
}

LNAMP_Stack()
{
    Init_Install

    Install_Apache
    Install_PHP

    Install_Nginx
    Create_PHP_Tools
    Add_LNAMP_Startup
    Check_LNAMP_Install
}

case "${Stack}" in   
    lnmp)
        Display_Selection
        LNMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    lamp)
        Display_Selection
        LAMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    lnamp)
        Display_Selection
        LNAMP_Stack 2>&1 | tee -a /root/lnamp-install.log
        ;;
    test)
        Display_Selection
        ;;
    timezone)
        Set_Timezone
        ;;
    *)
        Echo_Red "Usage: $0 {lnmp|lamp|lnamp}"
        ;;
esac
