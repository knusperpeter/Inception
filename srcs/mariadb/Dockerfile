FROM debian:bookworm-slim

# Install MariaDB
RUN	apt update && apt install -y \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

# Copy initialization script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Expose port 3306
EXPOSE 3306

# create or copy configs

# Start MariaDB
CMD	["mysqld_safe"]

#HEALTHCHECK	--interval=5s \
#		--timeout=5s \
#		--retries=3 \
#		CMD mysqladmin ping -h localhost
