# Claude Code Agent Skills Course — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a 6-module self-paced Showroom course teaching Claude Code Agent Skills — from first use through marketplace creation and multi-layer workflows.

**Architecture:** Antora site with AsciiDoc content pages. One `.adoc` file per module plus a hub index. Config files updated for course identity. Exercises follow a conference-speaking theme (abstract-writer, conf-finder, trip-report). Module 6 is a stub.

**Tech Stack:** Antora 3.1, AsciiDoc, RHDP Showroom UI bundle, Mermaid diagrams, tabs extension

---

## File Map

### Files to Create
- `content/modules/ROOT/pages/index.adoc` — Course overview hub (replaces existing)
- `content/modules/ROOT/pages/01-introduction.adoc` — Module 1
- `content/modules/ROOT/pages/02-first-skill.adoc` — Module 2
- `content/modules/ROOT/pages/03-advanced-skills.adoc` — Module 3
- `content/modules/ROOT/pages/04-marketplaces.adoc` — Module 4
- `content/modules/ROOT/pages/05-full-monty.adoc` — Module 5
- `content/modules/ROOT/pages/06-bonus-programmatic.adoc` — Module 6 stub

### Files to Modify
- `content/antora.yml` — Update title, strip infrastructure attributes
- `site.yml` — Update site title
- `ui-config.yml` — Remove terminal tabs, update for docs-only mode
- `content/modules/ROOT/nav.adoc` — Replace with course navigation

### Files to Remove
- `content/modules/ROOT/pages/agnosticv-config.adoc`
- `content/modules/ROOT/pages/architecture.adoc`
- `content/modules/ROOT/pages/attribute-example.adoc`
- `content/modules/ROOT/pages/content-repo.adoc`
- `content/modules/ROOT/pages/contributing.adoc`
- `content/modules/ROOT/pages/deployer.adoc`
- `content/modules/ROOT/pages/images.adoc`
- `content/modules/ROOT/pages/nookbag.adoc`
- `content/modules/ROOT/pages/ocp-integration.adoc`
- `content/modules/ROOT/pages/ocp4-role-reference.adoc`
- `content/modules/ROOT/pages/quick-start.adoc`
- `content/modules/ROOT/pages/ui-config.adoc`
- `content/modules/ROOT/pages/user-data.adoc`
- `content/modules/ROOT/pages/vm-role-reference.adoc`

---

## AsciiDoc Conventions (all content tasks)

Every module page MUST follow these Showroom conventions:
- `role="execute"` on source blocks for copy button: `[source,bash,role="execute"]`
- `link=self` on images for lightbox popout (no `window=blank`)
- No trailing period after credential/path examples
- No blank line after `====` admonition delimiter
- Use `{attribute_name}` for Antora variable injection
- Pre-render Mermaid as SVGs when used in split-panel mode
- Use tabs extension for side-by-side comparisons: `[tabs]` blocks

Each module follows the pattern:
1. Section intro — what and why
2. Concept explanation — just enough theory
3. Guided exercise — step-by-step with `role="execute"` blocks
4. Verification — confirm it works
5. Summary — recap and what's next

---

### Task 1: Scaffold — Config Updates, Remove Old Pages, New Nav

**Files:**
- Modify: `content/antora.yml`
- Modify: `site.yml`
- Modify: `ui-config.yml`
- Modify: `content/modules/ROOT/nav.adoc`
- Remove: 14 old template pages (listed in File Map above)

- [ ] **Step 1: Update `content/antora.yml`**

Replace the full file with:

```yaml
name: modules
title: Claude Code Agent Skills
version: ~
nav:
  - modules/ROOT/nav.adoc

asciidoc:
  attributes:
    experimental: true
    page-pagination: true
```

