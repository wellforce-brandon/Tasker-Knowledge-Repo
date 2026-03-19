# Tasker Knowledge Repo -- Implementation Plan

## Context

This repo is currently a Claude Code starter template. We're repurposing it as a **Tasker knowledge base** -- a living reference that Claude Code accumulates over time while working on Tasker (Android automation) projects. The user has a secondary CC session with hard-won Tasker knowledge that needs to be captured. The existing `.claude/` infrastructure (skills, agents, settings) stays intact; we add knowledge-specific structure on top.

**Cross-repo usage:** `/add-dir C:\Github\Tasker-Knowledge-Repo` from any Tasker project repo.

---

## Phase 1: Knowledge Directory Structure

Create `knowledge/` with topical subdirectories. Each file is a standalone topic, kept under 500 lines.

```
knowledge/
  _index.md              # Master index: one-line summary per file
  _conventions.md        # How to write/format knowledge files
  core/
    profiles-and-contexts.md
    tasks-and-actions.md
    variables.md
    scenes.md
  programming/
    javascript.md
    java-reflection.md
    shell-commands.md
  xml/
    task-xml-structure.md
    action-codes.md
    import-export.md
  intents/
    intent-basics.md
    common-intents.md
  plugins/
    autotools.md
    autoinput.md
    autonotification.md
    join.md
    plugin-architecture.md
  ui/
    webview-and-js-bridge.md
    scene-elements.md
  patterns/
    api-integration.md
    event-handling.md
    error-handling.md
    debugging.md
  workarounds/
    common-gotchas.md
    android-version-compat.md
    permission-issues.md
```

### Files to create

**`knowledge/_conventions.md`** -- Defines the standard format:

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

Rules: stay under 500 lines, append to existing files before creating new ones, include code/XML examples, note Tasker version where relevant.

**`knowledge/_index.md`** -- One-line summary per file. Claude reads this first to find the right file. Updated whenever files are added.

**Skeleton files** in each subdirectory -- title + summary + empty sections so the structure is navigable from day one. These get populated over time.

---

## Phase 2: New Skills (3)

### `add-knowledge` -- `.claude/skills/add-knowledge/SKILL.md`
- **Trigger:** "add knowledge", "save knowledge", "document this"
- **Model:** sonnet
- **Steps:** Read `_index.md` -> find matching file -> read it -> append new knowledge in right section -> update `_index.md` if new file created
- **Use case:** Quick single-fact or technique capture

### `find-knowledge` -- `.claude/skills/find-knowledge/SKILL.md`
- **Trigger:** "find knowledge", "search knowledge", "what do we know about"
- **Model:** haiku (fast lookup)
- **Steps:** Read `_index.md` -> Grep `knowledge/` for keywords -> read top matches -> return focused summary with file citations

### `import-session` -- `.claude/skills/import-session/SKILL.md`
- **Trigger:** "import session", "dump session knowledge"
- **Model:** opus (parse unstructured content)
- **Steps:** Read `_index.md` + `_conventions.md` -> accept raw input (paste, handoff doc, or notes) -> parse into discrete items -> classify by domain -> append to appropriate files -> update `_index.md` -> report summary

---

## Phase 3: New Agent

### `tasker-expert` -- `.claude/agents/tasker-expert.md`
- **Model:** sonnet
- **Memory:** project
- **Tools:** Read, Glob, Grep
- **Purpose:** Answer Tasker questions by searching the knowledge base. Primary interface when using this repo via `/add-dir` from another project.
- **Behavior:** Read `_index.md` -> find relevant files -> read them -> synthesize answer. If knowledge is missing, say so explicitly.

---

## Phase 4: Conditional Rules

### `.claude/rules/knowledge-editing.md`
```yaml
paths: ["knowledge/**"]
```
Rules: follow `_conventions.md` format, keep under 500 lines, update `_index.md` on new files, use Gotchas section for pain points.

### `.claude/rules/xml-knowledge.md`
```yaml
paths: ["knowledge/xml/**"]
```
Rules: include XML snippets, document action code numbers, note Tasker version.

### `.claude/rules/plugin-knowledge.md`
```yaml
paths: ["knowledge/plugins/**"]
```
Rules: document plugin version, note conflicts, include bundle/intent names.

---

## Phase 5: Update Existing Files

### `CLAUDE.md` (rewrite)
- Replace generic template description with Tasker knowledge base purpose
- Point Claude to `knowledge/_index.md` as the entry point
- Keep existing skill/agent/subagent sections
- Add cross-repo usage instructions (`/add-dir`)
- Stay under 150 lines

### `agents.md`
- Add `tasker-expert` agent entry

### `README.md` (rewrite)
- Describe this as a Tasker knowledge repo
- Document the three workflows (add-knowledge, import-session, manual edit)
- Document cross-repo usage via `/add-dir`
- Keep skill/agent reference tables

### `instructions.md`
- Add sections for the three new skills
- Add tasker-expert agent docs
- Add knowledge contribution workflow

### `.claude/settings.json`
- No changes needed (current permissions sufficient)

---

## Phase 6: Seed Initial Knowledge

Create skeleton files in each `knowledge/` subdirectory with:
- Title and one-sentence summary
- Empty Key Facts, Details, Gotchas, Related sections
- These serve as landing zones for the user's first knowledge dump

---

## Implementation Order

1. `knowledge/_conventions.md` + `knowledge/_index.md`
2. All subdirectories with skeleton `.md` files
3. Three new skills (`add-knowledge`, `find-knowledge`, `import-session`)
4. `tasker-expert` agent
5. Three `.claude/rules/` files
6. Rewrite `CLAUDE.md`
7. Update `agents.md`
8. Rewrite `README.md`
9. Update `instructions.md`

---

## Critical Files

| File | Action |
|------|--------|
| `knowledge/_conventions.md` | Create (defines format standard) |
| `knowledge/_index.md` | Create (master index) |
| `knowledge/core/*.md` (4 files) | Create skeletons |
| `knowledge/programming/*.md` (3 files) | Create skeletons |
| `knowledge/xml/*.md` (3 files) | Create skeletons |
| `knowledge/intents/*.md` (2 files) | Create skeletons |
| `knowledge/plugins/*.md` (5 files) | Create skeletons |
| `knowledge/ui/*.md` (2 files) | Create skeletons |
| `knowledge/patterns/*.md` (4 files) | Create skeletons |
| `knowledge/workarounds/*.md` (3 files) | Create skeletons |
| `.claude/skills/add-knowledge/SKILL.md` | Create |
| `.claude/skills/find-knowledge/SKILL.md` | Create |
| `.claude/skills/import-session/SKILL.md` | Create |
| `.claude/agents/tasker-expert.md` | Create |
| `.claude/rules/knowledge-editing.md` | Create (replace existing README.md) |
| `.claude/rules/xml-knowledge.md` | Create |
| `.claude/rules/plugin-knowledge.md` | Create |
| `CLAUDE.md` | Rewrite |
| `agents.md` | Update (add tasker-expert) |
| `README.md` | Rewrite |
| `instructions.md` | Update |

## Verification

1. Run `find knowledge/ -name "*.md" | wc -l` -- should be ~28 files
2. Run each skill trigger ("add knowledge", "find knowledge", "import session") to verify they work
3. Test `/add-dir` from another repo to confirm cross-repo access
4. Verify `CLAUDE.md` is under 150 lines
5. Verify all knowledge files have the standard format from `_conventions.md`
