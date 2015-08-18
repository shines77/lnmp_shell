#!/bin/bash

#############################################################

# Download mirrors URL

Download_Mirror='http://mirror.cloudbuses.com'

Download_Mirror_1='http://mirror.cloudbuses.com'
Download_Mirror_2='http://soft.vpser.net'

#############################################################

### Install folders ###
### Configure file pathname ###

#############################################################

# VHOST default site folder
WWWROOT_Default_Site="/home/wwwroot/default"

# PhpMyAdmin pathname
PhpMyAdmin_PathName="phpmyadmin_JI1R7E5G3PY8VQ"
# The PHP Prober filename
PHP_Prober_FileName="tanzhen_HI2WU3E7Y67U2R.php"

#############################################################

# Nginx install folder
Nginx_Dir="/usr/local/nginx"
# Nginx logs folder
Nginx_Logs_Dir="/home/wwwlogs"

# Nginx confiure file
Nginx_Conf_File="/usr/local/nginx/conf/nginx.conf"

#############################################################

# Apache install folder
Apache_Dir="/usr/local/apache"
# Apache logs folder
Apache_Logs_Dir="/home/wwwlogs"

# Apache confiure file
Apache_Conf_File="/usr/local/apache/conf/httpd.conf"

#############################################################

# MySQL install folder
MySQL_Dir="/usr/local/mysql"
# MariaDB install folder
MariaDB_Dir="/usr/local/mariadb"

# MySQL/MariaDB confiure file
MySQL_Conf_File="/etc/my.cnf"
MariaDB_Conf_File="/etc/my.cnf"

#############################################################

# PHP install folder
PHP_Dir="/usr/local/php"
# PhpMyAdmin install folder
PhpMyAdmin_Dir=${WWWROOT_Default_Site}"/"${PhpMyAdmin_PathName}

# PHP confiure file
PHP_Conf_File="/usr/local/php/etc/php.ini"
# php-fpm confiure file
PHP_FPM_Conf_File="/usr/local/php/etc/php-fpm.ini"

#############################################################

# PHP extensions
ZendOptimizer_Dir="/usr/local/zend"

#############################################################

# PureFtpd confiure file
PureFtpd_Conf_File="/usr/local/pureftpd/pureftpd.conf"
# PureFtpd MySQL confiure file
PureFtpd_MySQL_Conf_File="/usr/local/pureftpd/pureftpd-mysql.conf"

#############################################################
