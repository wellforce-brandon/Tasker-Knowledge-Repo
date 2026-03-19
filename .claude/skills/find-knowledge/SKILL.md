---
name: find-knowledge
description: Search the Tasker knowledge base and return a focused summary with file citations.
user-invocable: true
model: haiku
allowed-tools:
  - Read
  - Glob
  - Grep
---

# Find Knowledge

Search the knowledge base for information about a Tasker topic.

## Steps

1. **Read the index.** Read `knowledge/_index.md` to identify potentially relevant files from the one-line summaries.

2. **Search for keywords.** Use Grep to search `knowledge/` for the user's query terms. Search broadly -- include synonyms and related terms.

3. **Read top matches.** Read the most relevant files (up to 3) identified from the index and grep results.

4. **Synthesize.** Return a focused summary answering the user's question. Include:
   - The key facts relevant to their question.
   - Code/XML examples if available.
   - Gotchas that apply.
   - File citations in the format `knowledge/<category>/<file>.md` so the user can read more.

5. **Note gaps.** If the knowledge base doesn't have sufficient information, say so explicitly. Suggest what could be added.
