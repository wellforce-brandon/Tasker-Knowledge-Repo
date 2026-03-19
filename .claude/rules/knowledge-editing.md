---
paths:
  - "knowledge/**"
---

# Knowledge File Editing Rules

When editing any file in `knowledge/`:

- Follow the format defined in `knowledge/_conventions.md`: Title, Key Facts, Details, Gotchas, Related.
- Keep every file under 500 lines. If approaching the limit, split into multiple files.
- Update `knowledge/_index.md` whenever a new file is created.
- Use the Gotchas section for counterintuitive behaviors, common mistakes, and pain points.
- Include code/XML examples wherever possible -- examples are more useful than prose.
- Note the Tasker version when a behavior is version-specific.
- Append to existing files before creating new ones. Check the index first.
- Use `[[filename.md]]` links in the Related section with a brief reason for the link.
