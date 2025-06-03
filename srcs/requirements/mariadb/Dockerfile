FROM debian:bullseye-slim

# Install MariaDB and required tools
RUN apt update && \
	apt upgrade -y && \
    apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*
	# && \
#    mkdir -p /var/log/mysql && \
#    chown -R mysql:mysql /var/log/mysql

RUN rm -rf /var/lib/mysql/*

# Copy configuration and init script
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sh /usr/local/bin/

# Set permissions
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chmod 750 /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod +x /usr/local/bin/init.sh

VOLUME /var/lib/mysql
EXPOSE 3306

# Combined initialization and server start
CMD ["/usr/local/bin/init.sh"]