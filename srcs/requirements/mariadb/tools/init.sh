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
        [ -S "/run/mysqld/mysqld.sock" ] && break
        sleep 1
    done

	if [ ! -S "/run/mysqld/mysqld.sock" ]; then
		echo "ERROR: MariaDB failed to start within 30 seconds"
		exit 1
	fi

    # Create users and database
    mysql -uroot <<-EOSQL
        -- Set root password
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        
        -- Create WordPress database
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        
        -- Create WordPress user with remote access
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        
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

exec "$@"