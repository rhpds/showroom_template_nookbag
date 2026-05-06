# Claude Code Agent Skills Course — Design Spec

## Overview

A 6-module self-paced course teaching Claude Code Agent Skills, from using existing skills through building and distributing a marketplace. Built as a Showroom lab using Antora and AsciiDoc. The exercises follow a conference-speaking theme: three related skills (abstract-writer, conf-finder, trip-report) that progressively teach skill creation and culminate in a bundled marketplace.

## Audience

Technically skilled developers and practitioners who already use Claude Code comfortably. New to the skills/plugin ecosystem. May come from Cursor or other AI coding tools — cross-reference Cursor patterns where relevant.

## Delivery

- **Format:** Self-paced Showroom lab (also usable by instructors in a workshop setting)
- **Exercise environment:** Learner's local machine with Claude Code installed
- **Showroom role:** Instruction surface only — no terminal tabs or bastion environments
- **Prerequisites:** Claude Code installed and working, API key configured. No installation walkthrough — link to Anthropic docs.

## Content Architecture

### File structure

```
content/modules/ROOT/pages/
  index.adoc                    # Course overview, prerequisites, module map
  01-introduction.adoc          # Module 1: What are Agent Skills
  02-first-skill.adoc           # Module 2: Hand-write abstract-writer
  03-advanced-skills.adoc       # Module 3: Use skill-creator for conf-finder
  04-marketplaces.adoc          # Module 4: Bundle into a marketplace, add trip-report
  05-full-monty.adoc            # Module 5: Superpowers + beads + marketplace capstone
  06-bonus-programmatic.adoc    # Module 6: (stub) Programmatic skills with Deep Agents
```

### Navigation (nav.adoc)

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

### Repo changes

- **Remove:** All current Showroom template docs (index.adoc, content-repo.adoc, architecture.adoc, deployer.adoc, etc.)
- **Keep:** `examples/` directory as internal reference (not linked from nav)
- **Update antora.yml:** New title, strip infrastructure-specific attributes (bastion, OCP URLs)
- **Update site.yml:** Update site title
- **Update ui-config.yml:** Remove terminal tabs — Showroom is instruction-only for this course

### Module structure pattern

Each module follows:
1. Section intro — what we're building and why
2. Concept explanation — just enough theory to understand the exercise
3. Guided exercise — step-by-step with `role="execute"` source blocks
4. Verification — how to confirm it works
5. Summary — what we learned, what's next

## Module Designs

### Module 1 — Introduction to Agent Skills

**File:** `01-introduction.adoc`
**Goal:** Understand what skills are, where they fit, and use an existing one.

**Sections:**

1. **What are Agent Skills?** — Skills as reusable instruction sets that shape Claude Code's behavior. How they differ from prompts, MCP servers, and Projects. Brief history: from Cursor's `.cursorrules` to Claude Code's `SKILL.md` convention.

2. **Where skills live** — Skill resolution hierarchy:
   - `~/.claude/skills/` (global)
   - `.claude/skills/` (project-level)
   - Installed plugins/marketplaces
   - Scope: which takes precedence, when

3. **Using your first skill** — Install a pre-built skill from the Anthropic marketplace (e.g., `brand-guidelines` or another lightweight example). Demonstrate:
   - Implicit triggering: phrase a request so the skill activates automatically
   - Explicit triggering: use `/skill-name` slash command
   - Observe the difference in behavior with and without the skill

4. **Cursor cross-reference** — How Cursor handles similar concepts with `.cursorrules` files. Same idea, different mechanism. Helps learners from Cursor backgrounds map their knowledge.

5. **Summary** — Recap: skills are instruction files that shape Claude's behavior, they live in a resolution hierarchy, and they activate implicitly or explicitly.

**Exercise:** Install a marketplace skill. Trigger it both ways. Observe Claude's behavior change.

---

### Module 2 — Creating Your First Skill

**File:** `02-first-skill.adoc`
**Goal:** Hand-write a skill from scratch, understanding every piece of the anatomy.

**Sections:**

1. **Skill anatomy** — The `SKILL.md` file:
   - Frontmatter: `name`, `description`, trigger patterns. These are always loaded into context.
   - Body: instructions, constraints, examples. Loaded on activation.
   - Directory structure: a skill can include templates, examples, and supporting files alongside SKILL.md.
   - Context cost: link to Deep Agents subagent fundamentals for the context discussion.

