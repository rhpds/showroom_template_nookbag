---
description: "Workshop module generation skill - creates Red Hat Showroom workshop modules with hands-on exercises when user says 'create lab module'"
alwaysApply: false
---

# Lab Module Generator Skill

## Trigger Commands

When user says ANY of these phrases, invoke this skill:
- "create lab"
- "create lab module"
- "generate workshop module"
- "create workshop"
- "new lab"
- "add module to lab"

## Skill Execution

**Action**: Read and follow `.claude/skills/create-lab/SKILL.md` completely.

The skill file contains the complete workflow for:
1. Determining context (first module vs continuation)
2. Planning overall lab story (if first module)
3. Optional AgnosticV catalog configuration assistance
4. Gathering module-specific details
5. Reading templates and verification prompts
6. Generating complete module with all required sections
7. Updating navigation
8. Delivering files and documentation

## Important Notes

- Follow sequential questioning - ask ONE question at a time
- Use token management - write files with Write tool, show brief summaries only
- Apply all critical rules from `showroom-standards` rule
- Generate files in correct order for new labs
- Read verification prompts BEFORE generating content
