---
description: "Content quality verification skill - verifies workshop/demo content against Red Hat standards when user says 'verify content'"
alwaysApply: false
---

# Content Verification Skill

## Trigger Commands

When user says ANY of these phrases, invoke this skill:
- "verify content"
- "check quality"
- "review module"
- "validate content"

## Skill Execution

**Action**: Read and follow `.claude/skills/verify-content/SKILL.md` completely.

The skill file contains the complete workflow for:
1. Identifying content type (workshop vs demo)
2. Reading appropriate verification prompts
3. Checking against Red Hat style guide
4. Validating technical accuracy
5. Verifying accessibility compliance
6. Checking content quality standards
7. Providing detailed feedback with specific fixes

## Important Notes

- Read ALL relevant verification prompts from `.claude/prompts/`
- Provide specific, actionable feedback
- Reference line numbers and file locations
- Apply Red Hat Corporate Style Guide standards
