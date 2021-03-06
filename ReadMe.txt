					LNMP Shell 一键安装包 - Readme

LNMP Shell 一键安装包是什么?
——————————————————————————————

LNMP Shell 一键安装包是一个用 Linux Shell 编写的可以为 CentOS/RadHat/Fedora、Debian/Ubuntu/Raspbian VPS(VDS) 或独立主机安装 LNMP(Nginx/MySQL/PHP)、LAMP(Apache/MySQL/PHP)、LNAMP(Nginx/Apache/MySQL/PHP) 生产环境的 Shell 程序。同时提供一些实用的辅助工具如：虚拟主机管理、FTP用户管理、Nginx、MySQL/MariaDB、PHP的升级、常用缓存组件的安装、重置 MySQL root 密码、502自动重启、日志切割、SSH 防护 DenyHosts/Fail2Ban、备份等许多实用脚本。

--------

LNMP Shell修改版作者:  shines77 <shines77@cloudbuses.com>
LNMP Shell修改版官网： http://lnmp.cloudbuses.com

--------

LNMP原版作者:  licess <admin@lnmp.org>
LNMP原版官网： http://lnmp.org

--------------------------------------------------------------------------------

安装
—————
详细安装教程参考：http://lnmp.cloudbuses.com/install.html

安装前建议使用 screen，执行：screen -S lnamp 后,

执行：wget -c http://mirror.cloudbuses.com/lnmp/lnmp-shell-1.0-full.tar.gz && tar zxf lnmp-shell-1.0-full.tar.gz && cd lnmp-shell-1.0-full && ./install.sh {lnmp|lamp|lnamp}

如断线可使用 screen -r lnamp 恢复。

常用功能
—————————

以下操作需在 lnmp-shell-1.0-full 目录下执行：

FTP服务器：执行：./pureftpd.sh 安装，http://yourIP/ftp/ 进行管理，也可使用 lnmp ftp {add|list|del} 进行管理。

升级脚本：

执行：./upgrade.sh 按提示进行选择

也可以直接使用参数：./upgrade.sh {nginx|mysql|mariadb|php|phpa|m2m}

参数: nginx   可升级至任意 Nginx 版本。
参数: mysql   可升级至任意 MySQL 版本，MySQL 升级风险较大，虽然会自动备份数据，依然建议自行再备份一下。
参数: mariadb 可升级已安装的 Mariadb，虽然会自动备份数据，依然建议自行再备份一下。
参数: m2m     可从 MySQL 升级至 Mariadb，虽然会自动备份数据，依然建议自行再备份一下。
参数: php     仅适用于LNMP，可升级至大部分 PHP 版本。
参数: phpa    可升级 LAMP/LNAMP 的 PHP 至大部分版本。


缓存加速：

执行: ./addons.sh {install|uninstall} {eaccelerator|xcache|memcached|opcache|redis|imagemagick|ioncube}

参数: xcache       安装时需选择版本和设置密码， http://yourIP/xcache/ 进行管理，用户名 admin，密码为安装 xcache 时设置的。
参数: redis
参数: memcached    可选择 php-memcache 或 php-memcached 扩展。
参数: opcache      http://yourIP/ocp.php 进行管理。
参数: eaccelerator 安装 eaccelerator。

请勿安装多个缓存类扩展模块，多个可能导致网站出现问题。

图像处理：

参数: imageMagick imageMagick 路径：/usr/local/imagemagick/bin/。

解密：
可选1，执行：./ionCube.sh 安装。

其他：
可选1，执行：./php5.2.17.sh 可安装一个不与 LNMP 冲突的 PHP 5.2.17 单独存在，目录在 /usr/local/php52/，使用时需要将 nginx 虚拟主机配置文件里的 php-cgi.sock 修改为 php-cgi52.sock 即可调用 PHP 5.2.17。
可选2，执行：./reset_mysql_root_password.sh 可重置 MySQL/MariaDB 的 root 密码。
可选3，执行：./check502.sh  可检测 php-fpm 是否挂掉,502报错时重启，配合 crontab 使用。
可选4，执行：./cut_nginx_logs.sh 日志切割脚本。
可选5，执行：./remove_disable_function.sh 运行此脚本可删掉禁用函数。
可选6，如需卸载 LNMP、LAMP 或 LNAMP，可执行：./uninstall.sh 按提示选择即可卸载。

状态管理
—————————

LNMP/LMAP/LNAMP状态管理：lnmp {start|stop|reload|restart|kill|status}
Nginx状态管理：          lnmp nginx 或 /etc/init.d/nginx {start|stop|reload|restart}
MySQL状态管理：          lnmp mysql 或 /etc/init.d/mysql {start|stop|restart|reload|force-reload|status}
MariaDB状态管理：        lnmp mariadb 或 /etc/init.d/mariadb {start|stop|restart|reload|force-reload|status}
PHP-FPM状态管理：        lnmp php-fpm 或 /etc/init.d/php-fpm {start|stop|quit|restart|reload|logrotate}
PureFTPd状态管理：       lnmp pureftpd 或 /etc/init.d/pureftpd {start|stop|restart|kill|status}
Apache状态管理：         lnmp httpd 或 /etc/init.d/httpd {start|stop|restart|graceful|graceful-stop|configtest|status}

虚拟主机管理
——————————————
添加：lnmp vhost add
删除：lnmp vhost del
列出：lnmp vhost list

相关图形界面
——————————————
PHPMyAdmin：           http://yourIP/phpmyadmin/
phpinfo：              http://yourIP/phpinfo.php
PHP探针：              http://yourIP/p.php
PureFtp用户管理：      http://yourIP/ftp/
Xcache管理界面：       http://yourIP/xcache/
Zend Opcache管理界面： http://yourIP/ocp.php

LNMP相关目录文件
——————————————————

目录位置：

Nginx：/usr/local/nginx/
MySQL：/usr/local/mysql/
MariaDB：/usr/local/mariadb/
PHP：/usr/local/php/
PHPMyAdmin：/home/wwwroot/default/phpmyadmin/
默认虚拟主机网站目录：/home/wwwroot/default/
Nginx日志目录：/home/wwwlogs/

配置文件：

Nginx主配置文件：/usr/local/nginx/conf/nginx.conf
MySQL/MariaDB配置文件：/etc/my.cnf
PHP配置文件：/usr/local/php/etc/php.ini
PureFtpd配置文件：/usr/local/pureftpd/pure-ftpd.conf
PureFtpd MySQL配置文件：/usr/local/pureftpd/pureftpd-mysql.conf
Apache配置文件：/usr/local/apache/conf/httpd.conf


技术支持
——————————

技术支持论坛：http://bbs.vpser.net/forum-25-1.html
