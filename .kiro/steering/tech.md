# Technology Stack

## Core Framework
- **FastAPI**: Async web framework for building APIs
- **Python 3.10+**: Primary programming language
- **Uvicorn**: ASGI server for running the FastAPI application

## Vector Database & Storage
- **PostgreSQL with pgvector**: Primary vector database (default)
- **MongoDB Atlas**: Alternative vector database option
- **Langchain**: Vector store abstraction and document processing
- **AsyncPG**: Async PostgreSQL driver for database operations

## Embeddings Providers
- **OpenAI**: text-embedding-3-small (default)
- **Azure OpenAI**: Azure-hosted OpenAI embeddings
- **HuggingFace**: sentence-transformers models
- **Ollama**: Local embedding models
- **AWS Bedrock**: Amazon's embedding services
- **Google VertexAI**: Google Cloud embeddings

## Document Processing
- **Unstructured**: Document parsing and text extraction
- **PyPDF**: PDF processing
- **python-docx**: Word document processing
- **Pandoc**: Document format conversion (required system dependency)

## Development Tools
- **Black**: Code formatting (configured via pre-commit)
- **Pre-commit**: Git hooks for code quality
- **Pytest**: Testing framework
- **Docker**: Containerization and deployment

## Common Commands

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Run the application
uvicorn main:app --reload

# Run with custom host/port
python main.py
```

### Docker Development
```bash
# Start full stack (API + PostgreSQL)
docker compose up

# Start only database
docker compose -f ./db-compose.yaml up

# Start only API
docker compose -f ./api-compose.yaml up
```

### Code Quality
```bash
# Install pre-commit hooks
pip install pre-commit
pre-commit install

# Run formatting manually
black .
```

### Testing
```bash
# Install test dependencies
pip install -r test_requirements.txt

# Run tests
pytest
```

## Environment Configuration
The application uses environment variables for configuration. Key variables include:
- `RAG_OPENAI_API_KEY`: OpenAI API key for embeddings
- `VECTOR_DB_TYPE`: Database type (pgvector/atlas-mongo)
- `POSTGRES_*`: Database connection settings
- `EMBEDDINGS_PROVIDER`: Embedding service provider
- `DEBUG_RAG_API`: Enable debug mode and additional routes