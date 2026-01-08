---
description: "Critical rules for Red Hat Showroom content generation - sequential questioning, token management, file generation order"
alwaysApply: true
---

# Red Hat Showroom Content Generation - Critical Rules

These rules apply to ALL content generation (workshop modules, demo modules, blog posts).

## CRITICAL Rules (Apply to ALL Content Generation)

### 1. Sequential Questioning (MANDATORY)
- Ask ONE question or ONE group of related questions at a time
- WAIT for user's answer before asking the next question
- Do NOT ask questions from multiple workflow steps together
- If user chooses AgV catalog help, complete ENTIRE AgV workflow before continuing
- Example WRONG: Asking file name, AgV help, UserInfo, learning objective all at once
- Example RIGHT: Ask AgV help question → WAIT → If yes, do full AgV workflow → THEN ask module details

### 2. Token Management (MANDATORY)
- NEVER output full module/demo content in chat
- Use Write tool to create files silently
- Show ONLY brief confirmations: "✅ Created: filename (X lines)"
- Keep total output under 5000 tokens (summaries, not content)
- User will review files in their editor, not in chat

### 3. File Generation Order for NEW Labs (MANDATORY)
If creating the FIRST module of a NEW lab, generate files in this EXACT order:
1. `index.adoc` - Learner landing page (NOT facilitator guide)
2. `01-overview.adoc` - Business scenario and learning objectives
3. `02-details.adoc` - Technical requirements and setup
4. `03-module-01-*.adoc` - First hands-on module

If continuing EXISTING lab:
- Only generate next module: `0X-module-YY-*.adoc`
- Skip index/overview/details (already exist)

### 4. File Naming Convention (MANDATORY)
- `index.adoc` (no number prefix)
- `01-overview.adoc`
- `02-details.adoc`
- `03-module-01-*.adoc` (first module)
- `04-module-02-*.adoc` (second module)
- `05-module-03-*.adoc` (third module)

### 5. External Links (MANDATORY)
ALL external links MUST use `^` caret to open in new tab:
- Format: `link:https://example.com[Link Text^]`
- Example: `link:https://docs.redhat.com/...[Red Hat Documentation^]`
- Internal xrefs do NOT use caret: `xref:03-module-02.adoc[Next Module]`

### 6. Dynamic Variables (MANDATORY - CRITICAL)
- ALWAYS keep variables as placeholders: `{openshift_cluster_console_url}`
- NEVER replace with actual values like `https://console-openshift-console.apps.cluster-abc123...`
- Showroom replaces these at runtime with actual deployment values
- Each deployment gets different URLs - variables MUST stay dynamic
- UserInfo variables are for knowing WHICH variables exist, NOT for hardcoding values

Example CORRECT usage:
```asciidoc
. Navigate to OpenShift Console at {openshift_cluster_console_url}
. Login with username: {openshift_cluster_admin_username}
. Password: {openshift_cluster_admin_password}
```

### 7. AgnosticV Catalog Creation (MANDATORY)
When using reference AgV catalog as template:
- Create EXACT COPY of reference catalog
- ONLY modify these fields (unless user explicitly requests):
  1. UUID → New generated UUID
  2. `__meta__.catalog.display_name` → User's workshop/demo name
  3. Catalog directory slug → Based on display name
  4. `__meta__.catalog.showroom` → User's showroom repo URL
- KEEP EVERYTHING ELSE EXACTLY AS-IS:
  - All workloads and their configurations
  - All includes, components, parameters
  - Infrastructure and multi-user settings
  - dev.yaml and description.adoc
- DO NOT "intelligently" modify workloads or settings
- ONLY modify if user explicitly says "remove X" or "change Y"

## Quality Standards

Every generated module must have:
- Valid AsciiDoc syntax
- Clear learning objectives (3-4 items)
- Progressive exercises (foundational → advanced)
- Verification checkpoints after major steps
- Troubleshooting section (3+ scenarios)
- Learning outcomes section
- References section with external links using `^`
- External links that open in new tab
- Dynamic variables as placeholders (not replaced)
- Red Hat style compliance
