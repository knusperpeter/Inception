#use daemon here?
FROM debian:bullseye-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=localhost" \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/private/nginx-selfsigned.crt

COPY ./conf/default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]