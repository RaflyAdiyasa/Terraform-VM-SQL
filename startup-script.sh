#!/bin/bash

# Update paket dan install MySQL Server
apt update
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server ufw

# Pastikan MySQL service jalan
systemctl enable mysql
systemctl start mysql

# Ubah konfigurasi MySQL supaya bisa diakses dari luar (bind ke semua IP)
sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf


# Restart MySQL supaya perubahan berlaku
systemctl restart mysql

echo "MySQL server sudah diubah bind-address ke mana mana "

# Buat database, user baru, dan grant akses dari semua IP
DB_USER="huan"
DB_PASS="pass123"
DB_NAME="catatanku"

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo " Database ${DB_NAME} dan user ${DB_USER} sudah dibuat dengan password ${DB_PASS}."

# # Install Google Cloud SDK (kalau VM belum ada gcloud)
# if ! command -v gcloud &> /dev/null
# then
#     echo "Installing Google Cloud SDK..."
#     apt install -y curl apt-transport-https ca-certificates gnupg
#     echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
#         | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
#         | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
#     apt update && apt install -y google-cloud-sdk
# fi

ufw allow 22/tcp    
ufw allow 3306/tcp
ufw allow 80/tcp
ufw allow OpenSSH
ufw -f enable

echo "selesai, MySQL server sudah siap diakses dari luar dengan user ${DB_USER} dan password ${DB_PASS}."
# # # Buka firewall port 3306
# gcloud compute firewall-rules create allow-mysql \
#     --allow tcp:3306 \
#     --source-ranges=0.0.0.0/0 \
#     --target-tags=mysql-server \
#     --description="Allow MySQL access from anywhere"

# # Tambahkan tag "mysql-server" ke instance ini
# INSTANCE_NAME=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/name)
# ZONE=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | awk -F/ '{print $4}')

# gcloud compute instances add-tags "$INSTANCE_NAME" --tags=mysql-server --zone="$ZONE"
