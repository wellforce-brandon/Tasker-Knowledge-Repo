# Conditional Rules

Place rule files here with `paths:` frontmatter to conditionally load instructions when working with matching file paths.

## Example

```markdown
---
paths:
  - "src/api/**"
  - "src/routes/**"
---

# API Rules

- All endpoints must validate request bodies with zod schemas
- Return consistent error response shapes
- Log all 5xx errors with request context
```

## How It Works

- Rules only load when Claude is working with files matching the `paths:` glob patterns
- This keeps context narrow -- frontend rules don't load during backend work
- Use this instead of subfolder CLAUDE.md files for fine-grained scoping
