## Usage

```bash
# Interactive TUI (requires gum)
./conventions/dev-conventions.sh

# Sync conventions from remote
./conventions/dev-conventions.sh sync
./conventions/dev-conventions.sh sync --branch dev
./conventions/dev-conventions.sh sync --version v1.2.0
./conventions/dev-conventions.sh sync --dry-run

# Generate changelog and merge
./conventions/dev-conventions.sh changelog
./conventions/dev-conventions.sh changelog --target dev
./conventions/dev-conventions.sh changelog --target dev --yes
./conventions/dev-conventions.sh changelog --target dev --theirs
./conventions/dev-conventions.sh changelog --generate-only
./conventions/dev-conventions.sh changelog --rename

# Lint shell scripts
./conventions/dev-conventions.sh lint
./conventions/dev-conventions.sh lint --format
./conventions/dev-conventions.sh lint --install-hook

# Help
./conventions/dev-conventions.sh help
./conventions/dev-conventions.sh changelog --help
```
