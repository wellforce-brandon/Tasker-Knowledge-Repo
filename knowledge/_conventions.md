# Knowledge File Conventions

> Standard format and rules for all knowledge files in this repository.

## File Format

Every knowledge file follows this template:

```markdown
# [Topic Title]
> One-sentence summary.

## Key Facts
- Bullet points of the most important things

## Details
### [Subtopic]
Prose, code examples, XML snippets.

## Gotchas
- Counterintuitive behaviors, common errors

## Related
- [[other-file.md]] -- why it's related
```

## Rules

- **Stay under 500 lines.** Split into multiple files if a topic grows too large.
- **Append before creating.** Check `_index.md` for an existing file before creating a new one.
- **Include examples.** Code snippets, XML fragments, and shell commands are more useful than prose alone.
- **Note Tasker version** when a feature or behavior is version-specific (e.g., "Tasker 6.2+").
- **Use the Gotchas section** for counterintuitive behaviors, common mistakes, and pain points.
- **Keep Related links current.** Use `[[filename.md]]` syntax with a brief reason for the link.
- **Update `_index.md`** whenever a new file is created -- add a one-line summary.
- **One topic per file.** If a file covers two distinct topics, split it.
- **Flat within subdirectories.** No nesting deeper than `knowledge/<category>/<file>.md`.
