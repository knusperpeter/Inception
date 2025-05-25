#!/bin/bash
set -e

echo "Starting MariaDB initialization..."

# Initialize database if not exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start temporary server
    mysqld_safe --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock --log-error=/var/log/mysql/error.log &
    
    # Wait for server to start
    for i in {1..30}; do
        if [ -S "/run/mysqld/mysqld.sock" ]; then
            break
        fi
        sleep 1
    done
    
    # Secure installation
    mysql -uroot <<-EOSQL
        SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSWORD}');
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
        CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
        GRANT ALL ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    
    # Shutdown temporary server
    mysqladmin -uroot -p${MARIADB_ROOT_PASSWORD} shutdown
fi

echo "Database initialization complete"

# Start MariaDB in foreground and keep it running
exec mysqld --user=mysql --console --log-error=/var/log/mysql/error.log