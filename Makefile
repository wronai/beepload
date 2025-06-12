.PHONY: help setup start stop restart logs clean test build deploy

# Colors
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  ${YELLOW}%-30s${GREEN}%s${RESET}\n", $$1, $$2}' $(MAKEFILE_LIST)

## Install dependencies and setup environment
setup: ## Install dependencies and setup environment
	@echo "${YELLOW}🚀 Setting up Beepload...${RESET}"
	@./setup.sh

## Start all services in detached mode
start: ## Start all services in detached mode
	@echo "${YELLOW}🚀 Starting Beepload services...${RESET}"
	@docker-compose up -d

## Stop all services
stop: ## Stop all services
	@echo "${YELLOW}🛑 Stopping Beepload services...${RESET}"
	@docker-compose down

## Restart all services
restart: stop start ## Restart all services

## Show logs for all services
logs: ## Show logs for all services
	@docker-compose logs -f

## Show logs for a specific service (e.g., make logs-service service=frontend)
logs-service: ## Show logs for a specific service
	@docker-compose logs -f $(service)

## Clean up all containers, networks, and volumes
clean: ## Clean up all containers, networks, and volumes
	@echo "${YELLOW}🧹 Cleaning up...${RESET}"
	@docker-compose down -v
	@rm -rf frontend/node_modules services/*/node_modules

## Run tests
test: ## Run tests
	@echo "${YELLOW}🧪 Running tests...${RESET}"
	@cd frontend && npm test

## Build all services
build: ## Build all services
	@echo "${YELLOW}🔨 Building services...${RESET}"
	@docker-compose build

## Deploy to production (example - customize as needed)
deploy: ## Deploy to production
	@echo "${YELLOW}🚀 Deploying to production...${RESET}"
	git pull origin main
	make build
	make restart

## Create admin user
create-admin: ## Create admin user
	@echo "${YELLOW}👤 Creating admin user...${RESET}"
	@docker-compose exec auth-service node scripts/create-admin.js

## Show service status
status: ## Show service status
	@echo "${YELLOW}📊 Service status:${RESET}"
	@docker-compose ps

## Access shell in a service (e.g., make shell service=frontend)
shell: ## Access shell in a service
	@docker-compose exec $(service) sh

## View database (PostgreSQL)
db: ## Access database
	@echo "${YELLOW}📦 Accessing PostgreSQL database...${RESET}"
	@docker-compose exec db psql -U postgres

## View WebDAV storage
files: ## View WebDAV storage
	@echo "${YELLOW}📁 WebDAV storage available at: http://${WEBDAV_DOMAIN:-files.localhost}${RESET}"
	@echo "Use manager credentials to log in"

## View all available domains
domains: ## Show all configured domains
	@echo "${YELLOW}🌐 Configured domains:${RESET}"
	@echo "- Public Upload: http://${FRONTEND_DOMAIN:-upload.localhost}"
	@echo "- Manager:      http://${MANAGER_DOMAIN:-manager.localhost}"
	@echo "- Admin:        http://${ADMIN_DOMAIN:-admin.localhost}"
	@echo "- Auth:         http://${AUTH_DOMAIN:-auth.localhost}"
	@echo "- WebDAV:       http://${WEBDAV_DOMAIN:-files.localhost}"

## Show help by default
.DEFAULT_GOAL := help
