# FragRag
A graph RAG vs RAG implementation

## to hit the api on krish home pc

```
curl --location 'http://home-pc.tail4924f5.ts.net:11434/api/generate' \
--header 'Content-Type: application/json' \
--data '{
    "model": "llama3",
    "prompt": "Hello, Ollama!",
    "stream": false
}'
```