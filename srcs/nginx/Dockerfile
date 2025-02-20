FROM debian:bookworm-slim

# Install NGINX and dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl/private

# Generate self-signed certificate for testing
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/key.pem \
    -out /etc/ssl/certs/cert.pem \
#    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=${DOMAIN_NAME}"

# Create directory for WordPress files
RUN mkdir -p /var/www/html

# Copy custom config
COPY nginx.conf /etc/nginx/nginx.conf

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose Port 443
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]