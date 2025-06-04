#!/bin/bash


apt update
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server ufw


systemctl enable mysql
systemctl start mysql


sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf



systemctl restart mysql

echo "MySQL server sudah diubah bind-address ke mana mana "


DB_USER="assigngo_user"
DB_PASS="pass123"
DB_NAME="assigngo"

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo " Database ${DB_NAME} dan user ${DB_USER} sudah dibuat dengan password ${DB_PASS}."



ufw allow 22/tcp    
ufw allow 3306/tcp
ufw allow 80/tcp
ufw allow OpenSSH
ufw -f enable

echo "selesai, MySQL server sudah siap diakses dari luar dengan user ${DB_USER} dan password ${DB_PASS}."







