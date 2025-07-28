# Product Overview

This is an ID-based RAG (Retrieval-Augmented Generation) FastAPI service that integrates Langchain with FastAPI for document indexing and retrieval. The system is designed for asynchronous, scalable document processing using PostgreSQL with pgvector for vector storage.

## Core Purpose

The primary use case is integration with LibreChat, providing file-level embedding management where documents are organized by `file_id`. This approach enables targeted queries when combined with file metadata stored in a database.

## Key Features

- **Document Management**: Add, retrieve, and delete documents with file-level organization
- **Vector Storage**: Utilizes Langchain's vector store with PostgreSQL/pgvector or MongoDB Atlas
- **Asynchronous Operations**: Built for high-performance async processing
- **Multi-provider Embeddings**: Supports OpenAI, Azure, HuggingFace, Ollama, Bedrock, and VertexAI
- **Authentication**: JWT-based authentication with user/entity isolation
- **File Processing**: Handles multiple document formats (PDF, DOCX, TXT, Markdown, etc.)

## Target Integration

Designed specifically for LibreChat integration but can be used for any ID-based document retrieval system requiring file-level embedding management.