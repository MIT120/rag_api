# Makefile for RAG API local development

.PHONY: help build up down logs restart clean health dev test

help: ## Show this help message
	@echo "RAG API Development Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker images
	docker compose build

up: ## Start all services
	docker compose up -d

dev: ## Start services with development hot reload
	docker compose -f docker-compose.yaml -f docker-compose.dev.yml up --build

down: ## Stop all services
	docker compose down

logs: ## View logs from all services
	docker compose logs -f

restart: ## Restart the FastAPI service
	docker compose restart fastapi

clean: ## Stop services and remove volumes
	docker compose down -v
	docker system prune -f

health: ## Check health of all services
	./check-health.sh

test: ## Run tests (requires test setup)
	docker compose exec fastapi pytest

db-only: ## Start only the database
	docker compose -f db-compose.yaml up -d

api-only: ## Start only the API (requires external database)
	docker compose -f api-compose.yaml up -d

shell: ## Open a shell in the FastAPI container
	docker compose exec fastapi bash

db-shell: ## Open a PostgreSQL shell
	docker compose exec db psql -U myuser -d mydatabase