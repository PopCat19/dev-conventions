# AGENTS.md

## Project overview

Language-agnostic development conventions for LLM agents. The `conventions/` directory is designed to be copied into any project to provide consistent coding standards.

Read `README.md` for the human-facing overview. See `conventions/DEVELOPMENT.md` for the full rule set.

## README workflow

The README is generated from fragments. Edit `readme_manifest/*.md`, then run:

```bash
bash tools/generate-readme.sh
```

## Conventions this repo follows

The repo is self-documenting via the same conventions it defines:

- Module headers (`Purpose:` blocks) serve as in-code documentation
- `context.md` files index each directory with 5+ files
- No em dashes - commas, hyphens, or sentence splits
- Unicode symbols over emojis - `✓ ✗` not `✅ ❌`
- One topic per line - split dense paragraphs at idea boundaries
- Informed over assumed - qualify unverified claims

## Guarded files

Do not revise without explicit request:

- `conventions/DEVELOPMENT.md`, `conventions/SKILL.md`, `conventions/DEV-EXAMPLES.md`
- `conventions/src/*.sh`
- `readme_manifest/*.md`
