---
name: dev-mini
description: Non-obvious development conventions for naming, repo structure, vocabulary, and workflow. Acknowledge in context and stop; do not proceed to action in the same turn. Use when starting tasks, naming files, or committing code.
---

# DEV-MINI

Purpose: Non-obvious conventions only. Assumes standard SWE practices. Principles: KISS, DRY, SoC, SRP, CoC. Vocabulary: Rule 21 in conventions/DEVELOPMENT.md.

## Naming

- Directories: `snake_case/`
- Files: `kebab-case.ext`
- Exceptions: ecosystem-mandated (`package.json`, `flake.nix`)

## Structure

- Max 6 levels deep from repo root (monorepo: from app root)
- Every module must be imported somewhere (wire in on create, remove refs before delete)
- Add `context.md` to folders with 5+ non-obvious files: one bullet per file, present-tense, no subdirectory entries (those get their own). Update in the same commit as any file addition, removal, or rename, treat drift as broken.
- **Single source of truth:** context.md entries derive from file header `Purpose:` lines. Files in context.md must have headers. The drift check validates both structure and content.
- **SoC:** One concern per directory. No catch-all dirs (`misc/`,
  `helpers/`). If a dir name doesn't declare a concern, rename or
  restructure.
- **SRP:** One reason to change per file. If two unrelated changes land in
  the same file across separate commits, split it.
- **CoC:** Conventions here are structural, not cosmetic. Follow by
  default; deviate only with documented reason.
- Files approaching 800–1000 lines: consider splitting by role (domain subdirs like `auth/login.nix`, `auth/tokens.nix`) or layer (layer subdirs like `api/types.ts`, `api/handlers.ts`). Existing structure rules (depth, wiring, context.md, headers) still apply. Scope: project source code only, not convention docs.

## Vocabulary

Prefer established terms when describing repo structure. Quick reference:

- **Domain**, bounded area of concern
- **Subdomain**, narrower concern within a domain
- **Bounded Context**, a deployable unit's scope, its own rules, its own reality
- **Context Boundary**, seam where unit-specific config meets shared config
- **Shared Kernel**, code no single domain owns but multiple use
- **Anti-Corruption Layer**, normalizes raw inputs before the rest of the system sees them
- **Factory**, constructs valid, complete objects from inputs
- **Entity**, a thing with identity, distinguished from others of its kind
- **Value Object**, a pure value, no identity, swappable and reusable
- **Aggregate**, pulls all parts of one entity into a coherent whole
- **Aggregate Root**, single entry point everything resolves through
- **Policy**, named rule set applied to entities
- **Specification**, defines what it means to satisfy a named policy
- **Strategy**, per-entity override of shared behavior; same interface, different implementation
- **Detached Instance**, a unit that opted out of shared behavior; owns its copy
- **Ubiquitous Language**, this vocabulary; full definitions at Rule 21 in conventions/DEVELOPMENT.md

**Repo-specific mapping:** Do not embed project paths here. Map terms to
your repo's actual structure in your root `context.md` under a
`## Vocabulary` section.

## Comments & Docs

- Discourage comments unless requested. Only keep: rationale, warnings, external refs
- No function docs unless requested
- No markdown docs unless requested
- Duplicate facts inline over cross-references
- No time markers ("as of 2024"), no priority markers
- Informed over assumed, qualify unverified claims ("untested", "theoretical"). Avoid filling gaps with assumed mechanisms unless trivial.
- When docs are warranted, use HTML5 `<details>/<summary>` for collapsible sections: `<details>` (collapsed by default), `<details open>` for priority sections. Prefer bullets over tables inside details.
- One topic per line, split dense paragraphs at idea boundaries. Conjunctive chains (and, then, also) signal separate lines.

## Tone

**Style:**
- No first-person ("I", "we") in code, comments, or commits
- No emoticons unless requested. Prefer Unicode symbols over emojis (✓ ✗ →, not ✅ ❌ 🚀)
- No em dashes, use commas or sentence separation
- Abbreviate: config, repo, temp, init
- No scare quotes on normal words, quotation marks only for actual quotations from a named source

