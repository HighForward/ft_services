#!/bin/bash

until mysql
do
	sleep 1
done

cat << EOF > database.sql
USE mysql;
CREATE USER 'admin'@'%';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;
SET PASSWORD FOR 'admin'@'%' = PASSWORD('pass');
FLUSH PRIVILEGES;
EOF

#check: SELECT option_value FROM wp_options WHERE option_id BETWEEN 1 AND 2;

mysql -u root -e 'CREATE DATABASE wordpress;'
mysql -u root wordpress < /wordpress.sql
mysql -u root < database.sql

rm -f database.sql