2. **Progressive disclosure** — How Claude loads skills:
   - Frontmatter (name + description) is always in context
   - Full body is loaded only when the skill activates
   - Why this matters: token efficiency, context window management
   - Writing good descriptions that trigger accurately without over-triggering

3. **Building `abstract-writer`** — Step-by-step construction:
   - Create `~/.claude/skills/abstract-writer/` directory
   - Write the SKILL.md frontmatter (name, description, trigger patterns)
   - Write the body: instructions for generating conference talk abstracts
   - Add template files for different conference formats (e.g., lightning talk vs. full session)
   - The skill should accept a talk topic and target conference, producing a tailored abstract

4. **Testing and iterating** — Restart Claude Code. Trigger the skill with a test prompt. Inspect output quality. Iterate on instructions until behavior is correct. Show the feedback loop: modify SKILL.md → restart → test → repeat.

**Exercise:** Build `abstract-writer` from scratch. Test with at least two different conference contexts. Include at least one template file in the skill directory.

---

### Module 3 — Advanced Skills with skill-creator

**File:** `03-advanced-skills.adoc`
**Goal:** Use the `skill-creator` meta-skill to generate a skill, then inspect and refine it.

**Sections:**

1. **The skill-creator skill** — Install from Anthropic's marketplace. This is a first, light introduction to the marketplace/plugin concept (expanded fully in Module 4). Show the installation process and what files it adds.

2. **Generating `conf-finder`** — Use skill-creator to generate a skill that identifies conferences relevant to a given topic or domain. Walk through:
   - Describing the skill to skill-creator
   - Inspecting the generated SKILL.md
   - Comparing generated output vs. what you'd write by hand (reference Module 2 experience)

3. **Refining generated skills** — Modify the generated SKILL.md:
   - Tighten the trigger description for better activation accuracy
   - Add constraints (e.g., geographic region, conference size, submission deadlines)
   - Improve examples so Claude produces better output
   - Show that generated skills are starting points, not finished products

