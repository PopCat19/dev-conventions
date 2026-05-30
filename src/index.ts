// dev-conventions extension
// Injects a condensed dev-mini conventions nudge into every turn.
// Full conventions load on-demand via the skill.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const NUDGE = `
## Dev-Mini Conventions (active this session)

Follow these structural rules. Load /skill:dev-mini for full detail.

- Directories: snake_case. Files: kebab-case.ext.
- Max 6 levels deep from repo root.
- Every module must be imported somewhere — wire in on create, remove refs before delete.
- context.md in folders with 5+ non-obvious files. Update in same commit as file changes.
- One concern per directory. No catch-all dirs (misc/, helpers/).
- One reason to change per file. Split at ~800-1000 lines.
- Headers: every file in context.md must have a Purpose line.
- No comments unless rationale, warning, or external ref.
- Commits: type(scope): verb summary — single line, imperative, lowercase, no period.

Vocabulary: snake_case dirs, kebab-case files, domain, subdomain, bounded context, shared kernel, aggregate root, entity, value object, policy, specification, strategy. Full definitions: conventions/DEVELOPMENT.md §21.`;

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", async (event, _ctx) => {
    return {
      systemPrompt: (event.systemPrompt ?? "") + NUDGE,
    };
  });
}
