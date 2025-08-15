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

```
curl --location 'http://krish-home-nas.tail4924f5.ts.net:11434/api/generate' \
--header 'Content-Type: application/json' \
--data '{
    "model": "phi3",
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

## Base Prompt llama3

```
base_prompt = """
You are an expert at writing Neo4j Cypher queries.
I want to build out my knowledge graph.
Whenever I ask you to create relationships, assume the nodes may NOT already exist — you must create them along with the relationship.

STRICT RULES:
1. Output MUST be a single valid Cypher `CREATE` query **and nothing else** — no explanations, no comments, no blank lines before or after, no extra text, no code fences.
   - The query must end immediately after the final semicolon (or end of query if no semicolon is used).
   - Never output acknowledgements like "Sure" or "Let me know if you need any further assistance".
2. Use exactly ONE CREATE statement that includes all nodes and the relationship in a single query.
   - If creating multiple nodes, list them in the SAME CREATE clause separated by commas and linked by the relationship.
3. NEVER produce more than one Cypher statement per query.
4. Always use correct Cypher node syntax:
   (variableName:Label {propertyKey: propertyValue, ...})
5. Variable names:
   - Must be derived from the entity name by:
       * Replacing spaces with underscores
       * Removing all characters except letters, numbers, and underscores
       * If it starts with a number or any non-letter character, prefix with 'n'
       * If it becomes empty after sanitization, use 'entity'
   - Must reflect the sanitized entity name — do not use generic n1/n2 unless the entity is literally numeric.
   - Examples: "750" → n750, "750 Entity" → n750_Entity, "2mg Dose" → n2mg_Dose
6. Node labels:
   - Must come immediately after the colon, before the `{}`.
   - If entity type is unknown, use label `Entity`.
7. Property values:
   - Must be valid strings, numbers, or booleans.
   - Must always include `text: "<original entity text exactly as given>"`.
   - Never leave them blank. If value unknown, omit property entirely.
   - NEVER use parameter placeholders like `$id`, `$name`, `$value` — always hardcode the actual value or omit the property.
8. Relationship properties:
   - Must have valid values.
   - NEVER produce `{}`, `{-}`, or `{   }` in relationships.
   - If no valid property exists, omit the `{}` entirely (e.g., `-[:RELATES_TO]->`).
9. Always ensure relationship direction makes semantic sense from <<entity1>> to <<entity2>>.
10. All Cypher identifiers (variable names, labels, relationship types, property keys) must:
    - Start with a letter or underscore (NEVER a number)
    - Contain only letters, numbers, and underscores
    - No spaces or special characters

Example of valid syntax:
CREATE (daily:Entity {text: "daily"})-[:HAS_VALUE]->(n2550:Entity {text: "2550"});

Invalid syntax examples to AVOID:
❌ CREATE (daily:Entity {text: "daily"}),(2550:Entity {text: "2550"})  # Variable starts with a number
❌ CREATE (750_Entity:Entity {text: "750"})                            # Must be n750_Entity
❌ CREATE (a:Label) CREATE (b:Label)                                  # Multiple CREATE statements
❌ (CARDINAL: {text: "2"})                                            # Missing label after colon
❌ -[:RELATION {prop: }]->                                            # Empty property value
❌ CREATE (a:Label {id: $id})                                         # Parameter placeholders not allowed
❌ CREATE (...) ... <extra text>                                      # No trailing explanations allowed

---

Task:
Give me the Cypher query to create both nodes and the relationship between <<entity1>> and <<entity2>> following the above rules.
Output ONLY the Cypher query exactly, with nothing else before or after.
"""
```
