#!/usr/bin/env bash
#
# bulk-conventions.sh
#
# Purpose: Execute dev-conventions commands across multiple repositories
#
# This script:
# - Finds all instances of dev-conventions.sh under a root directory
# - Filters targets by inclusion/exclusion patterns
# - Displays affected repositories and waits for a 10s countdown
# - Executes the specified command in each target directory
#
# Usage:
#   ./bulk-conventions.sh [options] <command> [command-args]
#
# Options:
#   --root DIR       Root directory to search (default: .)
#   --include PAT    Regex pattern for directories to include
#   --exclude PAT    Regex pattern for directories to exclude
#   --yes, -y        Skip countdown
#
# Examples:
#   ./bulk-conventions.sh sync --push
#   ./bulk-conventions.sh --include "popcat" sync
#   ./bulk-conventions.sh --exclude "legacy" lint --format

set -Eeuo pipefail

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_SH="${SCRIPT_DIR}/conventions/src/lib.sh"

# Source library for logging and colors if available
if [[ -f "$LIB_SH" ]]; then
	# shellcheck disable=SC1091
	source "$LIB_SH"
else
	# Fallback colors and logging
	ANSI_CLEAR='\033[0m'
	ANSI_GREEN='\033[1;32m'
	ANSI_YELLOW='\033[1;33m'
	ANSI_RED='\033[1;31'
	ANSI_CYAN='\033[1;36m'
	log_info() { printf "${ANSI_GREEN}  → %s${ANSI_CLEAR}\n" "$1"; }
	log_warn() { printf "${ANSI_YELLOW}  ⚠ %s${ANSI_CLEAR}\n" "$1"; }
	log_error() { printf "${ANSI_RED}  ✗ %s${ANSI_CLEAR}\n" "$1"; }
	log_success() { printf "${ANSI_GREEN}  ✓ %s${ANSI_CLEAR}\n" "$1"; }
fi

# Defaults
ROOT_DIR=""
INCLUDE_PAT=""
EXCLUDE_PAT=""
SKIP_COUNTDOWN=false
COMMAND_ARGS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
	case "$1" in
	--root)
		ROOT_DIR="$2"
		shift 2
		;;
	--include)
		INCLUDE_PAT="$2"
		shift 2
		;;
	--exclude)
		EXCLUDE_PAT="$2"
		shift 2
		;;
	--yes | -y)
		SKIP_COUNTDOWN=true
		shift
		;;
	--help | -h)
		echo "Usage: $0 [options] <command> [command-args]"
		echo ""
		echo "Options:"
		echo "  --root DIR       Root directory to search (default: .)"
		echo "  --include PAT    Regex pattern for directories to include"
		echo "  --exclude PAT    Regex pattern for directories to exclude"
		echo "  --yes, -y        Skip countdown"
		exit 0
		;;
	*)
		COMMAND_ARGS+=("$1")
		shift
		;;
	esac
done

if [[ -z "$ROOT_DIR" ]]; then
	log_error "Root directory (--root) must be explicitly specified."
	echo "Usage: $0 --root <DIR> [options] <command> [command-args]"
	exit 1
fi

# Expand ~/ if present
if [[ "$ROOT_DIR" == "~/"* ]]; then
	ROOT_DIR="${HOME}/${ROOT_DIR#\~/}"
elif [[ "$ROOT_DIR" == "~" ]]; then
	ROOT_DIR="${HOME}"
fi

# Warn about the root directory
log_warn "Target root directory set to: $ROOT_DIR"
if [[ "$ROOT_DIR" == "$HOME" || "$ROOT_DIR" == "/" ]]; then
	log_warn "Caution: Operating on a very broad scope ($ROOT_DIR)"
fi

if [[ ${#COMMAND_ARGS[@]} -eq 0 ]]; then
	log_error "No command provided."
	echo "Usage: $0 --root <DIR> [options] <command> [command-args]"
	exit 1
fi

log_info "Searching for dev-conventions.sh in $ROOT_DIR..."
# Avoid .git directories and the current script's own location if it's in the search path
mapfile -t FOUND_SCRIPTS < <(find "$ROOT_DIR" -name "dev-conventions.sh" -not -path "*/.git/*" -type f)

TARGETS=()
for script in "${FOUND_SCRIPTS[@]}"; do
	# Get directory containing the script
	script_dir="$(dirname "$script")"
	# Get relative path from root for filtering
	rel_path="${script_dir#$ROOT_DIR/}"
	[[ "$rel_path" == "$script_dir" ]] && rel_path="."

	# Filter by include
	if [[ -n "$INCLUDE_PAT" ]] && [[ ! "$rel_path" =~ $INCLUDE_PAT ]]; then
		continue
	fi

	# Filter by exclude
	if [[ -n "$EXCLUDE_PAT" ]] && [[ "$rel_path" =~ $EXCLUDE_PAT ]]; then
		continue
	fi

	# Get absolute path for execution
	abs_dir="$(cd "$script_dir" && pwd)"
	TARGETS+=("$abs_dir")
done

if [[ ${#TARGETS[@]} -eq 0 ]]; then
	log_warn "No targets found matching criteria."
	exit 0
fi

echo ""
log_info "The following repositories/directories will be affected:"
for target in "${TARGETS[@]}"; do
	printf "  ${ANSI_CYAN}- %s${ANSI_CLEAR}\n" "$target"
done
echo ""
log_info "Command to run: dev-conventions.sh ${COMMAND_ARGS[*]}"
echo ""

if [[ "$SKIP_COUNTDOWN" == "false" ]]; then
	printf "${ANSI_YELLOW}Starting bulk operation in: ${ANSI_CLEAR}"
	for i in {10..1}; do
		printf "${ANSI_YELLOW}%s... ${ANSI_CLEAR}" "$i"
		sleep 1
	done
	echo "0!"
fi

SUCCESS_COUNT=0
FAILURE_COUNT=0

for target_dir in "${TARGETS[@]}"; do
	echo ""
	log_info ">>> Executing in: $target_dir"
	
	if (cd "$target_dir" && ./dev-conventions.sh "${COMMAND_ARGS[@]}"); then
		log_success "Completed: $target_dir"
		SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
	else
		log_error "Failed: $target_dir"
		FAILURE_COUNT=$((FAILURE_COUNT + 1))
	fi
done

echo ""
if [[ $FAILURE_COUNT -eq 0 ]]; then
	log_success "Bulk operation complete. Successfully processed $SUCCESS_COUNT targets."
else
	log_warn "Bulk operation finished with errors."
	log_detail "Success: $SUCCESS_COUNT"
	log_error "Failures: $FAILURE_COUNT"
	exit 1
fi
