# Using Debian
FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
	mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy custom my.conf
COPY /conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf
COPY /tools/init.sh .

RUN mkdir /run/mysqld && chmod +x init.sh

ENTRYPOINT ["./init.sh"]

# Volumes and ports
#VOLUME /var/lib/mysql
#EXPOSE 3306

# Start MariaDB
#CMD ["mysqld_safe"]