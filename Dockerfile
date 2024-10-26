# Use Apache with PHP 8.3
FROM php:8.3-apache-bookworm

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

# Ensure the DocumentRoot is set to the correct path
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Set a ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN composer install --no-interaction --optimize-autoloader --no-dev

# Expose Apache port
EXPOSE 8080

# Start Apache in the foreground
CMD ["apache2-foreground"]
