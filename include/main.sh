#!/bin/bash

# which Memory Allocator do you want to install?

MemeoryAllocator_Selection()
{
    SelectMalloc="1"
    echo ""
    Echo_Yellow "You have 3 options for your Memory Allocator install:"
    echo ""
    echo "1) Don't install Memory Allocator. (Default)"
    echo "2) Install Jemalloc"
    echo "3) Install TCMalloc"
    echo ""
    read -p "Enter your choice (1, 2 or 3): " SelectMalloc

    echo ""
    case "${SelectMalloc}" in
        1)
            Echo_Cyan "You will be don't install Memory Allocator. (Default)"
            ;;
        2)
            Echo_Cyan "You will install JeMalloc."
            ;;
        3)
            Echo_Cyan "You will Install TCMalloc."
            ;;
        *)
            Echo_Cyan "Unknown input, You will be don't install Memory Allocator. (Default)"
            SelectMalloc="1"
            ;;
    esac
    echo ""

    if [ "${SelectMalloc}" = "1" ]; then
        # Don't use memory allocator
        MySQL51MAOpt=""
        MySQL55MAOpt=""
        MariaDBMAOpt=""
        NginxMAOpt=""
    elif [ "${SelectMalloc}" = "2" ]; then
        # For jemalloc
        MySQL51MAOpt="--with-mysqld-ldflags=-ljemalloc"
        MySQL55MAOpt="-DCMAKE_EXE_LINKER_FLAGS='-ljemalloc' -DWITH_SAFEMALLOC=OFF"
        MariaDBMAOpt=""
        NginxMAOpt="--with-ld-opt='-ljemalloc'"
    elif [ "${SelectMalloc}" = "3" ]; then
        # For tcmalloc
        MySQL51MAOpt="--with-mysqld-ldflags=-ltcmalloc"
        MySQL55MAOpt="-DCMAKE_EXE_LINKER_FLAGS='-ltcmalloc' -DWITH_SAFEMALLOC=OFF"
        MariaDBMAOpt="-DCMAKE_EXE_LINKER_FLAGS='-ltcmalloc' -DWITH_SAFEMALLOC=OFF"
        NginxMAOpt="--with-google_perftools_module"
    else
        # Default choice, don't use memory allocator
        MySQL51MAOpt=""
        MySQL55MAOpt=""
        MariaDBMAOpt=""
        NginxMAOpt=""
    fi
}

# which MySQL Version do you want to install?

MySQL_Selection()
{
    DBSelect="2"
    echo ""
    Echo_Yellow "You have 5 options for your DataBase install:"
    echo ""
    echo "1) Install MySQL 5.1.73"
    echo "2) Install MySQL 5.5.42 (Default)"
    echo "3) Install MySQL 5.6.23"
    echo "4) Install MariaDB 5.5.42"
    echo "5) Install MariaDB 10.0.17"
    echo ""
    read -p "Enter your choice (1, 2, 3, 4 or 5): " DBSelect

    echo ""
    case "${DBSelect}" in
        1)
            Echo_Cyan "You will install MySQL 5.1.73."
            ;;
        2)
            Echo_Cyan "You will install MySQL 5.5.42."
            ;;
        3)
            Echo_Cyan "You will Install MySQL 5.6.23."
            ;;
        4)
            Echo_Cyan "You will install MariaDB 5.5.42."
            ;;
        5)
            Echo_Cyan "You will install MariaDB 10.0.17."
            ;;
        *)
            Echo_Cyan "Unknown input, You will install MySQL 5.5.42 (Default)."
            DBSelect="2"
            ;;
    esac
    echo ""

    if [[ "${DBSelect}" = "4" ] || [ "${DBSelect}" = "5" ]]; then
        # /usr/local/mariadb
        MySQL_Dir="${MariaDB_Dir}"
        # /usr/local/mariadb/bin/mysql
        MySQL_Bin="${MariaDB_Dir}/bin/mysql"
        # /usr/local/mariadb/bin/mysql_config
        MySQL_Bin_Config="${MariaDB_Dir}/bin/mysql_config"
        
    else
        # /usr/local/mysql
        MySQL_Dir="${MySQL_Dir}"
        # /usr/local/mysql/bin/mysql
        MySQL_Bin="${MySQL_Dir}/bin/mysql"
        # /usr/local/mysql/bin/mysql_config
        MySQL_Bin_Config="${MySQL_Dir}/bin/mysql_config"
        
    fi
}

