#!/bin/sh

/usr/bin/mysqld_safe > /dev/null 2>&1 &

mysqladmin --silent --wait=30 ping

mysql -uroot -e "CREATE USER 'database'@'%' IDENTIFIED BY 'secret'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'database'@'%' WITH GRANT OPTION"
mysql -uroot -e "FLUSH PRIVILEGES"
mysql -uroot -e "CREATE SCHEMA database"

echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MariaDB Server using:"
echo ""
echo "    mysql -udatabase -psecret -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MariaDB user 'root' has no password but only allows local connections"
echo "========================================================================"

mysqladmin -uroot shutdown
