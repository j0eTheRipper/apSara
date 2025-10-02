# ap_sara

APU student personal assistant.

# Feature documentation

## Chatbot

SARA is an advanced AI-powered chatbot designed specifically for APU students and staff. Built using latest Retrieval-Augmented Generation (RAG) technologies, SARA provides contextual responses to university-related queries.

### Key Features

- **Academic Knowledge Base**: Answers questions about APU services, procedures, and policies using the official knowledge base
- **Conversational Memory**: Maintains context across conversation sessions for natural follow-up interactions
- **Multi-format Document Processing**: Processes PDFs, DOCX, PPTX, and text files from the university knowledge base
- **Real-time Streaming**: Provides real-time response generation for enhanced user experience
- **Session Management**: Isolated conversation histories with automatic cleanup

### Technical Architecture

- **Backend**: Python-based system using Flask REST API (`api.py`)
- **Language Model**: Qwen2.5 (3B/7B) via Ollama for local inference
- **Embeddings**: BAAI/bge-large-en-v1.5 for semantic document understanding
- **Vector Database**: ChromaDB for efficient document retrieval
- **NLP Processing**: spaCy for advanced semantic analysis

### API Endpoints

The chatbot provides RESTful API endpoints for integration:

- `POST /chat/query` - Process user queries with automatic session management
- `POST /chat/conversation` - Handle conversational queries with memory
- `POST /chat/stream` - Server-Sent Events streaming for real-time responses
- `GET /chat/status/<session_id>` - Get processing status
- `GET /chat/history/<session_id>` - Retrieve conversation history
- `POST /sessions` - Create new chat sessions
- `GET /sessions` - List all available sessions

### Usage Example

```bash
# Start the API server
cd /path/to/SARA
python api.py

# Query the chatbot
curl -X POST http://localhost:8000/chat/query \
  -H "Content-Type: application/json" \
  -d '{"query": "How do I submit EC?"}'
```

### Performance Metrics

- **Accuracy**: 99.6% based on comprehensive testing
- **Response Time**: ~4.8 seconds average
- **FAQ Match Rate**: 100% for frequently asked questions
- **Supported Languages**: Primarily English with multi-language detection

**Note**: SARA is trained on APU's official knowledge base (current as of August 2025) and provides responses specific to university policies and procedures. For more details, check full [SARA chatbot project](https://github.com/nikiwit/SARA).

## Schedule

## Navigation
dddd
# Contributing guidelines...
Please follow these guidelines when pushing new changes.

## Do NOT push to master.
If you have a change, no matter how small or big, you should NOT push to master.

To contribute, `git checkout master` on your local repository, `git pull` the changes from master.
To start working on your new change (feature, fix, etc...) make a new branch (DO NOT CHECKOUT AN OLD BRANCH) `git checkout -b feat/new-feature-name` and work on the new branch.
You can make as many commits as you like in the new branch. 
After you have finished working on your changes, commit the changes, and push them to upstream: `git commit -m 'describe your change'; git push --set-upstream origin feat/new-feature-name`

This last command makes a new branch on the remote branch.
After you have created the branch, you can rebase it on master in GitHub.


This workflow ensures that no conflicts occur on the master branch. please abide by the workflow and contact me (youssef) if you need any clarification or help.

Happy coding!


