#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

. include/common.sh

# Check whether the logon user is a root account?
Check_Is_Root_Account

cur_dir=$(pwd)
Stack=$1
Action=$2
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

Display_Welcome()
{
    clear
    echo ""
    echo "+------------------------------------------------------------------------+"
    echo "|                                                                        |"
    Echo_Cyan_Ex "|" "              LNMP/LAMP/LNAMP Shell Script for Linux Server             " "|"
    echo "|                                                                        |"
    echo "|                           Version: ${LNMP_Ver}                                 |"
    echo "|                           Host OS: ${DISTRO}                            "
    echo "|                                                                        |"
    echo "|                         Author by: Licess                              |"
    echo "|                       Modified by: shines77                            |"
    echo "|                     Last Modified: ${LNMP_LastModified}                          |"
    echo "|                                                                        |"
    echo "+------------------------------------------------------------------------+"
    echo "|       A tool to auto-compile & install LNMP/LAMP/LNAMP on Linux        |"
    echo "+------------------------------------------------------------------------+"
    echo "|     For more information please visit http://lnmp.cloudbuses.com       |"
    echo "+------------------------------------------------------------------------+"
    echo ""
}

Init_Install()
{
    Print_Sys_Info
    Press_Install
    
    if [ "${DISTRO}" = "RHEL" ]; then
        RHEL_Modify_Source
    fi
    Get_Linux_Dist_Version
    if [ "${DISTRO}" = "Ubuntu" ]; then
        Ubuntu_Modify_Source
    fi

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
    Create_PHP_Tools

    Install_Nginx
    
    Add_LNMP_Startup
    Check_LNMP_Install
}

LAMP_Stack()
{
    Init_Install

    Install_PHP
    Create_PHP_Tools

    Install_Apache    

    Add_LAMP_Startup
    Check_LAMP_Install
}

LNAMP_Stack()
{
    Init_Install

    Install_PHP
    Create_PHP_Tools

    Install_Nginx
    Install_Apache

    Add_LNAMP_Startup
    Check_LNAMP_Install
}

Do_Check_Install()
{
    local sCheckAction=$1
    if [[ -z ${sCheckAction} || "${sCheckAction}" = "" ]]; then
        Stack="lnmp"
        sCheckAction=${Stack}
    else
        Stack=${sCheckAction}
    fi
    case "${Stack}" in   
        lnmp)
            Add_LNMP_Startup
            Check_LNMP_Install
            ;;
        lamp)
            Add_LAMP_Startup
            Check_LAMP_Install
            ;;
        lnamp)
            Add_LNAMP_Startup
            Check_LNAMP_Install
            ;;
        *)
            Echo_Red "Usage: $0 check {lnmp|lamp|lnamp}"
            ;;
    esac
}

case "${Stack}" in   
    lnmp)
        Display_Welcome
        Display_Selection
        LNMP_Stack 2>&1 | tee -a /root/lnmp-shell-install.log
        ;;
    lamp)
        Display_Welcome
        Display_Selection
        LAMP_Stack 2>&1 | tee -a /root/lnmp-shell-install.log
        ;;
    lnamp)
        Display_Welcome
        Display_Selection
        LNAMP_Stack 2>&1 | tee -a /root/lnmp-shell-install.log
        ;;
    check)
        Display_Welcome
        Do_Check_Install ${Action}
        ;;
    test)
        Display_Welcome
        Display_Selection
        ;;
    test_random)
        Test_Random
        ;;
    test_color)
        Echo_Color_Test
        Echo_Color_Ex_Test
        ;;
    test_mkdir)
        Test_Mkdir_Recur
        ;;
    test_checkpath)
        Test_CheckPathName
        ;;
    timezone)
        Set_Timezone
        ;;
    *)
        Display_Welcome
        Echo_Red "Usage: $0 {lnmp|lamp|lnamp|test|check|test_random|test_color|test_mkdir|test_checkpath|timezone}"
        ;;
esac
