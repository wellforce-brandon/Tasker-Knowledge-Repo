# Tasker Knowledge Repo

A living knowledge base for Tasker (Android automation) that Claude Code accumulates over time. Use `/add-dir C:\Github\Tasker-Knowledge-Repo` from any Tasker project to access this knowledge.

## Entry Point

Always read `knowledge/_index.md` first. It lists every knowledge file with a one-line summary. Use it to find the right file before reading or editing.

## Knowledge Workflows

| Action | Trigger | What Happens |
|--------|---------|-------------|
| Add knowledge | "add knowledge" | Append a fact/technique to the right file |
| Find knowledge | "find knowledge" | Search the knowledge base, return summary with citations |
| Import session | "import session" | Parse unstructured content into multiple knowledge files |

For manual edits, follow the format in `knowledge/_conventions.md`.

## Cross-Repo Usage

From any Tasker project repo:
```
/add-dir C:\Github\Tasker-Knowledge-Repo
```
Then use the `tasker-expert` agent or "find knowledge" skill to query the knowledge base while working.

## Coding Standards

- Write clear, concise code. Prefer readability over cleverness.
- Use descriptive names for variables, functions, and files.
- Keep functions small and focused on a single responsibility.
- Handle errors explicitly -- never swallow exceptions silently.
- Validate inputs at system boundaries.
- Files over 500 lines should be split.
- Do not add comments for self-explanatory code.

## Hierarchical CLAUDE.md Architecture

- Root `CLAUDE.md` -- Project-wide rules (this file).
- `.claude/rules/*.md` -- Conditional instructions with `paths:` frontmatter. Only load when working with matching file paths.
- `knowledge-editing.md` loads for all `knowledge/**` edits.
- `xml-knowledge.md` loads for `knowledge/xml/**` edits.
- `plugin-knowledge.md` loads for `knowledge/plugins/**` edits.

## Subagent Usage

Always offload to subagents: online research, doc fetching, log analysis, codebase exploration.

- **Always include a "why"** in every subagent prompt.
- **Parallel exploration:** Spin up parallel Explore subagents when comparing approaches.
- **Subagents are resumable.**

## Skill Frontmatter

- `disable_model_invocation: true` -- Manual-only invocation.
- `model: haiku|sonnet|opus` -- Which model runs the skill.
- `context: fork` -- Run in isolated subagent context.
- `${CLAUDE_SKILL_DIR}` -- Reference the skill's own directory.

## Fixed Infrastructure

All projects use: **Cloudflare Pages** (frontend) + **Northflank** (backend, Postgres, Redis, cron) + **Cloudflare R2** (storage) + **Better Auth** + **Resend/SES** (email). See `.claude/references/infrastructure.md`.

## File Organization

- Skills: `.claude/skills/<skill-name>/SKILL.md`
- Agents: `.claude/agents/<agent-name>.md`
- Knowledge: `knowledge/<category>/<topic>.md`
- Source URLs: `.claude/references/source-urls.md`
- Settings: `.claude/settings.json` (version-controlled), `.claude/settings.local.json` (git-ignored)

## Available Skills

| Skill | Trigger | Purpose |
|-------|---------|---------|
| add-knowledge | "add knowledge" | Append Tasker knowledge to the right file |
| find-knowledge | "find knowledge" | Search knowledge base, return summary |
| import-session | "import session" | Parse unstructured content into knowledge files |
| plan-repo | "plan repo" | Research and recommend best tech stack |
| init-repo | "initialize repo" | Build or rebuild .claude/ folder |
| update-practices | "update practices" | Fetch latest best practices |
| spec-developer | "spec developer" | Interview-driven feature spec |
| code-review | "code review" | Full codebase review |
| security-scan | "security scan" | OWASP-style security audit |
| performance-review | "performance review" | Performance analysis |
| dependency-audit | "dependency audit" | Check dependencies |
| test-scaffold | "scaffold tests" | Generate test files |
| doc-sync | "sync docs" | Align docs with code |
| mermaid-diagram | "mermaid diagram" | Generate diagrams |

## Available Agents

See `agents.md` for the full registry. Key agents:

- **tasker-expert** -- answer Tasker questions from the knowledge base
- **architect** -- phase-based planning, tech stack decisions
- **reviewer** -- code review for correctness and maintainability
- **security** -- vulnerability detection and security analysis
- **performance** -- performance analysis and optimization
- **explorer** -- codebase exploration, research, context gathering

## Planning

- Phase-based, not timeline-based: Foundation, Core, Polish, Ship.
- Plan in one session, execute in another.
- Save plans to `/tasks`.

## Context Management

- Keep this file under 150 lines.
- Use `/compact` proactively around 50% context.
- Start fresh conversations for unrelated topics.
- Use `/handoff` before ending sessions.

## Workflow

1. Read existing code/knowledge before proposing changes.
2. Prefer editing existing files over creating new ones.
3. Do not over-engineer.
4. Use `.claude/references/source-urls.md` for best practice URLs.
5. Check `.claude/references/tools.md` for CLI tools before running commands.

## RULE 1 -- Check LL-G Before Scripting (MANDATORY)

**At the start of any session involving scripting, API calls, or automation -- before writing a single line -- fetch the LL-G index and load relevant entries.**

```
Step 1: Fetch https://raw.githubusercontent.com/wellforce-brandon/LL-G/main/llms.txt
Step 2: For each technology you will use, fetch its sub-index (e.g., kb/ninjaone/llms.txt)
Step 3: Read ALL HIGH-severity entries for those technologies
Step 4: Read any MEDIUM entry whose title matches your specific task
```

Technologies currently in LL-G: PowerShell, Graph API, NinjaOne, Next.js, Tailwind CSS, TypeScript, Godot/GDScript, Better Auth, Bash.

This applies to every session, every technician, every developer. Not optional.

### Contributing back

Every plan file MUST end with a **Lessons Learned / Gotchas** section. After implementation, route any new discoveries to LL-G -- not to local agent-memory or local pattern files only.

- Preferred: run `/add-lesson` from any session that has `C:\Github\LL-G` in context
- Manual: create `kb/<tech>/<slug>.md`, update `kb/<tech>/llms.txt`, update the master `llms.txt`

Lessons stored locally stay local. Lessons in LL-G benefit every repo and every technician.

## RULE 3 -- Check BP Before Starting New Work

**When onboarding a repo, starting a new feature, or setting up tooling -- load the BP index and check applicable best practices.**

```
Step 1: Fetch https://raw.githubusercontent.com/wellforce-brandon/BP/main/llms.txt
Step 2: For each concern relevant to your task, read its llms.txt index
Step 3: Load all FOUNDATIONAL entries (these apply to every repo)
Step 4: Load RECOMMENDED entries whose tech tags match the current project
```

BP is the complement to LL-G: where LL-G tracks what NOT to do, BP tracks what TO do.
