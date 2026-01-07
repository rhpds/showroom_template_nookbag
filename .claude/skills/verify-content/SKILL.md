---
name: verify-content
description: Run comprehensive quality verification on workshop or demo content using Red Hat standards and validation agents.
---

# Content Verification Skill

Verify workshop or demo content against Red Hat quality standards, style guidelines, technical accuracy, and accessibility requirements.

## When to Use

**Use this skill when you want to**:
- Verify workshop content before publishing
- Check demo modules for quality and completeness
- Validate technical accuracy and Red Hat style compliance
- Review content for accessibility standards
- Get actionable feedback on content improvements

**Don't use this for**:
- Creating new content → use `/lab-module` or `/demo-module`
- Converting between formats → use `/blog-generate`

## Workflow

### Step 1: Identify Content Type

**Q: What type of content are you verifying?**

Options:
1. Workshop module (hands-on lab content)
2. Demo module (presenter-led demonstration)
3. Multiple files (specify pattern)

### Step 2: Locate Content

**For single file**:
- Provide file path (e.g., `content/modules/ROOT/pages/module-01-install-aap.adoc`)

**For multiple files**:
- Provide glob pattern (e.g., `content/modules/ROOT/pages/*.adoc`)
- Or directory path (e.g., `content/modules/ROOT/pages/`)

### Step 3: Run Verification Agents

I'll run comprehensive verification using these validation frameworks:

**For Workshop Content**:
1. `enhanced_verification_workshop.txt` - Overall quality assessment
2. `redhat_style_guide_validation.txt` - Red Hat style compliance
3. `verify_workshop_structure.txt` - Workshop structure validation
4. `verify_technical_accuracy_workshop.txt` - Technical accuracy
5. `verify_accessibility_compliance_workshop.txt` - Accessibility standards
6. `verify_content_quality.txt` - General content quality

**For Demo Content**:
1. `enhanced_verification_demo.txt` - Overall demo quality
2. `redhat_style_guide_validation.txt` - Red Hat style compliance
3. `verify_technical_accuracy_demo.txt` - Demo technical accuracy
4. `verify_accessibility_compliance_demo.txt` - Accessibility standards
5. `verify_content_quality.txt` - General content quality

### Step 4: Present Results

I'll provide:

**Summary Report**:
- Overall quality score
- Critical issues (must fix)
- Warnings (should fix)
- Recommendations (nice to have)

**Detailed Findings**:
- Specific file locations
- Before/after examples
- Implementation steps
- Priority levels

**Actionable Items**:
- Numbered list of fixes
- Links to relevant documentation
- Estimated effort level

### Step 5: Offer Fixes (Optional)

After showing results, I can:
- Apply fixes automatically (with your approval)
- Provide code snippets for manual fixes
- Explain why each change improves quality

## Example Usage

### Example 1: Verify Single Workshop Module

```
User: /verify-content

Skill: What type of content are you verifying?
User: Workshop module

Skill: File path?
User: content/modules/ROOT/pages/module-01-install-aap.adoc

[Runs all workshop verification agents]

Skill:
📊 Verification Results for module-01-install-aap.adoc

**Overall Score**: 82/100

**Critical Issues** (3):
1. Missing verification commands in Exercise 2 (line 145)
2. Incorrect Red Hat product name: "OCP" should be "Red Hat OpenShift" (line 67)
3. Missing alt text for screenshot placeholder (line 203)

**Warnings** (5):
1. Troubleshooting section could be more comprehensive
2. Learning outcomes section recommended but missing
3. Some commands lack expected output examples

**Recommendations** (2):
1. Add time estimates for each exercise
2. Include references section with documentation links

Would you like me to apply fixes automatically? [Yes/Show details/Manual fixes]
```

### Example 2: Verify All Modules in Workshop

```
User: Verify all my workshop modules

Skill: Content location?
User: content/modules/ROOT/pages/

[Scans and finds 3 modules + index/overview]

Skill: Found 5 files:
- index.adoc
- 01-overview.adoc
- 02-details.adoc
- module-01-install-aap.adoc
- module-02-configure-aap.adoc

Verify all? [Yes/Select specific files]

User: Yes

[Runs verification on all files]

Skill:
📊 Batch Verification Results

**Summary**:
- 5 files verified
- Average score: 78/100
- 12 critical issues across all files
- 23 warnings
- 15 recommendations

**Top Issues**:
1. Inconsistent heading styles across modules (affects: all modules)
2. Missing Red Hat style compliance in 3 files
3. No accessibility alt text in 8 image references

**Per-File Scores**:
- index.adoc: 85/100 ✓
- 01-overview.adoc: 90/100 ✓
- 02-details.adoc: 88/100 ✓
- module-01-install-aap.adoc: 72/100 ⚠️
- module-02-configure-aap.adoc: 65/100 ⚠️

Would you like detailed report for specific files? [Enter file numbers or 'all']
```

