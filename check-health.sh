#!/bin/bash

# Health check script for RAG API

echo "🔍 Checking RAG API health..."

# Check if services are running
if ! docker compose ps | grep -q "Up"; then
    echo "❌ Services are not running. Start them with: docker compose up -d"
    exit 1
fi

# Check database health
echo "📊 Checking database..."
if docker compose exec -T db pg_isready -U myuser -d mydatabase > /dev/null 2>&1; then
    echo "✅ Database is healthy"
else
    echo "❌ Database is not ready"
    exit 1
fi

# Check API health
echo "🌐 Checking API..."
if curl -s http://localhost:8000/health > /dev/null; then
    echo "✅ API is healthy"
    
    # Get API info
    echo ""
    echo "📋 API Information:"
    curl -s http://localhost:8000/health | python3 -m json.tool 2>/dev/null || echo "API responded but JSON parsing failed"
else
    echo "❌ API is not responding"
    exit 1
fi

echo ""
echo "🎉 All services are healthy!"
echo "📍 API URL: http://localhost:8000"
echo "📍 API Docs: http://localhost:8000/docs"