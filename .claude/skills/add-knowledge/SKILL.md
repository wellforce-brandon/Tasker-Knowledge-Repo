---
name: add-knowledge
description: Add a piece of Tasker knowledge to the knowledge base. Finds the right file and appends in the correct section.
user-invocable: true
model: sonnet
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

# Add Knowledge

Capture a piece of Tasker knowledge into the knowledge base.

## Steps

1. **Read the index.** Read `knowledge/_index.md` to see all existing files and their topics.

2. **Read conventions.** Read `knowledge/_conventions.md` to understand the file format.

3. **Classify the knowledge.** Determine which existing file the new knowledge belongs in based on the index. If no file matches, identify the correct subdirectory and plan a new file.

4. **Read the target file.** Read the matching knowledge file to understand its current contents and find the right section.

5. **Append the knowledge.** Add the new information to the appropriate section (Key Facts, Details, Gotchas, or Related). Follow the conventions:
   - Use bullet points for Key Facts and Gotchas.
   - Use prose and code examples for Details subsections.
   - Note Tasker version if version-specific.
   - Include XML/code snippets where helpful.

6. **If creating a new file:**
   - Use the template from `_conventions.md`.
   - Place it in the correct subdirectory.
   - Update `knowledge/_index.md` with a one-line summary.

7. **Verify.** Confirm the file stays under 500 lines. If it exceeds, suggest splitting.

8. **Report.** Tell the user what file was updated, what section, and a one-line summary of what was added.