## Verification Standards

Every verification includes:

**Red Hat Style Guide**:
- ✓ Sentence case headlines
- ✓ Official Red Hat product names
- ✓ No prohibited terms (whitelist/blacklist, etc.)
- ✓ Proper hyphenation and formatting
- ✓ Serial comma usage

**Technical Accuracy**:
- ✓ Valid commands for current versions
- ✓ Correct syntax and options
- ✓ Working code examples
- ✓ Accurate technical terminology

**Workshop Quality** (for labs):
- ✓ Clear learning objectives
- ✓ Step-by-step instructions
- ✓ Verification commands with expected outputs
- ✓ Troubleshooting guidance
- ✓ Progressive skill building

**Demo Quality** (for demos):
- ✓ Know/Show structure
- ✓ Business value messaging
- ✓ Presenter guidance
- ✓ Visual cues for slides/diagrams
- ✓ Quantified metrics and ROI

**Accessibility**:
- ✓ Alt text for all images
- ✓ Proper heading hierarchy
- ✓ Clear, inclusive language
- ✓ Keyboard-accessible instructions

**Content Quality**:
- ✓ Complete prerequisites
- ✓ Consistent formatting
- ✓ Proper AsciiDoc syntax
- ✓ References and citations
- ✓ Professional tone

## Output Format

Results are presented in clear, actionable format:

```markdown
## Critical Issues (Must Fix)

### 1. Missing Verification Commands
**File**: module-01-install-aap.adoc:145
**Impact**: Learners can't verify success, leading to confusion

**Current**:
```asciidoc
. Deploy the AutomationController:
```

**Fixed**:
```asciidoc
. Deploy the AutomationController:
+
[source,bash]
----
oc get automationcontroller -n ansible-automation-platform
----
+
Expected output:
----
NAME                  STATUS   AGE
platform-controller   Running  5m
----
```

**How to fix**:
1. Add verification command after deployment step
2. Include expected output
3. Add success indicator

---

## Warnings (Should Fix)

### 1. Incomplete Troubleshooting Section
**File**: module-01-install-aap.adoc:250
**Impact**: Reduces learner independence

**Recommendation**: Add 3-5 common issues with solutions
...
```

## Quality Gates

Content passes verification when:
- ✓ Overall score ≥ 80/100
- ✓ Zero critical issues
- ✓ All Red Hat style violations fixed
- ✓ Technical accuracy confirmed
- ✓ Accessibility standards met

## Integration with Other Skills

**After `/lab-module`**:
- Run verification on generated module
- Apply fixes before committing
- Ensure quality standards met

**After `/demo-module`**:
- Verify Know/Show structure
- Check business messaging
- Validate presenter guidance

**Before publishing**:
- Final verification of all content
- Batch check entire workshop
- Generate quality report

## Tips for Best Results

**Be specific about content type**:
- Workshop modules use different standards than demos
- Infrastructure files (nav.adoc, README.adoc) have different requirements

**Review before auto-fix**:
- Understand why changes are recommended
- Some fixes may need manual adjustment
- Technical accuracy requires domain knowledge

**Run verification regularly**:
- After creating new modules
- Before submitting PRs
- After major content updates

## Quality Standards

Every verification run checks:
- ✓ Red Hat brand compliance
- ✓ Technical accuracy for current versions
- ✓ Accessibility (WCAG 2.1 AA)
- ✓ Learning effectiveness
- ✓ Professional formatting
- ✓ Complete documentation
- ✓ Consistent style

## Files Used

**Verification prompts** (in `.claude/prompts/`):
- `enhanced_verification_workshop.txt`
- `enhanced_verification_demo.txt`
- `redhat_style_guide_validation.txt`
- `verify_workshop_structure.txt`
- `verify_technical_accuracy_workshop.txt`
- `verify_technical_accuracy_demo.txt`
- `verify_accessibility_compliance_workshop.txt`
- `verify_accessibility_compliance_demo.txt`
- `verify_content_quality.txt`

**Reference examples**:
- `content/modules/ROOT/pages/workshop/example/`
- `content/modules/ROOT/pages/demo/`
