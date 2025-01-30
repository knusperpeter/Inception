FROM debian:latest

RUN	apt update \
	&& apt install -y \
	mariadb-server \
	coreutils \
	systemctl \
	&& rm -rf /var/lib/apt/lists/*

CMD	["systemctl", "enable", "mariadb", "&&", \
	"systemctl", "start", "mariadb", "&&", \
	"systemctl", "status", "mariadb"]

#HEALTHCHECK	--interval=5s \
#		--timeout=5s \
#		--retries=3 \
#		CMD mysqladmin ping -h localhost
