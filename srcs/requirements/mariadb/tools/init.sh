#!/bin/bash
set -e

# Only initialize if database doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start temporary server
    mysqld_safe --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    
    # Wait for server to start
    for i in {1..30}; do
        if [ -S "/run/mysqld/mysqld.sock" ]; then
            break
        fi
        sleep 1
    done
    
    # Create users and database
    mysql -uroot <<-EOSQL
        -- Set root password
        UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
        
        -- Create WordPress database
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        
        -- Create regular user
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        
        -- Create admin user (without 'admin' in name)
        CREATE USER IF NOT EXISTS 'db_manager'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO 'db_manager'@'%' WITH GRANT OPTION;
        
        -- Clean up
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
        FLUSH PRIVILEGES;
EOSQL
    
    # Shutdown temporary server
    mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
fi