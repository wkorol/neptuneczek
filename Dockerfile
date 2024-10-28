# Use Apache with PHP 8.3
FROM php:8.3-apache-bookworm

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install necessary packages and PHP extensions
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install wget git bash libpq-dev libzip-dev unzip libxml2-dev \
    && docker-php-ext-install pdo pdo_pgsql opcache zip soap intl

# Enable Apache modules
RUN a2enmod rewrite ssl socache_shmcb

# Install Composer
COPY --from=composer/composer:2.7.7-bin /composer /usr/bin/composer

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy your application files into the container
COPY . /var/www/html

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
#
RUN echo "ServerName _" >> /etc/apache2/conf-available/servername.conf && \
    a2enconf servername

RUN composer install --optimize-autoloader --no-dev

EXPOSE 8080

# Start Apache in the foreground
CMD ["apache2-foreground"]