4. **Skill complexity spectrum** — Position skills on a complexity scale:
   - Instruction-only skills: `abstract-writer`, `conf-finder` (pure SKILL.md)
   - Skills with supporting files: templates, reference data
   - Skills with executable components: Python/bash scripts (tease Module 4's `trip-report`)
   - When to choose each level

**Exercise:** Use skill-creator to build `conf-finder`. Compare generated vs. manual approach. Refine until it reliably finds relevant conferences for a given topic.

---

### Module 4 — Marketplaces and Plugins

**File:** `04-marketplaces.adoc`
**Goal:** Bundle three skills into a distributable plugin, understand namespacing, and install from a git URL.

**Sections:**

1. **From skills to plugins** — Why bundle? Three related skills (abstract-writer, conf-finder, trip-report) share a domain. Bundling gives them a coherent identity, easier distribution, and namespaced access. Introduce the plugin concept.

2. **Marketplace anatomy** — Walk through Anthropic's own skills repo:
   - Repository structure and key files (`plugin.json` / manifest)
   - Namespacing: `marketplace-name:skill-name`
   - How Claude Code discovers and loads plugins
   - Scope: global vs. project-level installation

3. **Building `trip-report`** — The third conference skill. Generates post-conference trip reports summarizing sessions attended, key takeaways, and action items. This skill demonstrates a more complex directory structure — including a supporting script (Python or bash) for formatting output, showing how executable components integrate with SKILL.md instructions. Step-by-step construction following Module 2 patterns but at a higher complexity level.

4. **Creating the `conference-toolkit` marketplace** — Step-by-step:
   - Create a new git repo (`conference-toolkit`)
   - Add the marketplace manifest and required files
   - Move all three skills into the proper directory structure
   - Adjust namespacing in skill definitions
   - Push to GitHub (or any git remote)

5. **Installing and verifying** — Prove the marketplace works:
   - Remove locally-installed individual skills
   - Restart Claude Code
   - Install the marketplace from the git URL
   - Verify all three skills appear under the `conference-toolkit` namespace
   - Demonstrate namespaced invocation: `/conference-toolkit:abstract-writer`

6. **Distribution and scope** — How to share:
   - Global vs. project-level installation
   - Sharing with a team
   - Versioning considerations
   - The open question: skill evolution and evaluation (plant the seed, no definitive answer)

**Exercise:** Create a `conference-toolkit` marketplace repo. Move all three skills into it. Push to git. Install from the URL. Verify namespaced access to all three skills.

---

### Module 5 — The Full Monty

**File:** `05-full-monty.adoc`
**Goal:** Use multiple skill layers — a harness (superpowers), an issue tracker (beads), and the conference marketplace — together in a real workflow.

**Sections:**

1. **The layered ecosystem** — Skills compose into layers:
   - **Harness skills** (superpowers): shape HOW you work (brainstorming, TDD, debugging)
   - **Domain skills** (conference-toolkit): provide WHAT you work with
   - **Workflow skills** (beads): track WHERE the work stands
   - Mental model: these layers don't conflict because they operate at different levels

2. **Setting up the layers** — Install and configure:
   - Superpowers: brainstorming, TDD, debugging skills
   - Beads: issue tracking with `bd init`
   - Conference-toolkit marketplace (from Module 4)
   - Show how all three coexist in `~/.claude/` and project configs

3. **The capstone workflow** — End-to-end realistic task: "You've been invited to submit a talk to a conference next month."
   - Create a beads issue for the submission (`bd create`)
   - Use superpowers brainstorming to explore the talk topic
   - Use `conf-finder` to identify the right conference
   - Use `abstract-writer` to draft the abstract
   - Close the beads issue (`bd close`)
   - (Stretch) Use `trip-report` after the conference

4. **How skills compose** — Reflect on what happened:
   - Multiple skills from different sources, scopes, and purposes
   - All working together without conflicting
   - How Claude Code resolves skill priority and handles overlapping triggers
   - The "harness within a harness" concept: superpowers inside Claude Code

5. **Course summary** — What the learner built across all 5 modules:
   - Three skills from scratch and via skill-creator
   - A distributable marketplace
   - A multi-layer workflow
   - The skills ecosystem is young — opportunities to contribute and shape it

**Exercise:** Complete the capstone workflow end-to-end with all three layers active simultaneously.

---

### Module 6 — Bonus: Programmatic Skills (Stub)

**File:** `06-bonus-programmatic.adoc`
**Goal (specced, content deferred):** Show skills beyond CLI — programmatic invocation and skills-calling-skills.

**Planned sections (stub with "Coming soon" notice):**

1. **Programmatic skill invocation** — Using skills in Deep Agents agent code. The "hello world" of multi-skill agents: an outliner, a researcher, and a reviewer working together.

2. **Skills calling skills** — A validator skill that invokes other skills as part of its workflow. Skills as composable building blocks in agent architectures.

3. **Next steps and resources:**
   - Anthropic docs: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
   - Agent Skills hub: https://agentskills.io/home
   - skill-creator source: https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md
   - Skills explained blog: https://claude.com/blog/skills-explained

**Implementation:** Ships as a single page with the section outline and "Coming soon" callouts. Content written in a future iteration.

---

## index.adoc — Course Overview Page

The hub page replaces the current Showroom template index. Contains:

- Course title and one-paragraph description
- Prerequisites callout (Claude Code installed, API key, basic CLI comfort)
- Module map: numbered list with brief descriptions and xref links
- What you'll build: the `conference-toolkit` marketplace (abstract-writer + conf-finder + trip-report)
- Time estimate per module (if known)
- Cross-reference note: mentions Cursor equivalents will be noted throughout

## Configuration Changes

### antora.yml
- `title:` → "Claude Code Agent Skills"
- Strip `bastion_*`, `openshift_*`, `ssh_*` attributes (not needed for local-machine course)
- Keep `guid`, `page-pagination`, `experimental`

### site.yml
- `title:` → "Claude Code Agent Skills"
- `start_page:` → `modules::index.adoc` (unchanged, but verify)

### ui-config.yml
- Remove or comment out all terminal/console tabs
- Keep `view_switcher` with `default_mode: split` or change to documentation-only mode
- The Antora external tab can be replaced with something course-relevant (e.g., Anthropic skills docs)

## Out of Scope

- Module 6 content (specced but deferred)
- Video content or recordings
- Automated grading or assessment
- Multi-language support
- Showroom terminal environments (local machine only)