# do you want to enable or disable the InnoDB Storage Engine?

InnoDB_StorageEngine_Selection()
{
    InstallInnodb="y"
    echo ""
    Echo_Yellow "Do you want to enable or disable the InnoDB Storage Engine?"
    echo ""
    read -p "Default enable, Enter your choice [y/N]: " InstallInnodb

    echo ""
    case "${InstallInnodb}" in
        [yY][eE][sS]|[yY])
            Echo_Cyan "You will enable the InnoDB Storage Engine."
            ;;
        [nN][oO]|[nN])
            Echo_Cyan "You will disable the InnoDB Storage Engine!"
            ;;
        *)
            Echo_Cyan "Unknown input, The InnoDB Storage Engine will enable."
            InstallInnodb="y"
            ;;
    esac
    echo ""
}

# Input MySQL root password

Input_MySQL_RootPWD()
{
    read -p "Please enter the password: " MysqlRootPWD
    if [ "${MysqlRootPWD}" = "" ]; then
        echo ""
        Echo_Magenta "You have no input, Mysql root password will be use the default value."
        echo ""
        read -p "Are you sure use the default password: '${MysqlRootDefaultPWD}' ? [Y/n]: " MysqlRootUseDefaultPWD

        echo ""
        case "${MysqlRootUseDefaultPWD}" in
            [yY][eE][sS]|[yY])
                Echo_Cyan "You agree to use the default Mysql root password '${MysqlRootDefaultPWD}'."
                MysqlRootUseDefaultPWD='y'
                MysqlRootPWD="${MysqlRootDefaultPWD}"
                MysqlRootConfirmPWD="${MysqlRootDefaultPWD}"
                ;;
            [nN][oO]|[nN])
                Echo_Red "Info: You do not agree to use the default Mysql root password, please try again."
                MysqlRootUseDefaultPWD='n'
                echo ""
                Input_MySQL_RootPWD
                ;;
            *)
                # Echo_Cyan "Unknown input, You agree to use the default Mysql root password '${MysqlRootDefaultPWD}'."
                # MysqlRootUseDefaultPWD="y"
                # MysqlRootPWD="${MysqlRootDefaultPWD}"
                # MysqlRootConfirmPWD="${MysqlRootDefaultPWD}"
                Echo_Magenta "Unknown input, You do not agree to use the default Mysql root password, please try again."
                MysqlRootUseDefaultPWD='n'
                echo ""
                Input_MySQL_RootPWD
                ;;
        esac
    else
        read -p "     Confirm the password: " MysqlRootConfirmPWD
        if [ "${MysqlRootConfirmPWD}" = "" ]; then
            MysqlRootConfirmPWD="${MysqlRootDefaultPWD}"
        fi
        if [ "${MysqlRootPWD}" != "${MysqlRootConfirmPWD}" ]; then
            echo ""
            Echo_Red "Error: two time passwords are not equal, please try again."
            echo ""
            Input_MySQL_RootPWD
        fi
    fi
}

# Set MySQL root password

MySQL_RootPWD_Setting()
{
    MysqlRootDefaultPWD="mysql2015"
    MysqlRootPWD=""
    MysqlRootConfirmPWD=""
    Echo_Yellow "Please setup the root password of MySQL. (Default password is: ${MysqlRootDefaultPWD})"
    echo ""

    Input_MySQL_RootPWD
    echo ""
    Echo_Cyan "Your MySQL root password is: ${MysqlRootPWD}"
    echo ""
}

# Which PHP Version do you want to install?

PHP_Selection()
{
    PHPSelect="3"
    echo ""
    Echo_Yellow "You have 5 options for your PHP install:"
    echo ""
    echo "1) Install PHP 5.2.17"
    echo "2) Install PHP 5.3.29"
    echo "3) Install PHP 5.4.41"
    echo "4) Install PHP 5.5.25 (Default)"
    echo "5) Install PHP 5.6.9"
    echo ""
    read -p "Enter your choice (1, 2, 3, 4 or 5): " PHPSelect

    echo ""
    case "${PHPSelect}" in
        1)
            Echo_Cyan "You will install PHP 5.2.17."
            ;;
        2)
            Echo_Cyan "You will install PHP 5.3.29."
            ;;
        3)
            Echo_Cyan "You will Install PHP 5.4.41."
            ;;
        4)
            Echo_Cyan "You will install PHP 5.5.25."
            ;;
        5)
            Echo_Cyan "You will install PHP 5.6.9."
            ;;
        *)
            Echo_Cyan "Unknown input, You will install PHP 5.5.25 (Default)."
            PHPSelect="4"
            ;;
    esac
    echo ""
}

