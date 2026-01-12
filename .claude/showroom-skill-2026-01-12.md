# Showroom Skills Update - January 12, 2026

## Summary

Critical updates to content quality and Red Hat style compliance:
1. AsciiDoc formatting fixes (list spacing)
2. Clickable image requirements
3. **Plagiarism prevention validation**
4. **Em dash removal enforcement**

All changes enforce Red Hat Corporate Style Guide and protect against copyright issues.

---

## Key Changes

### 1. AsciiDoc List Formatting - Now Enforced ✅

**What Changed:**
- All lists MUST have blank lines before and after
- Blank lines required after bold headings before lists
- Verification actively scans for formatting violations
- Skills generate properly formatted content automatically

**Why:**
- Lists without blank lines cause text to run together in Showroom
- Makes content unreadable and unprofessional
- Damages Red Hat brand credibility
- Increases support burden

**In Practice:**

❌ **WRONG - Text runs together**:
```asciidoc
**Demonstration flow and timing guidance**
15-20 minute executive brief (Module 1 only): * Focus: Core business value
* Highlights: Show rapid model serving
Next section...
```

✅ **CORRECT - Proper spacing**:
```asciidoc
**Demonstration flow and timing guidance**

15-20 minute executive brief (Module 1 only):

* Focus: Core business value
* Highlights: Show rapid model serving

Next section...
```

**Required blank lines:**
1. Blank line after bold heading (`**Text:**`) or colon
2. Blank line before first list item
3. Blank line after last list item

---

### 2. All Images Must Be Clickable - Now Required ✅

**What Changed:**
- ALL images must include `link=self,window=blank`
- Opens full-size in new tab when clicked
- Required in both create-lab and create-demo skills
- Updated all example code

**Why:**
- Learners/presenters need to see image details
- Opening in new tab prevents losing place in workshop/demo
- Better user experience
- Based on team feedback (Nate Stephany requirement)

**In Practice:**

❌ **WRONG - Not clickable**:
```asciidoc
image::architecture.png[Architecture Diagram,width=700,title="System Architecture"]
```

✅ **CORRECT - Clickable**:
```asciidoc
image::architecture.png[Architecture Diagram,link=self,window=blank,width=700,title="System Architecture"]
```

**With center alignment (optional)**:
```asciidoc
image::deployment.png[Deployment Flow,link=self,window=blank,align="center",width=800,title="Deployment Process"]
```

---

### 3. Verification Enhancements

**What Changed:**
- `/verify-content` now actively scans for:
  - Lists without blank lines
  - Bold text immediately followed by list markers
  - Colons immediately followed by lists
  - Lists directly followed by paragraphs
  - Images missing `link=self,window=blank`

**Error Reporting:**
- Provides specific before/after examples
- Shows exact file and location
- Includes step-by-step fix instructions
- Explains business/learning impact

---

### 4. Template Fixes

**Demo Template Updated:**
- `.claude/templates/demo/02-details.adoc`
- Added proper blank lines around all lists
- Fixed typos ("introduct" → "introduce", "interationss" → "interactions")
- Now serves as correct reference example

---

### 5. Plagiarism Prevention - NEW REQUIREMENT ✅

**What Changed:**
- Added Section 7 to SKILL-COMMON-RULES.md: Content Originality and Plagiarism Prevention
- Added Section 8 to redhat_style_guide_validation.txt: Plagiarism Prevention
- Updated both verification prompts with plagiarism detection
- Skills now actively check for copied content

**Why:**
- Protects Red Hat from copyright issues
- Maintains Red Hat's thought leadership credibility
- Ensures authentic Red Hat expertise
- Builds customer trust through original content

**In Practice:**

❌ **WRONG - Copied from kubernetes.io without attribution**:
```asciidoc
Kubernetes is an open-source system for automating deployment, scaling,
and management of containerized applications.
```

✅ **CORRECT - Original with proper attribution**:
```asciidoc
According to link:https://kubernetes.io/docs/...[Kubernetes documentation^],
Kubernetes is "an open-source system for automating deployment, scaling,
and management of containerized applications." Red Hat OpenShift extends
Kubernetes with enterprise features including integrated CI/CD, developer
tools, and enhanced security policies.
```

**Prohibited Practices:**
- ❌ Copying documentation verbatim from external sources
- ❌ Slightly rewording existing tutorials or blog posts
- ❌ Copy/pasting from Stack Overflow, forums, or vendor docs
- ❌ Using AI-generated content without significant review
- ❌ Presenting others' examples as original work

**Required Practices:**
- ✅ Write original content in your own words
- ✅ Add Red Hat-specific context and implementation details
- ✅ Use proper attribution with quotes and citations
- ✅ Paraphrase completely, don't just rearrange words
- ✅ Add unique value beyond the original source

---

### 6. Em Dash Removal - NEW REQUIREMENT ✅

**What Changed:**
- Added Section 8 to SKILL-COMMON-RULES.md: Punctuation Standards - No Em Dashes
- Added em dash rules to redhat_style_guide_validation.txt
- Updated both verification prompts to scan for em dash character (—)
- Skills now actively flag all em dash usage

**Why:**
- Follows Red Hat Corporate Style Guide
- Clearer punctuation improves readability
- Consistent formatting maintains quality standards
- Better translation for global audiences

**In Practice:**

❌ **WRONG - Em dash used**:
```asciidoc
OpenShift—Red Hat's platform—simplifies deployments
The process is simple—just follow these 3 steps
```

✅ **CORRECT - Use commas, periods, or en dashes**:
```asciidoc
OpenShift, Red Hat's platform, simplifies deployments
The process is simple. Just follow these 3 steps.
```

**Replacement Guide:**

