#!/bin/bash
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

if ! wp core is-installed --allow-root; then
	wp core download --allow-root
	wp config create \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=${MYSQL_HOST} \
		--allow-root
	wp core install \
		--url=${DOMAIN_NAME} \
		--title="Inception WP" \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--allow-root
	if ! wp user get ${WP_USER} --allow-root >/dev/null 2>&1; then
		wp user create ${WP_USER} ${WP_USER_EMAIL}\
			--role=subscriber \
			--user_pass=${WP_USER_PASSWORD} \
			--allow-root
	fi
fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec "$@"
