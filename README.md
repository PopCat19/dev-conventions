# Dev Conventions

Personal, language-agnostic development conventions for LLM agents.

## Overview

This repository contains opinionated development rules and conventions designed to be referenced by LLM agents. Copy the contents (except this README) to any project, and encourage agents to fetch [`AGENTS.md`](AGENTS.md) or [`DEVELOPMENT.md`](DEVELOPMENT.md) into context to take effect.

## Files

| File | Purpose |
|------|---------|
| [`AGENTS.md`](AGENTS.md) | Quick reference for LLM assistants working with this repository |
| [`DEVELOPMENT.md`](DEVELOPMENT.md) | Comprehensive development rules and conventions (1.5~3k lines) |
| [`DEV-EXAMPLES.md`](DEV-EXAMPLES.md) | Concrete examples demonstrating conventions in practice |
| [`generate-changelog.sh`](generate-changelog.sh) | Script for generating changelogs from git history |

## Usage

### For New Projects

1. Copy `AGENTS.md`, `DEVELOPMENT.md`, `DEV-EXAMPLES.md`, and `generate-changelog.sh` to your project root
2. Instruct your LLM agent to read `AGENTS.md` or `DEVELOPMENT.md` into context
3. The conventions will guide the agent's code generation and project structure

### For Existing Projects

Add a reference in your project's instructions:

```markdown
# Project Instructions

Before making changes, read and follow the conventions in DEVELOPMENT.md.
```

## Topics Covered

- File headers and code style (Nix, Fish, Python, Bash, Rust, Go, TypeScript)
- Naming conventions and project structure
- Comments, navigation, and file hygiene
- DRY refactoring patterns
- Commit message format and workflow
- Documentation guidelines
- Validation and CI/CD configuration
- Core principles (KISS, DRY, maintainable over clever)

## Principles

- **KISS:** Keep It Simple, Stupid
- **DRY:** Don't Repeat Yourself
- **Maintainable over clever:** Code is read 10x more than written
- **Lazy optimization:** Reduce manual maintenance needs where critical
