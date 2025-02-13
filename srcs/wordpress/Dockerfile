FROM debian:bookworm-slim

# Install dependencies
RUN	apt update && apt install -y \
	curl \
	wordpress \
	tar \
	wget \
	php8.2-fpm \
	php8.2-mysql \
	&& rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN	curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz \
	&& tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
	&& rm /tmp/wordpress.tar.gz

# Copy WordPress configuration
#COPY wp-config.php /var/www/html/wp-config.php
COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
# Set permissions for WordPress
RUN chown -R www-data:www-data /var/www/html 

RUN mkdir -p /run/php

# Expose port 9000 (PHP-FPM)
EXPOSE 9000

# Start PHP-FPM in the foreground
CMD ["php-fpm8.2", "-F"]

#CMD	["php", "--nodaemonize"]
