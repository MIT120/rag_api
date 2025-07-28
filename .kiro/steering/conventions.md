# Coding Conventions

## Error Handling Patterns
- Use structured logging with `logger.error()` including context (file paths, IDs, etc.)
- Include full traceback in error logs: `traceback.format_exc()`
- Wrap operations in try/catch blocks with specific HTTPException responses
- Use centralized error messages from `app.constants.ERROR_MESSAGES`

## Async/Threading Patterns
- Use `run_in_executor(request.app.state.thread_pool, func)` for CPU-bound operations
- Consistent async/await usage throughout the application
- Thread pool executor initialized in FastAPI lifespan with CPU core-based sizing

## Authentication & Authorization
- Check `request.state.user` for authenticated users
- Fall back to `entity_id` parameter or "public" for unauthenticated access
- User isolation enforced through `user_id` metadata in documents

## Vector Store Abstraction
- Use `isinstance(vector_store, AsyncPgVector)` to handle async vs sync operations
- Factory pattern for vector store creation supports multiple backends
- Consistent filter patterns: `{"file_id": file_id}` and `{"file_id": {"$in": file_ids}}`

## Document Processing
- Use `RecursiveCharacterTextSplitter` with configurable chunk size/overlap
- Clean PDF content with `clean_text()` function to remove null bytes
- Generate MD5 digest for document deduplication
- Temporary file cleanup in finally blocks

## Configuration Management
- Environment variables with sensible defaults using `get_env_variable()`
- Enum-based configuration for type safety (VectorDBType, EmbeddingsProvider)
- Centralized configuration in `app.config.py`

## File Naming & Import Conventions
- Snake_case for all Python files and directories
- Route files suffixed with `_routes.py`
- Service files indicate domain (e.g., `database.py`, `mongo_client.py`)
- Standard library → third-party → local imports order