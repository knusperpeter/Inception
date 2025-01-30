FROM debian:latest

# Install NGINX and dependencies
RUN	apt update && apt install -y \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

# Copy SSL certs
#COPY ssl/cert.pem /etc/ssl/certs/cert.pem
#COPY ssl/key.pem /etc/ssl/private/key.pem

# Expose Port 443
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
