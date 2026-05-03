## Files

| File | Purpose |
|------|---------|
| [`AGENTS.md`](conventions/AGENTS.md) | Quick reference for LLM assistants |
| [`DEVELOPMENT.md`](conventions/DEVELOPMENT.md) | Comprehensive development rules (1.5~3k lines) |
| [`DEV-EXAMPLES.md`](conventions/DEV-EXAMPLES.md) | Concrete examples demonstrating conventions |
| [`SKILL.md`](conventions/SKILL.md) | Non-obvious conventions only |
| [`dev-conventions.sh`](conventions/dev-conventions.sh) | Unified CLI (changelog, sync, lint) |
| [`context.md`](conventions/context.md) | File index for conventions/ directory |
| [`src/lib.sh`](conventions/src/lib.sh) | Shared utilities |
| [`src/changelog.sh`](conventions/src/changelog.sh) | Changelog generation and merge workflow |
| [`src/sync.sh`](conventions/src/sync.sh) | Remote convention file syncing |
| [`src/lint.sh`](conventions/src/lint.sh) | Shell script linting and formatting |
| [`src/context.md`](conventions/src/context.md) | File index for src/ directory |

## Setup

1. Copy `conventions/` to a project root
2. Make the CLI executable: `chmod +x conventions/dev-conventions.sh`
3. Point agents at `AGENTS.md` or `DEVELOPMENT.md`
