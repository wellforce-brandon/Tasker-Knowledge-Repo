---
name: import-session
description: Parse unstructured Tasker knowledge (session dumps, handoff docs, raw notes) into the knowledge base.
user-invocable: true
model: opus
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

# Import Session Knowledge

Parse unstructured content containing Tasker knowledge and distribute it across the knowledge base.

## Steps

1. **Read conventions and index.** Read `knowledge/_conventions.md` and `knowledge/_index.md` to understand the format and current state of the knowledge base.

2. **Accept input.** The user will provide raw content -- this may be:
   - Pasted text from another session
   - A handoff document path to read
   - Raw notes or bullet points
   - A file path to a session transcript

   If a file path is provided, read it. Otherwise, work with the pasted content.

3. **Parse into discrete items.** Break the raw content into individual knowledge items. Each item should be a single fact, technique, gotcha, or pattern.

4. **Classify each item.** For each knowledge item, determine:
   - Which subdirectory it belongs in (core, programming, xml, intents, plugins, ui, patterns, workarounds)
   - Which specific file it belongs in (check `_index.md`)
   - Which section within that file (Key Facts, Details, Gotchas, Related)

5. **Read target files.** Read each file that will receive new knowledge to understand current contents.

6. **Append knowledge.** For each item:
   - Add to the correct section of the correct file
   - Follow `_conventions.md` format
   - Include code/XML examples from the source material
   - Note Tasker version if mentioned

7. **Create new files if needed.** If knowledge doesn't fit any existing file:
   - Create a new file using the template from `_conventions.md`
   - Place in the correct subdirectory
   - Update `knowledge/_index.md`

8. **Verify file sizes.** Check that no file exceeds 500 lines. Flag any that need splitting.

9. **Report summary.** Provide a summary:
   - Number of knowledge items extracted
   - Files updated (with count of items per file)
   - New files created
   - Any items that couldn't be classified (ask user for guidance)
