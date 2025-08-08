# FragRag
A graph RAG vs RAG implementation

## to hit the api on krish home pc

```
curl --location 'http://home-pc.tail4924f5.ts.net:11434/api/generate' \
--header 'Content-Type: application/json' \
--data '{
    "model": "llama3",
    "prompt": "give me only the query and nothing else. Give me the cypher query in neo4j to create a relationship between man and person. Assume that these nodes of man and person already exist",
    "stream": false
}'
```

```
curl --location 'http://krish-home-nas.tail4924f5.ts.net:11434/api/generate' \
--header 'Content-Type: application/json' \
--data '{
    "model": "tinyllama",
    "prompt": "give me only the query and nothing else. Give me the cypher query in neo4j to create a relationship between man and person. Assume that these nodes of man and person already exist",
    "stream": false
}'
```

### OpenWebUI PC

```
http://krish-home-nas.tail4924f5.ts.net:4012/
```

### OpenWebUI NAS

```
http://krish-home-nas.tail4924f5.ts.net:4013/
```