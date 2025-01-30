FROM debian:latest

RUN	apt update \
	&& apt install -y \
	wordpress \
	php \
	php-fpm \
	php-mysql \
	&& rm -rf /var/lib/apt/lists/*

CMD	["sh", "-c", "\
	systemctl enable php8.3-fpm && \
	systemctl start php8.3-fpm && \
	systemctl status php8.3-fpm \
	"]
