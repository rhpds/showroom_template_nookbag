# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Showroom-based course on Claude Code Agent Skills**, built with [Antora](https://antora.org) and AsciiDoc. The course teaches how to create, use, and distribute Agent Skills for Claude Code across 5-6 progressive modules — from first skill usage through building a marketplace/plugin and orchestrating multi-skill workflows.

The repo was forked from `rhpds/showroom_template_nookbag` (the Red Hat Demo Platform Showroom template).

## Build & Preview

```bash
# Local preview with Podman (live reload, serves at http://localhost:8080)
podman run --rm --name antora -v $PWD:/antora -p 8080:8080 -i -t ghcr.io/juliaaano/antora-viewer

# SELinux systems: append :z to the volume mount
podman run --rm --name antora -v $PWD:/antora:z -p 8080:8080 -i -t ghcr.io/juliaaano/antora-viewer

# CI build (what GitHub Actions runs) — install Antora + extensions globally, then generate
npm i -g @antora/cli@3.1 @antora/site-generator@3.1 @sntke/antora-mermaid-extension@0.0.9 @antora/lunr-extension @andrew-jones/antora-tabs-extension
antora --fetch site.yml
# Output lands in ./www/
```

GitHub Actions deploys to GitHub Pages on push to `main` (only when `content/**`, `site.yml`, or the workflow file changes).

## Architecture

### Antora Site Structure

```
site.yml                          # Antora playbook — UI bundle, extensions, output dir
ui-config.yml                     # Showroom split-pane UI: tabs, layout width, view mode
content/
  antora.yml                      # Component descriptor: name, nav, AsciiDoc attributes
  modules/ROOT/
    nav.adoc                      # Sidebar navigation (xref links to pages)
    pages/                        # One .adoc file per page/module
    assets/images/                # Images referenced from pages
    examples/                     # Downloadable files (scripts, configs)
    partials/                     # Reusable AsciiDoc snippets (include::)
examples/
  demo/                           # Demo content templates and examples
  workshop/                       # Workshop content templates and examples
```

### Key Config Files

- **`site.yml`** — Antora playbook. Points to the RHDP UI bundle, enables Mermaid diagrams and tabs extensions. Output goes to `./www/`. Do not modify the UI bundle URL (CI overrides it for GH Pages).
- **`content/antora.yml`** — Component descriptor. The `asciidoc.attributes` section defines variables (guid, hostnames, credentials) that get injected at deploy time via `{attribute_name}` syntax in pages.
- **`ui-config.yml`** — Showroom UI layout. Controls split-pane width (`default_width`), view mode, and right-pane tabs (terminals, OCP console, external URLs).
- **`content/modules/ROOT/nav.adoc`** — Sidebar table of contents. Uses `xref:page.adoc[Title]` syntax. Group items under `.Section Title` headings.

### Antora Extensions

- `@sntke/antora-mermaid-extension` — renders Mermaid diagrams in-page
- `@andrew-jones/antora-tabs-extension` — tabbed content blocks in AsciiDoc
- `@antora/lunr-extension` — full-text search (CI-only, injected by workflow)

## AsciiDoc Conventions (Showroom)

- Use `role="execute"` on source blocks to get a copy button in the Showroom UI
- Use `link=self` (no `window=blank`) for lightbox popout on images/SVGs
- No trailing period after credential examples
- No blank line after `====` admonition delimiter (breaks attribute substitution)
- Pre-render Mermaid as SVGs for split-panel readability
- Variables use Antora attribute injection: `{guid}`, `{bastion_public_hostname}`, etc. defined in `content/antora.yml`

## Course Structure (Planned)

The course content lives in `content/modules/ROOT/pages/`. Modules build progressively:

1. **Introduction to Agent Skills** — history, installing skills, implicit vs explicit triggering (`/command`)
2. **Creating Your First Skill** — skill anatomy (frontmatter, progressive disclosure), using `skill-creator`, building `abstract-writer`
3. **More Advanced Skills** — skill-creator from Anthropic marketplace, building `conf-finder`
4. **Marketplaces and Namespacing** — bundling related skills into a plugin/marketplace, creating a git repo marketplace, adding `trip-report`
5. **The Full Monty** — layered skills: superpowers harness + beads + third-party marketplace in a cohesive lab
6. **Bonus: Programmatic Skills** — skills in Deep Agents (outliner + researcher + reviewer), skills calling skills (validator pattern)

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
<!-- END BEADS INTEGRATION -->
