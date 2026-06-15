// dev-conventions extension
// Injects a condensed dev-mini conventions nudge into every turn.
// Full conventions load on-demand via the skill.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const NUDGE = `
## Dev-Mini Conventions

Follow these structural rules. Load /skill:dev-mini for full detail.

- Directories: snake_case. Files: kebab-case.ext.
- Max 6 levels deep from repo root.
- Every module must be imported somewhere, wire in on create, remove refs before delete.
- context.md in folders with 5+ non-obvious files. Update in same commit as file changes.
- One concern per directory. No catch-all dirs (misc/, helpers/).
- One reason to change per file. Split at ~800-1000 lines.
- Headers: every file in context.md must have a Purpose line.
- No comments unless rationale, warning, or external ref.
- Commits: type(scope): verb summary, single line, imperative, lowercase, no period.

Vocabulary: snake_case dirs, kebab-case files, domain, subdomain, bounded context, shared kernel, aggregate root, entity, value object, policy, specification, strategy. Full definitions: conventions/DEVELOPMENT.md §21.

Communication (full rules: conventions/DEVELOPMENT.md §16):

- No first-person, no emoticons. Unicode symbols over emojis (✓ ✗ →, not ✅ ❌ 🚀).
- No em dashes. Abbreviate: config, repo, temp, init.
- Banned: intensifiers (very, extremely), AI verbs (leverage, utilize, delve), AI adjectives (robust, seamless), AI transitions (Furthermore, Moreover), academic tells (shed light on, myriad), metaphorical nouns (tapestry, beacon, literal only).
- Banned filler: "In today's world", "It's important to note", "Let's dive in". Open on the fact.
- No weasel words (may potentially, can potentially). Commit or cut.
- No hollow statements: every claim ends on a concrete, verifiable detail.
- No unsourced statistics or fabricated facts. No research-process narration or "as of [date]" qualifiers.
- Quote accurately. Root-cause differentiation: when contrasting, name the concrete difference.
- No dramatic/narrative headings. No parenthetical asides in headings. No synthetic enthusiasm.
- Never start with "Whether you're". Varied structure. No repeated points.
- Hedging threshold: >3 epistemic hedges (may/might/potentially) per declarative paragraph is a red flag.`;

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", async (event, _ctx) => {
    return {
      systemPrompt: (event.systemPrompt ?? "") + NUDGE,
    };
  });
}
