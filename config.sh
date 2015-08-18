#!/bin/bash

#############################################################

# Download mirrors URLs

Download_Mirror='http://mirror.cloudbuses.com'

Download_Mirror_1='http://mirror.cloudbuses.com'
Download_Mirror_2='http://soft.vpser.net'

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
