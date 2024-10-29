# Makefile

SHELL := /bin/bash
DOCKER_COMPOSE ?= docker compose
EXEC_COMMAND ?= ${DOCKER_COMPOSE} exec php
COMPOSER_EXEC ?= composer
DOCKER_IMAGE ?= ghcr.io/wkorol/symfony-app:latest


# Start the application in development mode
start: build up composer_install # Bootstrap and start the application (dev)


# Build Docker image
build: # Build Docker image and push to registry
	docker build -t ${DOCKER_IMAGE} .
	docker push ${DOCKER_IMAGE}

# Start Docker Compose in detached mode
up: # Start docker compose in the background
	${DOCKER_COMPOSE} up -d

# Stop Docker Compose
down: # Stop docker compose
	${DOCKER_COMPOSE} down

# Install Composer dependencies inside the container
composer_install: # Install composer dependencies
	${EXEC_COMMAND} ${COMPOSER_EXEC} install --optimize-autoloader --no-dev

# Run PHPStan for static analysis
lint: # Run PHPStan linter for static code analysis
	${EXEC_COMMAND} vendor/bin/phpstan analyse --memory-limit=-1

# Run tests
test: phpunit # Run PHPUnit tests

# Run PHPUnit tests
phpunit: # Run phpunit tests
	${EXEC_COMMAND} vendor/bin/phpunit

# Deploy to DigitalOcean
deploy: # Trigger redeployment on DigitalOcean
	curl -X POST -H "Content-Type: application/json" \
	-H "Authorization: Bearer $(DO_API_TOKEN)" \
	https://api.digitalocean.com/v2/apps/$(DO_APP_ID)/deployments
