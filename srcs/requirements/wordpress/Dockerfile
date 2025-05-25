FROM debian:bullseye

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        php-fpm \
        php-mysql && \
    mkdir -p /run/php && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

CMD ["php-fpm7.4", "-F"]