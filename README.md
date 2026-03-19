# Tasker Knowledge Repo

A living knowledge base for [Tasker](https://tasker.joaoapps.com/) (Android automation) that Claude Code accumulates over time. Designed to be referenced from any Tasker project via `/add-dir`.

## How It Works

The `knowledge/` directory contains topical markdown files covering Tasker core concepts, programming, XML structure, intents, plugins, UI, patterns, and workarounds. Claude Code reads, searches, and updates these files through three workflows.

## Workflows

### 1. Add Knowledge

Say **"add knowledge"** to capture a single fact, technique, or gotcha.

Claude finds the right file, appends to the correct section, and updates the index.

### 2. Import Session

Say **"import session"** to bulk-import knowledge from another session.

Paste raw notes, point to a handoff doc, or provide a transcript path. Claude parses it into discrete items and distributes them across the knowledge base.

### 3. Find Knowledge

Say **"find knowledge"** to search the knowledge base.

Claude searches the index and files, then returns a focused summary with file citations.

### 4. Manual Edit

Edit files in `knowledge/` directly. Follow the format in `knowledge/_conventions.md`.

## Cross-Repo Usage

From any Tasker project repo in Claude Code:

```
/add-dir C:\Github\Tasker-Knowledge-Repo
```

Then use the **tasker-expert** agent or **find-knowledge** skill to query while working.

## Knowledge Structure

```
knowledge/
  _index.md              # Master index -- read this first
  _conventions.md        # File format standard
  core/                  # Profiles, tasks, variables, scenes
  programming/           # JavaScript, Java reflection, shell
  xml/                   # Task XML structure, action codes, import/export
  intents/               # Intent basics and common intents
  plugins/               # AutoTools, AutoInput, AutoNotification, Join
  ui/                    # WebView, JS bridge, scene elements
  patterns/              # API integration, events, errors, debugging
  workarounds/           # Gotchas, Android compat, permissions
```

## Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| add-knowledge | "add knowledge" | Append a fact/technique to the right knowledge file |
| find-knowledge | "find knowledge" | Search the knowledge base, return summary with citations |
| import-session | "import session" | Parse unstructured content into knowledge files |
| plan-repo | "plan repo" | Research and recommend best tech stack |
| init-repo | "initialize repo" | Build or rebuild .claude/ folder with best practices |
| update-practices | "update practices" | Fetch latest best practices and update config |
| spec-developer | "spec developer" | Interview-driven feature spec saved to /tasks |
| code-review | "code review" | Full codebase review with severity-ranked findings |
| security-scan | "security scan" | OWASP Top 10 security audit |
| performance-review | "performance review" | Performance analysis with fix recommendations |
| dependency-audit | "dependency audit" | Check dependencies for updates and vulnerabilities |
| test-scaffold | "scaffold tests" | Generate test files for untested modules |
| doc-sync | "sync docs" | Align documentation with current code |
| mermaid-diagram | "mermaid diagram" | Generate data flow / architecture diagrams |

## Agents

| Agent | Purpose |
|-------|---------|
| tasker-expert | Answer Tasker questions from the knowledge base |
| architect | Phase-based planning, tech stack decisions |
| reviewer | Code review for correctness and maintainability |
| security | Vulnerability detection and security analysis |
| performance | Bottleneck identification and optimization |
| explorer | Codebase exploration, research, context gathering |

See [agents.md](agents.md) for the full agent registry.

## Full Documentation

See [instructions.md](instructions.md) for complete documentation on every skill, agent, and configuration option.

## License

MIT
