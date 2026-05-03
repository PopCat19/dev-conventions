#!/usr/bin/env bash

# generate-readme.sh
#
# Purpose: Concatenate readme fragments into README.md
#
# This module:
# - Reads fragments from readme_manifest/ in numeric order
# - Writes combined output to README.md

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST_DIR="$REPO_ROOT/readme_manifest"
OUTPUT="$REPO_ROOT/README.md"

{
  hash="$(git -C "$REPO_ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  date="$(date -u +%Y%m%d)"

  for fragment in "$MANIFEST_DIR"/*.md; do
    cat "$fragment"
    echo
  done

  echo "<!-- generated: ${date}-${hash} -->"
} > "$OUTPUT"

echo "Generated $OUTPUT from $MANIFEST_DIR"
