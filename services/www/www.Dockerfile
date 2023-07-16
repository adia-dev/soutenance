FROM ubuntu:20.04

RUN apt-get update && apt-get install -y nginx php-fpm

COPY default /etc/nginx/sites-available/default
COPY index.php /var/www/html/index.php

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