# Which Nginx Version do you want to install?

Nginx_Selection()
{
    NginxSelect="3"
    echo ""
    Echo_Yellow "You have 3 options for your Nginx install:"
    echo ""
    echo "1) Install Nginx 1.4.7"
    echo "2) Install Nginx 1.6.3"
    echo "3) Install Nginx 1.8.0 (Default)"
    echo ""
    read -p "Enter your choice (1, 2 or 3): " NginxSelect

    echo ""
    case "${NginxSelect}" in
        1)
            Echo_Cyan "You will install Nginx 1.4.7."
            ;;
        2)
            Echo_Cyan "You will install Nginx 1.6.3."
            ;;
        3)
            Echo_Cyan "You will Install Nginx 1.8.0."
            ;;
        *)
            Echo_Cyan "Unknown input, You will install Nginx 1.8.0 (Default)."
            NginxSelect="3"
            ;;
    esac
    echo ""
}

# Which Apache Version do you want to install?

Apache_Selection()
{
    ApacheSelect="1"
    echo ""
    Echo_Yellow "You have 2 options for your Apache install:"
    echo ""
    echo "1) Install Apache 2.2.29 (Default)"
    echo "2) Install Apache 2.4.10"
    echo ""
    read -p "Enter your choice (1 or 2): " ApacheSelect

    echo ""
    if [ "${ApacheSelect}" = "1" ]; then
        Echo_Cyan "You will install Apache 2.2.29."
    elif [ "${ApacheSelect}" = "2" ]; then
        Echo_Cyan "You will install Apache 2.4.10."
    else
        Echo_Cyan "Unknown input, You will install Apache 2.2.29 (Default)."
        ApacheSelect="1"
    fi
    echo ""
}

# Set Server Administrator Email Address

Admin_Email_Setting()
{
    ServerAdmin=""
    echo ""
    read -p "Please enter Administrator Email Address: " ServerAdmin
    echo ""
    if [ "${ServerAdmin}" == "" ]; then
        Echo_Cyan "Server Administrator Email will set to webmaster@example.com !"
        ServerAdmin="webmaster@example.com"
    else
        echo "========================================================"
        Echo_Cyan "Server Administrator Email is: ${ServerAdmin}"
        echo "========================================================"
    fi
    echo ""
}

# Setting your server's timezone.

Set_Timezone()
{
    echo "========================================"
    Echo_Yellow " Setting server's timezone ..."
    echo "========================================"

    TimeZoneSelect="0"
    echo ""
    Echo_Yellow "You have 10 options for your timezone setting:"
    echo ""
    echo "0) Don't change  - Keep use now timezone setting (Default)."
    echo "1) Asia          - Shanghai, Chongqing"
    echo "2) Asia          - HongKong"
    echo "3) Asia          - Singapore"
    echo "4) Asia          - Japan"
    echo "5) America       - New York (East US)"
    echo "6) America       - Los Angeles (West US)"
    echo "7) Europe        - London (United Kingdom)"
    echo "8) Europe        - Paris (France)"
    echo "9) Others        - Use system 'tzselect' command."
    echo ""
    read -p "Enter your choice (0 - 9): " TimeZoneSelect

    echo ""
    case "${TimeZoneSelect}" in
        0)
            Echo_Cyan "You choice don't change - Keep use now timezone setting."
            ;;
        1)
            Echo_Cyan "You choice Asia - Shanghai, Chongqing timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
            \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
            ;;
        2)
            Echo_Cyan "You choice Asia - HongKong timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
            \cp -f /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
            ;;
        3)
            Echo_Cyan "You choice Asia - Singapore timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
            \cp -f /usr/share/zoneinfo/Asia/Singapore /etc/localtime
            ;;
        4)
            Echo_Cyan "You choice Asia - Japan timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Japan /etc/localtime
            \cp -f /usr/share/zoneinfo/Japan /etc/localtime
            ;;
        5)
            Echo_Cyan "You choice Amemrican - New York (East US) timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime
            # ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
            \cp -f /usr/share/zoneinfo/America/New_York /etc/localtime
            ;;
        6)
            Echo_Cyan "You choice Amemrican - Los Angeles (West US) timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime
            # ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
            \cp -f /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
            ;;
        7)
            Echo_Cyan "You choice Europe - London (United Kingdom) timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
            \cp -f /usr/share/zoneinfo/Europe/London /etc/localtime
            ;;
        8)
            Echo_Cyan "You choice Europe - Paris (France) timezone."
            rm -rf /etc/localtime
            # ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
            \cp -f /usr/share/zoneinfo/Europe/Paris /etc/localtime
            ;;
        9)
            echo ""
            Echo_Cyan "You choice Manual Select - Use system 'tzselect' command."
            echo ""
            tzselect
            ;;
        *)
            Echo_Cyan "Unknown input, you choice don't change - Keep use now timezone setting (Default)."
            TimeZoneSelect="0"
            ;;
    esac
    echo ""
    echo "=========================================================="
    echo ""
}