This strips all bastion/OCP/SSH attributes (not needed — exercises run on the learner's local machine) and sets the course title.

- [ ] **Step 2: Update `site.yml`**

Change only the `title` field:

```yaml
site:
  title: Claude Code Agent Skills
  url: https://github.com/rhpds/showroom_template_nookbag
  start_page: modules::index.adoc
```

Leave everything else (content sources, UI bundle, extensions, output dir) unchanged.

- [ ] **Step 3: Update `ui-config.yml`**

Replace with docs-only configuration:

```yaml
---
type: showroom

default_width: 50
persist_url_state: true

view_switcher:
  enabled: true
  default_mode: split

tabs:
  - name: Skills Docs
    url: 'https://code.claude.com/docs/en/skills'
```

Changes: wider content pane (50% for readability), single tab pointing to Anthropic's skills docs as a reference companion.

- [ ] **Step 4: Replace `content/modules/ROOT/nav.adoc`**

Replace the full file with:

```asciidoc
* xref:index.adoc[Course Overview]

.Modules
* xref:01-introduction.adoc[1. Introduction to Agent Skills]
* xref:02-first-skill.adoc[2. Creating Your First Skill]
* xref:03-advanced-skills.adoc[3. Advanced Skills with skill-creator]
* xref:04-marketplaces.adoc[4. Marketplaces and Plugins]
* xref:05-full-monty.adoc[5. The Full Monty]
* xref:06-bonus-programmatic.adoc[6. Bonus: Programmatic Skills]
```

- [ ] **Step 5: Remove old template pages**

```bash
rm -f content/modules/ROOT/pages/agnosticv-config.adoc \
      content/modules/ROOT/pages/architecture.adoc \
      content/modules/ROOT/pages/attribute-example.adoc \
      content/modules/ROOT/pages/content-repo.adoc \
      content/modules/ROOT/pages/contributing.adoc \
      content/modules/ROOT/pages/deployer.adoc \
      content/modules/ROOT/pages/images.adoc \
      content/modules/ROOT/pages/nookbag.adoc \
      content/modules/ROOT/pages/ocp-integration.adoc \
      content/modules/ROOT/pages/ocp4-role-reference.adoc \
      content/modules/ROOT/pages/quick-start.adoc \
      content/modules/ROOT/pages/ui-config.adoc \
      content/modules/ROOT/pages/user-data.adoc \
      content/modules/ROOT/pages/vm-role-reference.adoc
```

Keep `index.adoc` — it will be overwritten in Task 2.

- [ ] **Step 6: Verify only index.adoc remains**

```bash
ls content/modules/ROOT/pages/
```

Expected: `index.adoc` only.

- [ ] **Step 7: Commit scaffold**

```bash
git add -A content/modules/ROOT/pages/ content/antora.yml site.yml ui-config.yml content/modules/ROOT/nav.adoc
git commit -m "scaffold: strip template docs, update config for skills course"
```

---

### Task 2: Write `index.adoc` — Course Overview Hub

**Files:**
- Create (overwrite): `content/modules/ROOT/pages/index.adoc`

This is the landing page. It replaces the Showroom template "What is Showroom?" page.

- [ ] **Step 1: Write `index.adoc`**

The page must contain these sections in order:

**Title and intro:**
```asciidoc
= Claude Code Agent Skills
:navtitle: Course Overview
```

One paragraph: This course teaches you to create, distribute, and compose Agent Skills for Claude Code. By the end you'll have built three skills, bundled them into a distributable marketplace, and used them in a multi-layer workflow alongside harness and workflow skills.

**Prerequisites callout:**
```asciidoc
[IMPORTANT]
====
Before starting, ensure you have:

* Claude Code installed and working (`claude --version`)
* An Anthropic API key configured
* A GitHub account (for Module 4)
* Basic comfort with the terminal and git
====
```

**What you'll build:** Brief description of the conference-toolkit — three skills (abstract-writer for drafting talk abstracts, conf-finder for discovering conferences, trip-report for post-conference writeups) that you'll eventually bundle into a marketplace.

**Module map:** Numbered list of all 6 modules with 1-2 sentence descriptions and xref links to each. Example format:
```asciidoc
. xref:01-introduction.adoc[Introduction to Agent Skills] — What skills are, where they live, and how to use one from the Anthropic marketplace.
```

**Cross-reference note:** A short note mentioning that Cursor equivalents (`.cursorrules`) will be called out where relevant throughout the course.

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/index.adoc
git commit -m "content: add course overview index page"
```

---

### Task 3: Write `01-introduction.adoc` — Module 1

**Files:**
- Create: `content/modules/ROOT/pages/01-introduction.adoc`

**Key reference:** The current Claude Code skills documentation defines skills as directories containing a `SKILL.md` file with YAML frontmatter (`name`, `description`) and markdown body instructions. Read https://code.claude.com/docs/en/skills for authoritative details.

- [ ] **Step 1: Write the module**

The page must contain these sections:

**Title:**
```asciidoc
= Introduction to Agent Skills
:navtitle: 1. Introduction to Agent Skills
```

**Section: What are Agent Skills?**

Explain skills as reusable instruction sets packaged as `SKILL.md` files that shape how Claude Code behaves. Cover:
- Skills vs. system prompts: skills are modular and composable; system prompts are monolithic
- Skills vs. MCP servers: MCP provides tools (external capabilities); skills provide behavioral instructions
- Skills vs. Projects: Projects are Claude.ai-specific; skills work in Claude Code CLI
- Brief history: the concept evolved from Cursor's `.cursorrules` (single file, project-scoped) to Claude Code's `SKILL.md` convention (directory-based, multi-scope, marketplace-distributable)

**Section: Where Skills Live**

Explain the skill resolution hierarchy with a diagram or table:
```asciidoc
[cols="1,2,2",options="header"]
|===
|Scope |Location |Use when...

|Global (user)
|`~/.claude/skills/<skill-name>/SKILL.md`
|You want the skill available in every project

|Project
|`.claude/skills/<skill-name>/SKILL.md`
|The skill is specific to this codebase (committed to git)

|Plugin/Marketplace
|Installed via `claude plugin install`
|The skill comes from a shared collection
|===
```

Explain precedence: project-level skills override global; explicitly triggered skills (`/skill-name`) override implicit activation.

**Section: Using Your First Skill**

Guided exercise: install a skill from Anthropic's official marketplace. Use `brand-guidelines` as the example (it's lightweight and visual).

Step-by-step:
1. List available marketplaces:
```asciidoc
[source,bash,role="execute"]
----
claude plugin marketplace list
----
```

2. Install the skill:
```asciidoc
[source,bash,role="execute"]
----
claude plugin install brand-guidelines@claude-plugins-official
----
```

3. Implicit trigger — show a prompt that naturally activates the skill (e.g., "review these colors for brand consistency"):
```asciidoc
[source,text]
----
> review these colors for brand consistency: #FF6B35 and #004E89
----
```

4. Explicit trigger — use the slash command:
```asciidoc
[source,text]
----
> /brand-guidelines check the hero section colors
----
```

5. Observe the difference — explain what changed in Claude's behavior (it now references brand guidelines, checks against a palette).

6. Verify the skill is installed:
```asciidoc
[source,bash,role="execute"]
----
ls ~/.claude/plugins/
----
```

**Section: Cursor Cross-Reference**

Short sidebar or admonition:
```asciidoc
[NOTE]
.Coming from Cursor?
====
Cursor uses `.cursorrules` files — a single markdown file at the project root that influences Cursor's AI behavior. Claude Code skills are conceptually similar but more powerful:

* *Directory-based* — a skill can include templates, scripts, and reference files alongside its instructions
* *Multi-scope* — global, project, or marketplace-distributed
* *Composable* — multiple skills activate simultaneously without conflicting
* *Namespaced* — skills from different sources coexist cleanly
====
```

**Section: Summary**

Recap the three key concepts: skills are instruction files, they live in a scope hierarchy, and they activate implicitly or explicitly. Tease Module 2: "Next, you'll build your own skill from scratch."

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/01-introduction.adoc
git commit -m "content: add Module 1 — Introduction to Agent Skills"
```

---

### Task 4: Write `02-first-skill.adoc` — Module 2

**Files:**
- Create: `content/modules/ROOT/pages/02-first-skill.adoc`

**Key reference:** A skill directory contains `SKILL.md` with YAML frontmatter (`name`, `description`) and markdown body. Optional: additional files (templates, scripts, reference docs). See https://code.claude.com/docs/en/skills.

- [ ] **Step 1: Write the module**

**Title:**
```asciidoc
= Creating Your First Skill
:navtitle: 2. Creating Your First Skill
```

**Section: Skill Anatomy**

Detailed breakdown of a `SKILL.md` file:

Frontmatter fields:
- `name` — becomes the `/slash-command` and identifies the skill
- `description` — Claude reads this to decide whether to activate the skill automatically. This is the most important field for implicit triggering. A good description is specific enough to trigger on relevant requests but not so broad it triggers on everything.
- `allowed-tools` (optional) — restrict which tools the skill can use
- `disable-model-invocation` (optional) — for pure data/template skills

Show a minimal example:
```yaml
---
name: abstract-writer
description: Generate conference talk abstracts tailored to specific conferences. Use when the user wants to write, draft, or improve a conference talk abstract, CFP submission, or speaking proposal.
---
```

Body content: markdown instructions that Claude follows when the skill activates. These are the behavioral instructions — what to do, what format to use, what constraints to follow.

Directory structure:
```
~/.claude/skills/abstract-writer/
├── SKILL.md
├── templates/
│   ├── lightning-talk.md
│   └── full-session.md
└── examples/
    └── sample-abstract.md
```

**Section: Progressive Disclosure**

Explain the two-phase loading model:
1. **Always in context:** Skill name + description (from frontmatter). Claude sees these for ALL installed skills at all times. This is why descriptions must be concise — they consume tokens constantly.
2. **Loaded on activation:** The full SKILL.md body + any files the skill references. Only loaded when Claude decides to use the skill (implicit match) or the user invokes it (`/skill-name`).

Include a token cost callout:
```asciidoc
[TIP]
====
Every installed skill's name and description sits in Claude's context window permanently. If you have 20 skills installed, that's 20 descriptions consuming tokens on every interaction. Write descriptions that are specific and compact — "Generate conference talk abstracts for CFP submissions" not "A helpful skill that assists users with various aspects of creating and refining abstracts for conference presentations and speaking engagements."
====
```

Link to Deep Agents subagent fundamentals for deeper context discussion: https://tonykay.github.io/showroom-deep-agents/modules/07-subagent-fundamentals.html#_exercise_1_the_context_bloat_problem

**Section: Building `abstract-writer`**

Step-by-step guided exercise:

1. Create the skill directory:
```asciidoc
[source,bash,role="execute"]
----
mkdir -p ~/.claude/skills/abstract-writer/templates
----
```

2. Create the SKILL.md file — provide the FULL content for the learner to write. The skill should:
   - Accept a talk topic and target conference
   - Generate a tailored abstract following common CFP conventions
   - Adapt tone and length based on conference type
   - Include a title suggestion
   - Reference templates in the skill directory

   The SKILL.md body should instruct Claude to:
   - Ask for the talk topic if not provided
   - Ask for the target conference (or accept "general")
   - Check for matching templates in the `templates/` directory
   - Generate an abstract with: title, 2-3 sentence summary, 3-5 bullet points of what attendees will learn, speaker bio placeholder
   - Keep abstracts under 300 words (standard CFP limit)

3. Create a lightning talk template (`templates/lightning-talk.md`):
   - 5-minute format
   - Title + 1 paragraph (100 words max)
   - 3 key takeaways

4. Create a full session template (`templates/full-session.md`):
   - 30-45 minute format
   - Title + 2-3 paragraph abstract (250-300 words)
   - 5 learning objectives
   - Target audience description
   - Prerequisites

**Section: Testing and Iterating**

Guide the learner through the test cycle:

1. Start a new Claude Code session (or use `/clear`):
```asciidoc
[source,bash,role="execute"]
----
claude
----
```

2. Test implicit triggering:
```asciidoc
[source,text]
----
> I need to write an abstract for a talk about building CLI tools with Python, targeting PyCon
----
```

3. Verify Claude used the skill (look for skill activation in the output)

4. Test explicit triggering:
```asciidoc
[source,text]
----
> /abstract-writer Write an abstract about Kubernetes security for KubeCon
----
```

5. Test the lightning talk template:
```asciidoc
[source,text]
----
> /abstract-writer I need a lightning talk abstract about prompt engineering for a local meetup
----
```

6. Iteration guidance: if the output doesn't match expectations, explain what to adjust in SKILL.md (description specificity, body instructions, template content) and repeat.

**Section: Summary**

Recap: you've built a skill from scratch, understanding frontmatter, body instructions, templates, and the test cycle. Tease Module 3: "Next, you'll use a meta-skill — skill-creator — to generate a skill automatically and see how it compares."

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/02-first-skill.adoc
git commit -m "content: add Module 2 — Creating Your First Skill"
```

---

### Task 5: Write `03-advanced-skills.adoc` — Module 3

**Files:**
- Create: `content/modules/ROOT/pages/03-advanced-skills.adoc`

**Key reference:** The `skill-creator` skill lives in the `anthropics/skills` GitHub repo as part of the official Anthropic skills collection. It's installed via the official plugin marketplace.

- [ ] **Step 1: Write the module**

**Title:**
```asciidoc
= Advanced Skills with skill-creator
:navtitle: 3. Advanced Skills with skill-creator
```

**Section: The skill-creator Skill**

Explain skill-creator as a meta-skill: a skill whose purpose is to create other skills. This is the first introduction to the idea that skills can be sophisticated tools, not just behavioral tweaks.

Install skill-creator:
```asciidoc
[source,bash,role="execute"]
----
claude plugin install skill-creator@claude-plugins-official
----
```

After installation, briefly show what got installed — the directory structure, the SKILL.md content. Have the learner read it:
```asciidoc
[source,bash,role="execute"]
----
cat ~/.claude/plugins/cache/claude-plugins-official/*/skills/skill-creator/SKILL.md
----
```

Note: this is the learner's first exposure to the marketplace/plugin installation mechanism. They installed `brand-guidelines` in Module 1, but here we pause to look at what the installation actually did. Full marketplace deep-dive comes in Module 4.

**Section: Generating `conf-finder`**

Walk through using skill-creator to generate a new skill:

1. Invoke skill-creator with a description of what the skill should do:
```asciidoc
[source,text]
----
> /skill-creator Create a skill called "conf-finder" that helps identify relevant
  conferences for a given topic or domain. It should search for conferences by
  topic area, geographic region, and time frame. Output should include conference
  name, dates, location, CFP deadline, and a relevance note.
----
```

2. Inspect what skill-creator generated — have the learner look at the output SKILL.md. Note the structure: frontmatter, body instructions, any generated templates.

3. Compare to manual approach: call back to Module 2. What did skill-creator do well? What would you change? Common observations:
   - Description might be too broad or too narrow
   - Body instructions might be generic
   - Templates might be missing
   - The structure follows conventions correctly

**Section: Refining Generated Skills**

Hands-on refinements to the generated `conf-finder`:

1. Tighten the description for better trigger accuracy:
```asciidoc
[source,text]
----
Before: "A skill that helps find conferences"
After:  "Find technology conferences relevant to a specific topic. Use when the user wants to discover conferences, find CFP deadlines, or identify speaking opportunities."
----
```

2. Add constraints to the body — geographic region filtering, conference size preferences, deadline awareness.

3. Add examples to the body — show Claude what good output looks like by including a sample conf-finder response in the SKILL.md.

4. Test the refined skill with a prompt and compare before/after quality.

**Section: Skill Complexity Spectrum**

Present skills on a complexity scale. Use a table or diagram:

```asciidoc
[cols="1,2,2",options="header"]
|===
|Level |Description |Example

|Instruction-only
|Pure `SKILL.md` — behavioral instructions, no supporting files
|`conf-finder` — tells Claude how to search and format results

|With supporting files
|`SKILL.md` + templates, reference data, or configuration
|`abstract-writer` — includes format templates for different talk types

|With executable components
|`SKILL.md` + Python/bash scripts that Claude can run
|`trip-report` (Module 4) — includes a formatting script
|===
```

Tease Module 4: the next skill (`trip-report`) will include executable components, and all three will be bundled into a marketplace.

**Section: Summary**

Recap: skill-creator accelerates skill creation but generated skills need refinement. The skill complexity spectrum gives you options for how sophisticated to make a skill. Tease Module 4: "Next, we'll build the third skill, then bundle all three into a distributable marketplace."

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/03-advanced-skills.adoc
git commit -m "content: add Module 3 — Advanced Skills with skill-creator"
```

---

### Task 6: Write `04-marketplaces.adoc` — Module 4

**Files:**
- Create: `content/modules/ROOT/pages/04-marketplaces.adoc`

**Key reference — Marketplace structure:**
```
conference-toolkit/
├── marketplace.json                          # Marketplace catalog
├── plugins/
│   └── conference-toolkit/
│       ├── .claude-plugin/
│       │   └── plugin.json                   # Plugin manifest
│       └── skills/
│           ├── abstract-writer/
│           │   ├── SKILL.md
│           │   └── templates/
│           ├── conf-finder/
│           │   └── SKILL.md
│           └── trip-report/
│               ├── SKILL.md
│               └── scripts/
│                   └── format-report.py
```

**Key reference — Installation commands:**
- Add marketplace: `claude plugin marketplace add <owner/repo>` or `claude plugin marketplace add ./local-path`
- Install plugin: `claude plugin install conference-toolkit@<marketplace-name>`
- Scopes: `--scope user` (default), `--scope project`, `--scope local`

- [ ] **Step 1: Write the module**

**Title:**
```asciidoc
= Marketplaces and Plugins
:navtitle: 4. Marketplaces and Plugins
```

**Section: From Skills to Plugins**

Motivate the transition: you now have `abstract-writer` and `conf-finder` as loose skills in `~/.claude/skills/`. They're related — they both serve the conference-speaking workflow. Problems with loose skills:
- No shared identity
- Can't distribute them as a set
- No versioning
- Name collisions if someone else has a skill called `abstract-writer`

Solution: bundle them into a **plugin** distributed via a **marketplace**.

Define the terms:
- **Plugin:** A collection of related skills (and optionally agents, commands, hooks) packaged as a directory with a `.claude-plugin/plugin.json` manifest.
- **Marketplace:** A git repo containing one or more plugins, with a `marketplace.json` catalog file. Claude Code can install plugins from any marketplace you add.

**Section: Marketplace Anatomy**

Walk through Anthropic's official `claude-plugins-official` repo structure as a reference example. Highlight:
- `marketplace.json` at the repo root — lists available plugins
- Each plugin in its own directory under `plugins/`
- Each plugin has `.claude-plugin/plugin.json` for metadata
- Skills live under `plugins/<plugin-name>/skills/<skill-name>/SKILL.md`
- Namespacing: installed skills are accessible as `plugin-name:skill-name` (e.g., `/conference-toolkit:abstract-writer`)

Show the marketplace.json format:
```json
{
  "name": "conference-toolkit-marketplace",
  "owner": {
    "name": "Your Name"
  },
  "plugins": [
    {
      "name": "conference-toolkit",
      "source": "./plugins/conference-toolkit",
      "description": "Skills for conference speakers: abstract writing, conference discovery, and trip reports"
    }
  ]
}
```

Show the plugin.json format:
```json
{
  "name": "conference-toolkit",
  "description": "A toolkit for conference speakers — write abstracts, find conferences, and generate trip reports",
  "version": "1.0.0"
}
```

**Section: Building `trip-report`**

The third and most complex skill. Step-by-step:

1. Create the skill directory structure:
```asciidoc
[source,bash,role="execute"]
----
mkdir -p ~/.claude/skills/trip-report/scripts
----
```

2. Write the SKILL.md — this skill generates post-conference trip reports. It should:
   - Accept conference name, dates attended, sessions list
   - Generate a structured report: executive summary, sessions attended (with key takeaways per session), action items, recommendations
   - Reference the formatting script for output polishing
   - The body instructions should tell Claude to run the formatting script on the raw report

3. Write `scripts/format-report.py` — a Python script that takes a markdown report on stdin and outputs a formatted version. Keep it simple: add a header with conference metadata, format action items as checkboxes, add a date stamp. This demonstrates executable components in skills without overcomplicating the exercise.

Provide the complete Python script content (~30-40 lines).

4. Test the skill locally before moving to marketplace packaging.

**Section: Creating the `conference-toolkit` Marketplace**

Step-by-step construction of the marketplace repo:

1. Create a new directory (outside the current project):
```asciidoc
[source,bash,role="execute"]
----
mkdir -p ~/conference-toolkit/plugins/conference-toolkit/.claude-plugin
mkdir -p ~/conference-toolkit/plugins/conference-toolkit/skills
----
```

2. Create `marketplace.json` at the repo root (content shown above in Marketplace Anatomy section — repeat it here for the exercise).

3. Create `plugins/conference-toolkit/.claude-plugin/plugin.json` (content shown above — repeat it here).

4. Copy skills into the marketplace structure:
```asciidoc
[source,bash,role="execute"]
----
cp -rf ~/.claude/skills/abstract-writer ~/conference-toolkit/plugins/conference-toolkit/skills/
cp -rf ~/.claude/skills/conf-finder ~/conference-toolkit/plugins/conference-toolkit/skills/
cp -rf ~/.claude/skills/trip-report ~/conference-toolkit/plugins/conference-toolkit/skills/
----
```

5. Initialize git and push:
```asciidoc
[source,bash,role="execute"]
----
cd ~/conference-toolkit
git init
git add -A
git commit -m "Initial conference-toolkit marketplace"
----
```

Note: for the push step, the learner needs a GitHub repo. Include instructions for creating one via `gh repo create` or the GitHub UI, then `git remote add origin` and `git push`.

**Section: Installing and Verifying**

1. Remove the locally-installed individual skills:
```asciidoc
[source,bash,role="execute"]
----
rm -rf ~/.claude/skills/abstract-writer
rm -rf ~/.claude/skills/conf-finder
rm -rf ~/.claude/skills/trip-report
----
```

2. Add the marketplace (from local path for testing, or GitHub URL if pushed):
```asciidoc
[source,bash,role="execute"]
----
claude plugin marketplace add ./conference-toolkit
----
```
Or from GitHub:
```asciidoc
[source,bash,role="execute"]
----
claude plugin marketplace add your-username/conference-toolkit
----
```

3. Install the plugin:
```asciidoc
[source,bash,role="execute"]
----
claude plugin install conference-toolkit@conference-toolkit-marketplace
----
```

4. Verify namespaced access — start a Claude Code session and test:
```asciidoc
[source,text]
----
> /conference-toolkit:abstract-writer Write an abstract about observability for KubeCon
----
```

**Section: Distribution and Scope**

Cover:
- `--scope user` vs `--scope project` vs `--scope local` installation
- `--scope project` writes to `.claude/settings.json` — teammates who clone the repo get the plugin automatically
- Versioning: if `plugin.json` has a `version` field, users only get updates when you bump it. Without it, every git commit is a new version.
- The open question: how do you know if a skill is still working well after you change it? Evaluation frameworks are emerging — this is an evolving space. Plant the seed, don't solve it.

**Section: Summary**

Recap: you've built a marketplace with three skills, installed it, and verified namespaced access. Tease Module 5: "Next, we're going to use your marketplace alongside two other skill layers — superpowers and beads — in a real-world workflow."

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/04-marketplaces.adoc
git commit -m "content: add Module 4 — Marketplaces and Plugins"
```

---

### Task 7: Write `05-full-monty.adoc` — Module 5

**Files:**
- Create: `content/modules/ROOT/pages/05-full-monty.adoc`

- [ ] **Step 1: Write the module**

**Title:**
```asciidoc
= The Full Monty
:navtitle: 5. The Full Monty
```

**Section: The Layered Ecosystem**

Introduce the mental model: skills compose into layers that operate at different levels.

Use a table or diagram:
```asciidoc
[cols="1,2,2",options="header"]
|===
|Layer |Purpose |Example

|Harness skills
|Shape HOW you work — process, methodology, guardrails
|superpowers (brainstorming, TDD, debugging workflows)

|Domain skills
|Provide WHAT you work with — domain-specific capabilities
|conference-toolkit (abstract-writer, conf-finder, trip-report)

|Workflow skills
|Track WHERE the work stands — state, progress, coordination
|beads (issue tracking, dependency management)
|===
```

Key insight: these layers don't conflict because they operate at different abstraction levels. A harness skill tells Claude *how* to approach a task, a domain skill gives it *what* to produce, and a workflow skill tracks *progress*. Claude resolves all three simultaneously.

**Section: Setting Up the Layers**

Guided setup of all three layers:

1. Install superpowers (if not already installed):
```asciidoc
[source,bash,role="execute"]
----
claude plugin install superpowers@claude-plugins-official
----
```

Briefly describe what superpowers provides: brainstorming (structured ideation before building), TDD (test-first development), debugging (systematic root-cause analysis), and more. These are "harness" skills — they don't do domain work, they shape the process.

2. Initialize beads in a test project:
```asciidoc
[source,bash,role="execute"]
----
mkdir -p ~/capstone-project && cd ~/capstone-project
git init
bd init
----
```

Briefly describe beads: a Dolt-powered issue tracker that lives in your repo. Issues survive conversation compaction and session restarts. Skills like `bd create`, `bd ready`, `bd close` manage work items.

3. Ensure conference-toolkit is installed (from Module 4).

4. Show the installed skill landscape:
```asciidoc
[source,bash,role="execute"]
----
ls ~/.claude/plugins/
----
```

All three layers visible side by side.

**Section: The Capstone Workflow**

The scenario: "You've been invited to submit a talk to a conference next month. Plan it, write it, track the work."

Walk through the end-to-end workflow:

1. **Create a work item** (workflow layer):
```asciidoc
[source,text]
----
> bd create --title="Submit talk to upcoming conference" --description="Find a relevant conference, write an abstract, submit it" --type=task --priority=2
----
```

2. **Brainstorm the topic** (harness layer):
```asciidoc
[source,text]
----
> /brainstorming I want to give a talk about how Agent Skills change the way developers interact with AI coding tools. Help me explore angles and narrow down a focus.
----
```

Walk through the brainstorming conversation — superpowers will ask clarifying questions, propose approaches, help refine the idea.

3. **Find the right conference** (domain layer):
```asciidoc
[source,text]
----
> /conference-toolkit:conf-finder Find technology conferences in the next 3 months that accept talks about AI developer tools or AI-assisted coding
----
```

4. **Write the abstract** (domain layer):
```asciidoc
[source,text]
----
> /conference-toolkit:abstract-writer Write a full-session abstract about "Agent Skills: Teaching AI How to Work With You" for [conference name from step 3]
----
```

5. **Close the work item** (workflow layer):
```asciidoc
[source,text]
----
> bd close <issue-id>
----
```

6. **(Stretch) Generate a trip report** after attending:
```asciidoc
[source,text]
----
> /conference-toolkit:trip-report Generate a trip report for [conference]. Sessions attended: [list]. Key themes: [themes].
----
```

**Section: How Skills Compose**

Reflection on what just happened:

- Three skill sources: superpowers (Anthropic marketplace), conference-toolkit (your marketplace), beads (third-party plugin)
- Three different purposes: process (brainstorming), domain (conference tools), workflow (issue tracking)
- Zero conflicts: each skill operated at its own layer
- Claude resolved skill activation correctly: `/brainstorming` triggered superpowers, `/conference-toolkit:conf-finder` triggered the marketplace skill, `bd create` triggered beads
- The "harness within a harness" concept: superpowers is itself a harness (it shapes how Claude approaches tasks), running inside Claude Code (which is also a harness). Skills compose at multiple levels.

**Section: Course Summary**

What the learner built across all 5 modules:
- Module 1: Understood skills and used a pre-built one
- Module 2: Hand-wrote `abstract-writer` from scratch
- Module 3: Used skill-creator to generate and refine `conf-finder`
- Module 4: Built `trip-report`, created a `conference-toolkit` marketplace, installed and verified it
- Module 5: Used all three layers together in a real workflow

Closing note: the skills ecosystem is young. There's opportunity to build skills, contribute to marketplaces, and shape how AI coding tools evolve. Point to Module 6 (bonus) for programmatic use and resources.

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/05-full-monty.adoc
git commit -m "content: add Module 5 — The Full Monty"
```

---

### Task 8: Write `06-bonus-programmatic.adoc` — Module 6 Stub

**Files:**
- Create: `content/modules/ROOT/pages/06-bonus-programmatic.adoc`

- [ ] **Step 1: Write the stub page**

This is a stub — section outline with "Coming soon" notices, not full content.

```asciidoc
= Bonus: Programmatic Skills
:navtitle: 6. Bonus: Programmatic Skills

[NOTE]
====
This module is under development. The sections below outline what's coming.
====

== Programmatic Skill Invocation

_Coming soon_ — Using skills in Deep Agents agent code. Build the "hello world" of multi-skill agents: an outliner, a researcher, and a reviewer working together, each powered by a different skill.

== Skills Calling Skills

_Coming soon_ — A validator skill that invokes other skills as part of its workflow. Skills as composable building blocks in agent architectures.

== Next Steps and Resources

Whether you're ready to build your own skills or contribute to the ecosystem, here are the key resources:

* https://code.claude.com/docs/en/skills[Claude Code Skills Documentation] — Official reference for skill creation and distribution
* https://agentskills.io/home[Agent Skills Hub] — Community hub for discovering and sharing skills
* https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md[skill-creator source] — The meta-skill that builds skills
* https://claude.com/blog/skills-explained[Skills Explained] — How skills compare to prompts, Projects, MCP, and subagents
* https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview[Agent Skills API Docs] — For programmatic skill use in the Agent SDK
```

- [ ] **Step 2: Commit**

```bash
git add content/modules/ROOT/pages/06-bonus-programmatic.adoc
git commit -m "content: add Module 6 stub — Bonus: Programmatic Skills"
```

---

### Task 9: Build Verification

**Files:** None modified — verification only.

- [ ] **Step 1: Verify all pages exist**

```bash
ls -la content/modules/ROOT/pages/
```

Expected files:
```
index.adoc
01-introduction.adoc
02-first-skill.adoc
03-advanced-skills.adoc
04-marketplaces.adoc
05-full-monty.adoc
06-bonus-programmatic.adoc
```

No other files should be present (old template pages removed).

- [ ] **Step 2: Verify nav.adoc references match page files**

```bash
grep 'xref:' content/modules/ROOT/nav.adoc
```

Every xref target must correspond to a file in `pages/`.

- [ ] **Step 3: Build the site with Antora**

```bash
npx @antora/cli@3.1 --fetch site.yml 2>&1 | tail -20
```

Expected: build completes with no errors. Warnings about missing images are acceptable. The output lands in `./www/`.

If `npx` is not available, install globally first:
```bash
npm i -g @antora/cli@3.1 @antora/site-generator@3.1 @sntke/antora-mermaid-extension@0.0.9 @andrew-jones/antora-tabs-extension
antora --fetch site.yml
```

- [ ] **Step 4: Verify output structure**

```bash
ls www/modules/
```

Should contain rendered HTML for each page.

- [ ] **Step 5: Spot-check rendered pages**

```bash
grep -l "abstract-writer" www/modules/*.html 2>/dev/null || grep -rl "abstract-writer" www/ | head -5
```

The `abstract-writer` skill name should appear in Modules 2, 4, and 5. If not found, content is missing or didn't render.

- [ ] **Step 6: Clean up build output**

```bash
rm -rf www/
```

The `www/` directory is in `.gitignore` (or should be — verify). Don't commit build artifacts.

- [ ] **Step 7: Final commit if any fixes were needed**

If any issues were found and fixed during verification, commit them:
```bash
git add -A
git commit -m "fix: address build verification issues"
```

---

## Execution Order

Tasks must be executed in order: Task 1 (scaffold) first, then Tasks 2-8 (content pages) in numeric order (each module references concepts from earlier modules). Task 9 (verification) runs last.

Tasks 2-8 are independent in the sense that they each create a separate file, but the content builds progressively — Module 3 references Module 2's `abstract-writer`, Module 4 references both earlier skills, Module 5 references everything. Writing them in order ensures cross-references are accurate.