| Use Case | Instead of Em Dash | Use This |
|----------|-------------------|----------|
| Parenthetical remark | "Platform—features" | "Platform, features" or "Platform (features)" |
| Break in thought | "Simple—just do this" | "Simple. Just do this." |
| Emphasis/list intro | "Three things—a, b, c" | "Three things: a, b, and c" |
| Range | "2020—2025" | "2020–2025" (en dash –) |

**Acceptable Dash Usage:**
- ✅ **En dashes (–)** for ranges: "2020–2025", "pages 10–15"
- ✅ **Hyphens (-)** for compound words: "multi-cloud", "real-time"
- ✅ **Regular dashes** in CLI commands: `--namespace`, `--output`

---

## What This Means For You

### When Creating Content

**Using /create-lab or /create-demo:**
- Skills automatically generate proper formatting
- All lists have correct blank lines
- All images are clickable by default
- No action needed - it's built in

**You'll see output like:**
```asciidoc
**Prerequisites:**

* OpenShift 4.18 or later
* Admin access to cluster
* Terminal with oc CLI

In this module, you will...
```

### When Verifying Content

**Using /verify-content:**
Now checks:
- ✅ List formatting (blank lines)
- ✅ Image clickability (link=self,window=blank)
- ✅ Provides detailed fix instructions
- ⚠️ Reports exact violations with examples

### When Fixing Existing Content

**Step 1: Run verification**
```
/verify-content
```

**Step 2: Review reported issues**
- Look for "asciidoc_formatting" category
- Check before/after examples provided

**Step 3: Fix formatting**
- Add blank lines around lists
- Add `link=self,window=blank` to images
- Test in Showroom preview

**Step 4: Re-verify**
```
/verify-content
```

---

## Common Violations and Fixes

### Violation 1: List After Bold Heading

❌ **WRONG**:
```asciidoc
**Benefits:**
* Cost reduction
* Faster deployment
```

✅ **CORRECT**:
```asciidoc
**Benefits:**

* Cost reduction
* Faster deployment
```

---

### Violation 2: List After Colon

❌ **WRONG**:
```asciidoc
Follow these steps:
. Step 1
. Step 2
```

✅ **CORRECT**:
```asciidoc
Follow these steps:

. Step 1
. Step 2
```

---

### Violation 3: List Before Paragraph

❌ **WRONG**:
```asciidoc
* Item 1
* Item 2
Next section...
```

✅ **CORRECT**:
```asciidoc
* Item 1
* Item 2

Next section...
```

---

### Violation 4: Non-Clickable Image

❌ **WRONG**:
```asciidoc
image::diagram.png[Diagram,width=700]
```

✅ **CORRECT**:
```asciidoc
image::diagram.png[Diagram,link=self,window=blank,width=700]
```

---

## Files Changed

Repository: `showroom_template_nookbag`

```
.claude/docs/SKILL-COMMON-RULES.md                              (+93 lines)
.claude/prompts/enhanced_verification_demo.txt                  (+72 lines)
.claude/prompts/enhanced_verification_workshop.txt              (+74 lines)
.claude/skills/create-lab/SKILL.md                              (+11, -6)
.claude/skills/create-demo/SKILL.md                             (+10, -5)
.claude/templates/demo/02-details.adoc                          (+9, -3)
.claude/CHANGELOG-2026-01-12.md                                 (new file)
CLAUDE-SKILLS-GUIDE.adoc                                        (+53 lines)
```

**Total:** 8 files changed, 322 insertions(+), 14 deletions(-)

---

## Technical Details

### Why Blank Lines Matter

AsciiDoc processors use blank lines to:
- Delimit block boundaries
- Separate lists from surrounding content
- Properly parse list markers vs inline text

**Without blank lines**: Renderer treats list markers as plain text, causing formatting collapse.

**With blank lines**: Renderer correctly identifies list blocks and applies proper styling.

### Why Clickable Images Matter

- Workshop learners need to see screenshot details
- Demo presenters need to reference diagrams during presentation
- Opening in new tab preserves context
- Improves accessibility and user experience

---

## Migration Checklist

For existing workshops/demos created before today:

- [ ] Run `/verify-content` on all modules
- [ ] Review list formatting violations
- [ ] Add blank lines around all lists
- [ ] Add blank lines after bold headings
- [ ] Add `link=self,window=blank` to all images
- [ ] Test rendering in Showroom preview
- [ ] Commit changes

---

## Quick Reference

**Skills:**
- `/create-lab` - Creates workshops with proper formatting
- `/create-demo` - Creates demos with proper formatting
- `/verify-content` - Checks formatting and provides fixes
- `/blog-generate` - Converts modules to blog posts

**What's New:**
- `create-lab`: All lists properly formatted, all images clickable
- `create-demo`: All lists properly formatted, all images clickable
- `verify-content`: **Actively scans** for formatting violations
- `blog-generate`: No changes

**New Validation Rules:**
1. Blank line before every list (MANDATORY)
2. Blank line after every list (MANDATORY)
3. Blank line after bold headings before lists (MANDATORY)
4. All images must include `link=self,window=blank` (MANDATORY)

---

## Support

**Documentation:**
- Main guide: `CLAUDE-SKILLS-GUIDE.adoc`
- Full changelog: `.claude/CHANGELOG-2026-01-12.md`
- Developer guide: `.claude/INTERNAL-DEVELOPER-GUIDE.adoc`
- Common rules: `.claude/docs/SKILL-COMMON-RULES.md`

**Questions:**
- Internal: #demo-platform Slack channel
- GitHub: https://github.com/rhpds/showroom_template_nookbag/issues

---

**Last Updated:** January 12, 2026
**Repository:** showroom_template_nookbag (main branch)
**Status:** ✅ Ready for use