# Get the selections about install

Display_Selection()
{
    echo "=========================================================="
    MemeoryAllocator_Selection
    echo "=========================================================="
    MySQL_Selection
    echo "=========================================================="
    InnoDB_StorageEngine_Selection
    MySQL_RootPWD_Setting
    echo "=========================================================="
    PHP_Selection
    echo "=========================================================="
    Nginx_Selection

    if [[ "${Stack}" = "lamp" || "${Stack}" = "lnamp" || "${Stack}" = "test" ]]; then
        echo "=========================================================="
        Apache_Selection
        echo "=========================================================="
        Admin_Email_Setting
    fi

    Set_Timezone
}

Press_Install()
{
    . include/version.sh

    # Display install version info, this function in "include/version.sh"
    Display_Install_Version_Info

    echo ""
    echo "Press any key to install or Press Ctrl + C to cancel ..."
    OLDCONFIG=`stty -g`
    stty -icanon -echo min 1 time 0
    dd count=1 2>/dev/null
    stty ${OLDCONFIG}
    echo ""
}

Press_Start()
{
    echo ""
    echo "Press any key to start or Press Ctrl + C to cancel ..."
    OLDCONFIG=`stty -g`
    stty -icanon -echo min 1 time 0
    dd count=1 2>/dev/null
    stty ${OLDCONFIG}
    echo ""
}

