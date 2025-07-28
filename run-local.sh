#!/bin/bash

# Local development script for RAG API

set -e

echo "🚀 Starting RAG API for local development..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found."
    echo "📋 Creating .env from .env.example..."
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "✅ Created .env file from .env.example"
        echo "⚠️  Please edit .env and add your OpenAI API key before continuing"
        echo "   Replace 'your-openai-api-key-here' with your actual API key"
        exit 1
    else
        echo "❌ .env.example not found. Please create a .env file manually."
        exit 1
    fi
fi

# Check if OpenAI API key is set (if using OpenAI embeddings)
if grep -q "RAG_OPENAI_API_KEY=your-openai-api-key-here" .env; then
    echo "⚠️  Warning: Please set your actual OpenAI API key in .env file"
    echo "   Edit .env and replace 'your-openai-api-key-here' with your actual API key"
    echo ""
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create uploads directory if it doesn't exist
mkdir -p uploads

echo "📦 Building and starting services..."

# Start the services
docker compose up --build -d

echo "⏳ Waiting for services to be ready..."

# Wait for database to be ready (with timeout)
echo "🔍 Checking database connection..."
timeout=60
counter=0
until docker compose exec -T db pg_isready -U myuser -d mydatabase > /dev/null 2>&1; do
    if [ $counter -ge $timeout ]; then
        echo "❌ Database failed to start within $timeout seconds"
        echo "📋 Check logs with: docker compose logs db"
        exit 1
    fi
    echo "   Database is not ready yet, waiting... ($counter/$timeout)"
    sleep 2
    counter=$((counter + 2))
done

echo "✅ Database is ready!"

# Wait for API to be ready (with timeout)
echo "🔍 Checking API connection..."
counter=0
until curl -s http://localhost:8000/health > /dev/null 2>&1; do
    if [ $counter -ge $timeout ]; then
        echo "❌ API failed to start within $timeout seconds"
        echo "📋 Check logs with: docker compose logs fastapi"
        exit 1
    fi
    echo "   API is not ready yet, waiting... ($counter/$timeout)"
    sleep 2
    counter=$((counter + 2))
done

echo "✅ API is ready!"
echo ""
echo "🎉 RAG API is now running locally!"
echo ""
echo "📍 API URL: http://localhost:8000"
echo "📍 Database: localhost:5433"
echo "📍 API Docs: http://localhost:8000/docs"
echo "📍 Health Check: http://localhost:8000/health"
echo ""
echo "📋 Useful commands:"
echo "   View logs: docker compose logs -f"
echo "   Stop services: docker compose down"
echo "   Restart API: docker compose restart fastapi"
echo "   Health check: ./check-health.sh"
echo "   Use Makefile: make help"
echo ""
echo "🔧 For development with hot reload, use:"
echo "   make dev"
echo "   # or: docker compose -f docker-compose.yaml -f docker-compose.dev.yml up --build"