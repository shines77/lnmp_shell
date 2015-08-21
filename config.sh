#!/bin/bash

#############################################################

# Download mirrors URLs

#Download_Mirror='http://mirrors.cloudbuses.com'
Download_Mirror='http://soft.vpser.net'

Download_Mirror_1='http://mirrors.cloudbuses.com'
Download_Mirror_2='http://soft.vpser.net'

#############################################################

# Install log file setting
Install_Log_Dir="/home/lnmp_install/logs/"
Install_Log_File="lnmp-install.log"

# Uninstall log file setting
Uninstall_Log_Dir="${Install_Log_Dir}"
Uninstall_Log_File="lnmp-uninstall.log"

# The path of install package files
Packages_Dir="/home/lnmp_install/packages"
# The temp path of unzip the package files
Unzip_Dir="/home/lnmp_install/unzip"

# The path of download mirrors install package files
Mirrors_Packages_Dir="/home/wwwroot/mirrors/lnmp_shell"

####################################################
#
# File tree example:
#
# /libs/jemalloc/jemalloc-3.6.0.tar.gz
# /libs/tcmalloc/gperftools-2.1.tar.gz
# /libs/tcmalloc/libunwind/libunwind-1.5.2.tar.gz
#
# /php/php-5.5.16-x86_64.tar.gz
# /php/libs/libmcrypt/libmcrypt-3.2.2-x86_64.tar.gz
# /php/extensions/zend/ZendOptimizer-3.3.9-linux-glibc23-x86_64.tar.gz
# /php/extensions/ioncube/ioncube_loaders_lin_x86-64.tar.gz
# /php/phpmyadmin/phpmyadmin-5.5.31-x86_64.tar.gz
#
# /database/mysql/mysql-5.5.22-x86_64.tar.gz
# /database/mariadb/mariadb-5.5.31-x86_64.tar.gz
# /database/pdo/pdo-1.0.2-x86_64.tar.gz
#
# /server/nginx/nginx-1.8.0-x86_64.tar.gz
# /server/apache/apache-2.4.2-x86_64.tar.gz
# /server/apache/apr-2.1.9-x86_64.tar.gz
#
# /ftp/pureftpd/pureftpd-3.4.1-x86_64.tar.gz
#
####################################################

#############################################################

### Install paths and configure files ###

## Note: All the path must be not end of "/". ##

#############################################################

# WwWRoot: VHOST default site folder
WWWRoot_Default_Site="/home/wwwroot/default"

# PhpMyAdmin pathname
PhpMyAdmin_PathName="phpmyadmin_JI1R7E5G3PY8VQ"
# The PHP Prober filename
PHP_Prober_FileName="tanzhen_HI2WU3E7Y67U2R.php"

#############################################################

# Nginx install path
Nginx_Dir="/usr/local/nginx"
# Nginx logs path
Nginx_Logs_Dir="/home/wwwlogs"

# Nginx confiure file
Nginx_Conf_File="/usr/local/nginx/conf/nginx.conf"

#############################################################

# Apache install path
Apache_Dir="/usr/local/apache"
# Apache logs path
Apache_Logs_Dir="/home/wwwlogs"

# Apache confiure file
Apache_Conf_File="/usr/local/apache/conf/httpd.conf"

#############################################################

# MySQL install path
MySQL_Dir="/usr/local/mysql"
# MariaDB install path
MariaDB_Dir="/usr/local/mariadb"

# MySQL/MariaDB confiure file
MySQL_Conf_File="/etc/my.cnf"
MariaDB_Conf_File="/etc/my.cnf"

#############################################################

# PHP install path
PHP_Dir="/usr/local/php"
# PhpMyAdmin install path
PhpMyAdmin_Dir=${WWWRoot_Default_Site}"/"${PhpMyAdmin_PathName}

# PHP confiure file
PHP_Conf_File="/usr/local/php/etc/php.ini"
# PHP-FPM confiure file
PHP_FPM_Conf_File="/usr/local/php/etc/php-fpm.conf"

#############################################################

# PHP extensions
ZendOptimizer_Dir="/usr/local/zend"

#############################################################

# PureFtpd confiure file
PureFtpd_Conf_File="/usr/local/pureftpd/pureftpd.conf"
# PureFtpd MySQL confiure file
PureFtpd_MySQL_Conf_File="/usr/local/pureftpd/pureftpd-mysql.conf"

#############################################################
