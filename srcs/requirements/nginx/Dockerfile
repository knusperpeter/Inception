#use daemon here?
FROM debian:bullseye-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx && \
    rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]