**Words to avoid (full reference at DEVELOPMENT.md §16):**
- Intensifiers: extremely, dramatically, significantly, very, prove with a fact or cut
- AI verbs: leverage, utilize, facilitate, delve, bolster, underscore, streamline, use plain equivalents (use, help, explore, strengthen, highlight, simplify)
- AI adjectives: robust, comprehensive, pivotal, seamless, cutting-edge, innovative, use plain equivalents (strong, complete, key, smooth, new, original)
- AI transitions: Furthermore, Moreover, That being said, In essence, use plain connectors (also, and, but, however)
- Academic tells: shed light on, pave the way, myriad, plethora, paramount, in light of, use plain equivalents
- Metaphorical nouns: tapestry, symphony, beacon, realm, testament, literal uses only
- Filler phrases: "In today's world", "It's important to note", "When it comes to", "Let's dive in", open on the fact
- Weasel words: may potentially, helps ensure, can potentially, commit or cut
- Hallucinated markup: oaicite, contentReference, grok_card, turn0search0, zero tolerance

**Content:**
- No hollow statements: every claim ends on a concrete, verifiable detail
- No unsourced statistics: every number real and attributable; cut it if not
- No fabricated facts: never invent case studies, dates, milestones, or attributions. No research-process narration or "as of [date]" qualifiers, cut unsupported facts silently
- Quote accurately: match source exactly. Set off long quotes (>15 words) as indented blocks
- Root-cause differentiation: when contrasting, name the concrete difference (the part, the version, the date, the mechanism), do not imply a difference without it

**Structure:**
- No dramatic or narrative headings: name the content, do not tease it. No parenthetical asides inside headings
- No synthetic enthusiasm: no exclamation marks or cheerleading
- No performative urgency without a concrete consequence
- Never start a sentence with "Whether you're"
- No repeated talking points. Vary structure, break identical section shapes
- Reference without narrating: no "as discussed above" or "as we will see"
- Hedging threshold: more than three epistemic hedges ("may", "might", "potentially") in a declarative paragraph is a red flag

## File Headers

Essential. When used:
```
# <File Name>
#
# Purpose: <One-line present-tense intent>
#
# This module:
# - <Verb-led responsibility>
```

No dependency or relationship tracking in headers. Use inline comments at relevant code locations for critical relationships.

## Agent Interaction

One-shot commands: wrap output for `wl-copy` so it can be sent in one shot.
- Fish: `begin; <cmds>; end | wl-copy`
- Bash: `{ <cmds>; } | wl-copy`
- Use `begin; end` not `{ }` in fish. Use `$status` not `$?`.
- Always `--no-pager` on systemctl/journalctl. Use `timeout N` on blocking commands.
- Prefer `rg` (ripgrep) when available; fallback to `grep -r` if uncertain.
- Systemd is not universal, BSD, macOS, non-systemd Linux won't have `systemctl`. Don't assume it exists; check with `command -v systemctl` or skip if it errors.

## Commits

```
<type>(scope): <verb> <summary>
```

- Types: `feat` `fix` `refactor` `docs` `style` `test` `chore` `perf` `revert`
- Scope: basename, lowercase, max 3 words
- Summary: imperative, lowercase start, no period, max 72 chars
- Single-line only
- Append `[untested]` if validation skipped
- Append `[skip-check]` if intentionally bypassing checks

## Commit Workflow

- Stay in current branch unless explicitly told otherwise
- Commit iteratively (open-loop), squash after validation
- Squash only on experimental branches, never on shared branches
- Stage before Nix flake commands (`git add --intent-to-add .`)

## Context Recovery

When the next user message after convention-loading is an action command
(proceed, apply, go, continue, changes) with no explicit task description,
investigate before asking for clarification:
- `git stash list`, WIP stashes may describe pending work
- `git status`, uncommitted changes in the working tree
- `git log --oneline -5`, recent commit messages for related work
- Project `AGENTS.md` or root `context.md` for task cues

## Validation

- Ask before running `nix flake check` (resource-intensive, CI typically handles it)
- Never commit failing checks without `[skip-check]` flag and documented reason
