#!/bin/sh

mkdir www
tar -xvf wordpress.tar.gz
rm -rf wordpress.tar.gz
mv wordpress/* /www
cd /www

#mv wp-config-sample.php wp-config.php
#sed -i 's/database_name_here/wordpress/g' wp-config.php
#sed -i 's/username_here/admin/g' wp-config.php
#sed -i 's/password_here/pass/g' wp-config.php
#sed -i 's/localhost/mysql-service/g' wp-config.php

php -S 0.0.0.0:5050 -t /www
