#!/bin/bash

# Run composer install
echo "Running composer install..."
composer install --no-dev --optimize-autoloader

# Start Apache
apache2-foreground