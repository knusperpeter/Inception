FROM debian:bullseye

# Install MariaDB
RUN apt update && \
    apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy custom my.conf
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sh /docker-entrypoint-initdb.d/

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld && \
	chmod 777 /run/mysqld


# Volumes and ports
VOLUME /var/lib/mysql
EXPOSE 3306

# Start MariaDB
CMD ["sh", "-c", "exec mysqld --user=mysql --console --init-file=/docker-entrypoint-initdb.d/init.sh"]