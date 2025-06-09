FROM debian:bullseye-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
		php \
        php-fpm \
        php-mysql \
		php-gd \
		php-curl \
		php-xml \
		php-zip \
		curl && \
    mkdir -p /run/php && \
    rm -rf /var/lib/apt/lists/*

	
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]

CMD ["php-fpm7.4", "-F"]