Print_Sys_Info()
{
    cat /etc/issue
    cat /etc/*-release
    echo ""
    uname -a
    echo ""
    MemTotal=`free -m | grep Mem | awk '{print  $2}'`
    echo "Memory total is: ${MemTotal} MB "
    echo ""
    df -h
}

# Check arch is 32-bit or 64-bit?
Check_OS_Arch()
{
    case `uname -m` in
        i[3456789]86|x86|i86pc)
            os_arch='x86'
            ;;
        x86_64|amd64|AMD64)
            os_arch='amd64'
            ;;
        *)
            echo "Unknown architecture `uname -m`."
            os_arch="unknown"
            exit 1
            ;;
    esac
}

Check_OS_Is_64Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]]; then
        Is_64bit='y'
    else
        Is_64bit='n'
    fi
}

Check_Is_ARM()
{
    if uname -m | grep -Eqi "arm"; then
        Is_ARM='y'
    fi
}

Install_LSB()
{
    if [ "$PM" = "yum" ]; then
        yum -y install redhat-lsb
    elif [ "$PM" = "apt" ]; then
        apt-get update
        apt-get install -y lsb-release
    fi
}

Get_Linux_Dist_Version()
{
    Install_LSB
    eval ${DISTRO}_Version=`lsb_release -rs`
    eval echo "${DISTRO} \${${DISTRO}_Version}"
}

Get_Linux_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    Check_OS_Is_64Bit
}

Get_RHEL_Version()
{
    Get_Linux_Dist_Name
    if [ "${DISTRO}" = "RHEL" ]; then
        if grep -Eqi "release 5." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 5"
            RHEL_Ver='5'
        elif grep -Eqi "release 6." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 6"
            RHEL_Ver='6'
        elif grep -Eqi "release 7." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 7"
            RHEL_Ver='7'
        fi
    fi
}

Tar_Cd()
{
    local FileName=$1
    local DirName=$2
    cd ${cur_dir}/src
    [[ -d "${DirName}" ]] && rm -rf ${DirName}
    echo "Uncompress ${FileName} ..."
    tar zxf ${FileName}
    echo "cd ${DirName} ..."
    cd ${DirName}
}

Unzip_Package()
{
    local sPackagePath=$1
    local sFileName=$2
    local sDirName=$3
    local sUnzipPath=${Unzip_Dir}${PackagePath}
    cd ${sUnzipPath}
    # Remove the previous uncompress files and folders, if it have exists.
    [[ -d "${sDirName}" ]] && rm -rf ${sDirName}
    # Uncompress the package to a folder.
    echo "Uncompress ${sFileName} to dir [${sUnzipPath}] ..."
    tar -zvf ${Packages_Dir}${sPackagePath}${sFileName} ${sUnzipPath}
    # Change the current path to the uncompressed folder.
    echo "cd ${sUnzipPath}${sDirName} ..."
    cd ${sUnzipPath}${sDirName}
}

StartUp()
{
    init_name=$1
    echo "Add ${init_name} service at system startup ..."
    if [ "$PM" = "yum" ]; then
        chkconfig --add ${init_name}
        chkconfig ${init_name} on
    elif [ "$PM" = "apt" ]; then
        update-rc.d -f ${init_name} defaults
    fi
}

Remove_StartUp()
{
    init_name=$1
    echo "Removing ${init_name} service at system startup ..."
    if [ "$PM" = "yum" ]; then
        chkconfig ${init_name} off
        chkconfig --del ${init_name}
    elif [ "$PM" = "apt" ]; then
        update-rc.d -f ${init_name} remove
    fi
}

Get_PHP_Ext_Dir()
{
    Cur_PHP_Version=`/usr/local/php/bin/php -r 'echo PHP_VERSION;'`
    if echo "${Cur_PHP_Version}" | grep -Eqi '^5.2.'; then
       zend_ext_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"
    elif echo "${Cur_PHP_Version}" | grep -Eqi '^5.3.'; then
       zend_ext_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20090626/"
    elif echo "${Cur_PHP_Version}" | grep -Eqi '^5.4.'; then
       zend_ext_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/"
    elif echo "${Cur_PHP_Version}" | grep -Eqi '^5.5.'; then
       zend_ext_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20121212/"
    elif echo "${Cur_PHP_Version}" | grep -Eqi '^5.6.'; then
       zend_ext_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/"
    fi
}

Check_Stack()
{
    if [[ -s /usr/local/nginx/sbin/nginx && -s /usr/local/apache/bin/httpd && -s /usr/local/apache/conf/httpd.conf && -s /etc/init.d/httpd && ! -s /usr/local/php/sbin/php-fpm ]]; then
        Get_Stack="lnamp"
    elif [[ -s /usr/local/php/bin/php-cgi || -s /usr/local/php/sbin/php-fpm ]] && [[ -s /usr/local/php/etc/php-fpm.conf && -s /etc/init.d/php-fpm && -s /usr/local/nginx/sbin/nginx ]]; then
        Get_Stack="lnmp"
    elif [[ -s /usr/local/apache/bin/httpd && -s /usr/local/apache/conf/httpd.conf && -s /etc/init.d/httpd && ! -s /usr/local/php/sbin/php-fpm ]]; then
        Get_Stack="lamp"
    else
        Get_Stack="unknow"
    fi
}

Check_DB()
{
    if [[ -s ${MariaDB_Dir}/bin/mysql && -s ${MariaDB_Dir}/bin/mysqld_safe && -s /etc/my.cnf ]]; then
        # /usr/local/mariadb
        MySQL_Dir="${MariaDB_Dir}"
        # /usr/local/mariadb/bin/mysql
        MySQL_Bin="${MariaDB_Dir}/bin/mysql"
        # /usr/local/mariadb/bin/mysql_config
        MySQL_Bin_Config="${MariaDB_Dir}/bin/mysql_config"
        
        Is_MySQL="n"
        DB_Name="mariadb"
    else
        # /usr/local/mysql
        MySQL_Dir="${MySQL_Dir}"
        # /usr/local/mysql/bin/mysql
        MySQL_Bin="${MySQL_Dir}/bin/mysql"
        # /usr/local/mysql/bin/mysql_config
        MySQL_Bin_Config="${MySQL_Dir}/bin/mysql_config"
        
        Is_MySQL="y"
        DB_Name="mysql"
    fi
}

Verify_DB_Password()
{
    Check_DB
    read -p "verify your current database root password: " DB_Root_Password
    ${MySQL_Bin} -uroot -p${DB_Root_Password} -e "quit"
    if [ $? -eq 0 ]; then
        echo "MySQL root password correct."
    else
        echo "MySQL root password incorrect! Please check!"
        Verify_DB_Password
    fi
    if [ "${DB_Root_Password}" = "" ]; then
        Verify_DB_Password
    fi
}
