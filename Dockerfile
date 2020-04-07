FROM php:7.0-apache
COPY build/web /var/www/html
EXPOSE 80
