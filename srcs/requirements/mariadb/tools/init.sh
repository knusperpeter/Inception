#!/bin/bash
set -e
echo "Starting MariaDB initialization..."
# Initialize database if not exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "Database ready"