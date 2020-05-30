#!/bin/bash

printf 'Waiting for mysql'
until mysql
do
	echo "."
	sleep 1
done
printf '\n'

# on envoie les lignes jusqu'au EOF dans instructions.sql
cat << EOF > instructions.sql
USE mysql;
CREATE USER 'admin'@'%';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;
SET PASSWORD FOR 'admin'@'%' = PASSWORD('pass');
FLUSH PRIVILEGES;
EOF

#check: SELECT option_value FROM wp_options WHERE option_id BETWEEN 1 AND 2;

# on injecte la base de données dans mysql
mysql -u root -e 'CREATE DATABASE wordpress;'

# on envoie les instructions précédemment sauvegardées dans mysql
$MYSQL < instructions.sql

rm -f instructions.sql