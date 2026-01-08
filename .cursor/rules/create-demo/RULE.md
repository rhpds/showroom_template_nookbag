---
description: "Demo module generation skill - creates presenter-led demo content using Know/Show structure when user says 'create demo module'"
alwaysApply: false
---

# Demo Module Generator Skill

## Trigger Commands

When user says ANY of these phrases, invoke this skill:
- "create demo module"
- "demo-module"
- "generate demo"
- "create demo"
- "new demo"
- "presenter-led demo"

## Skill Execution

**Action**: Read and follow `.claude/skills/demo-module/SKILL.md` completely.

The skill file contains the complete workflow for:
1. Determining context (first module vs continuation)
2. Planning overall demo story (if first module)
3. Optional AgnosticV catalog configuration assistance
4. Gathering module-specific details
5. Reading templates and verification prompts
6. Generating complete demo with Know/Show structure
7. Updating navigation
8. Delivering files and documentation

## Important Notes

- Follow sequential questioning - ask ONE question at a time
- Use token management - write files with Write tool, show brief summaries only
- Apply all critical rules from `showroom-standards` rule
- Use Know/Show structure for presenter-led demos
- Read verification prompts BEFORE generating content
