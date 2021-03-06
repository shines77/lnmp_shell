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

shopt -s extglob

Check_DB
Check_OS_Is_64Bit
Get_Linux_Dist_Name

clear
echo ""
echo "+------------------------------------------------------------------------+"
echo "|                                                                        |"
Echo_Blue_Ex "|" "              LNMP/LAMP/LNAMP Shell Script for Linux Server             " "|"
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

Uninstall_LNMP()
{
    echo "Stoping LNMP ..."
    lnmp stop

    Remove_StartUp nginx
    Remove_StartUp ${DB_Name}
    Remove_StartUp php-fpm
    echo "Deleting LNMP files ..."
    rm -rf /usr/local/nginx
    rm -rf /usr/local/${DB_Name}/!(var|data)
    rm -rf /usr/local/php
    rm -rf /usr/local/zend

    rm -f /etc/my.cnf
    rm -f /etc/init.d/nginx
    rm -f /etc/init.d/${DB_Name}
    rm -f /etc/init.d/php-fpm
    rm -f /bin/lnmp
    echo "LNMP Uninstall completed."
}

Uninstall_LAMP()
{
    echo "Stoping LAMP ..."
    lnmp stop

    Remove_StartUp httpd
    Remove_StartUp ${DB_Name}
    echo "Deleting LAMP files ..."
    rm -rf /usr/local/apache
    rm -rf /usr/local/php
    rm -rf /usr/local/${DB_Name}/!(var|data)
    rm -rf /usr/local/zend

    rm -f /etc/my.cnf
    rm -f /etc/init.d/httpd
    rm -f /etc/init.d/${DB_Name}
    rm -f /bin/lnmp
    echo "LAMP Uninstall completed."
}

Uninstall_LNAMP()
{
    echo "Stoping LNAMP ..."
    lnmp stop

    Remove_StartUp nginx
    Remove_StartUp ${DB_Name}
    Remove_StartUp httpd
    echo "Deleting LNAMP files ..."
    rm -rf /usr/local/nginx
    rm -rf /usr/local/${DB_Name}/!(var|data)
    rm -rf /usr/local/php
    rm -rf /usr/local/apache
    rm -rf /usr/local/zend

    rm -f /etc/my.cnf
    rm -f /etc/init.d/nginx
    rm -f /etc/init.d/${DB_Name}
    rm -f /etc/init.d/httpd
    rm -f /bin/lnmp
    echo "LNAMP Uninstall completed."
}

Run_Uninstall()
{
    Check_Stack
    action=""

    echo ""
    echo "Current Stack: ${Get_Stack}"
    echo ""
    echo "1) Uninstall LNMP"
    echo "2) Uninstall LAMP"
    echo "3) Uninstall LNAMP"
    echo ""
    read -p "(Please input 1, 2 or 3):" action
    echo ""

    case "$action" in
        1|[lL][nN][mM][pP])
            echo "You will uninstall LNMP."
            Echo_Red "Please backup your configure files and mysql data !!!!!!"
            Echo_Red "The following directory or files will be remove!"
            cat << EOF
/usr/local/nginx
${MySQL_Dir}
/usr/local/php
/etc/init.d/nginx
/etc/init.d/${DB_Name}
/etc/init.d/php-fpm
/usr/local/zend
/etc/my.cnf
/bin/lnmp
EOF
            sleep 3
            Press_Start
            Uninstall_LNMP
            ;;
        2|[lL][aA][mM][pP])
            echo "You will uninstall LAMP."
            Echo_Red "Please backup your configure files and mysql data !!!!!!"
            Echo_Red "The following directory or files will be remove!"
            cat << EOF
/usr/local/apache
${MySQL_Dir}
/etc/init.d/httpd
/etc/init.d/${DB_Name}
/usr/local/php
/usr/local/zend
/etc/my.cnf
/bin/lnmp
EOF
            sleep 3
            Press_Start
            Uninstall_LAMP
            ;;
        3|[lL][nN][aA][mM][pP])
            echo "You will uninstall LNAMP."
            Echo_Red "Please backup your configure files and mysql data !!!!!!"
            Echo_Red "The following directory or files will be remove!"
            cat << EOF
/usr/local/nginx
${MySQL_Dir}
/usr/local/php
/usr/local/apache
/etc/init.d/nginx
/etc/init.d/${DB_Name}
/etc/init.d/httpd
/usr/local/zend
/etc/my.cnf
/bin/lnmp
EOF
            sleep 3
            Press_Start
            Uninstall_LNAMP
            ;;    
    esac
}

Run_Uninstall
