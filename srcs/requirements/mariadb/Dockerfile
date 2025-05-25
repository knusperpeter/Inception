FROM debian:bullseye-slim

# Install MariaDB
RUN apt update && \
    apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy custom my.conf
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
#COPY ./tools/init.sh /usr/local/bin/

#RUN chmod +x  /usr/local/bin/init.sh && \
RUN	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld && \
	chmod 777 /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

# Volumes and ports
VOLUME /var/lib/mysql
EXPOSE 3306

# Start MariaDB
CMD ["mysqld_safe"]