# Project Structure

## Root Level Organization
```
├── main.py                 # FastAPI application entry point
├── requirements.txt        # Production dependencies
├── test_requirements.txt   # Testing dependencies
├── docker-compose.yaml     # Full stack deployment
├── db-compose.yaml         # Database-only deployment
├── api-compose.yaml        # API-only deployment
└── Dockerfile             # Container build configuration
```

## Application Structure (`app/`)
The main application code follows a layered architecture:

```
app/
├── __init__.py
├── config.py              # Configuration, environment variables, logging
├── constants.py           # Application constants and error messages
├── middleware.py          # Custom middleware (security, etc.)
├── models.py              # Pydantic models for request/response
├── routes/                # API endpoint definitions
│   ├── document_routes.py # Main document CRUD operations
│   └── pgvector_routes.py # Debug routes (only in debug mode)
├── services/              # Business logic layer
│   ├── database.py        # Database connection and health checks
│   ├── mongo_client.py    # MongoDB client utilities
│   └── vector_store/      # Vector database implementations
│       ├── factory.py     # Vector store factory pattern
│       ├── async_pg_vector.py    # Async PostgreSQL implementation
│       ├── atlas_mongo_vector.py # MongoDB Atlas implementation
│       └── extended_pg_vector.py # Extended PostgreSQL features
└── utils/                 # Utility functions
    ├── document_loader.py # Document parsing and loading
    └── health.py          # Health check utilities
```

## Testing Structure (`tests/`)
Tests mirror the application structure:

```
tests/
├── conftest.py            # Pytest configuration and fixtures
├── test_*.py              # Root level tests (main, config, etc.)
├── services/              # Service layer tests
│   ├── test_database.py
│   └── test_vector_store.py
└── utils/                 # Utility tests
    └── test_document_loader.py
```

## Key Architectural Patterns

### Configuration Management
- All configuration centralized in `app/config.py`
- Environment-based configuration with sensible defaults
- Enum-based configuration for type safety (VectorDBType, EmbeddingsProvider)

### Async/Await Pattern
- Consistent async/await usage throughout the application
- Thread pool executor for CPU-bound operations
- Async database operations with connection pooling

### Factory Pattern
- Vector store creation abstracted through factory (`vector_store/factory.py`)
- Supports multiple vector database backends

### Middleware Stack
- CORS middleware for cross-origin requests
- Custom logging middleware for request/response tracking
- Security middleware for JWT authentication

### Error Handling
- Centralized error messages in `constants.py`
- Consistent HTTP exception handling across routes
- Comprehensive logging with structured JSON output option

## File Naming Conventions
- Snake_case for Python files and directories
- Descriptive names that indicate purpose
- Test files prefixed with `test_`
- Route files suffixed with `_routes.py`
- Service files indicate their domain (e.g., `database.py`, `mongo_client.py`)

## Import Organization
- Standard library imports first
- Third-party imports second
- Local application imports last
- Relative imports used within the same package