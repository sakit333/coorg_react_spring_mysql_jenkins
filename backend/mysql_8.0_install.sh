#!/bin/bash
# ============================================================
# MySQL Installation & Configuration Script
# Maintained by: DevOps Engineer @sak_shetty
# Purpose: Install MySQL if missing, configure root & remote access
# ============================================================

set -e

echo "🔍 Checking if MySQL is already installed..."
if command -v mysql >/dev/null 2>&1; then
    echo "✅ MySQL is already installed."
    mysql --version
else
    echo "🔹 Installing MySQL..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y mysql-server
    echo "✅ MySQL installation complete."
    mysql --version

    echo "🔹 Configuring MySQL root access..."
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';"
    sudo mysql -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '1234';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
    sudo mysql -e "FLUSH PRIVILEGES;"

    echo "🔹 Allowing remote connections..."
    sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    sudo systemctl restart mysql

    echo "✅ MySQL setup and configuration completed successfully."
fi
