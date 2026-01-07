# RHDP Content Developer Guide

Comprehensive guide for Red Hat Demo Platform (RHDP) content developers using Claude Code skills to create Showroom workshops and demos.

## Table of Contents

- [Available Skills](#available-skills)
- [Workflow Patterns](#workflow-patterns)
- [AgnosticV Integration](#agnosticv-integration)
- [Quality Standards](#quality-standards)
- [File Structure](#file-structure)
- [Best Practices](#best-practices)

---

## Available Skills

### `lab-module` - Workshop Module Generator

**Purpose**: Create hands-on workshop modules with step-by-step instructions, verification commands, and progressive learning.

**When to use**:
- Creating new workshop modules from Red Hat documentation
- Converting technical docs into hands-on labs
- Adding modules to existing workshops
- Building 30-90 minute learning experiences

**What it creates**:
- Complete workshop module with exercises
- Verification commands with expected outputs
- Troubleshooting section with common issues
- Learning outcomes section
- Red Hat style compliance
- Proper AsciiDoc formatting

**Workflow**:
1. Determines if first module or continuation
2. Plans overall workshop story (if first module)
3. Optional: AgnosticV catalog assistance
4. Gathers module-specific details
5. Reads verification prompts and examples
6. Generates module content
7. Updates navigation automatically

**See**: `.claude/skillslab-module/SKILL.md`

---

### `demo-module` - Demo Content Generator

**Purpose**: Create presenter-led demo modules using Know/Show structure with business value messaging.

**When to use**:
- Creating sales or field demonstration content
- Building executive-level demos
- Converting technical features into business value
- Creating presenter-guided walkthroughs

**What it creates**:
- Know sections: Business context, pain points, value propositions
- Show sections: Step-by-step presenter instructions
- Business metrics and ROI quantification
- Presenter tips and troubleshooting
- Visual cues for slides/diagrams
- Red Hat competitive positioning

**Workflow**:
1. Determines demo context (new vs continuation)
2. Plans overall demo story and business narrative
3. Optional: AgnosticV catalog assistance
4. Gathers module-specific details
5. Reads verification prompts and examples
6. Generates Know/Show structured content
7. Updates navigation automatically

**See**: `.claude/skillsdemo-module/SKILL.md`

---

### `verify-content` - Content Quality Verification

**Purpose**: Run comprehensive quality checks on workshop or demo content using Red Hat standards.

**When to use**:
- After creating new modules
- Before submitting PRs
- During content reviews
- To ensure Red Hat compliance

**What it checks**:
- Red Hat Corporate Style Guide compliance
- Technical accuracy for current product versions
- Accessibility standards (WCAG 2.1 AA)
- Workshop structure and pedagogy
- Complete documentation and references
- Proper AsciiDoc formatting

**Verification frameworks used**:
- `enhanced_verification_workshop.txt` / `enhanced_verification_demo.txt`
- `redhat_style_guide_validation.txt`
- `verify_workshop_structure.txt`
- `verify_technical_accuracy_workshop.txt` / `verify_technical_accuracy_demo.txt`
- `verify_accessibility_compliance_workshop.txt` / `verify_accessibility_compliance_demo.txt`
- `verify_content_quality.txt`

**See**: `.claude/skillsverify-content/SKILL.md`

---

## Workflow Patterns

### Pattern 1: Create Complete Workshop

```bash
# Step 1: Create first module (includes index, overview, details)
lab-module
→ Answer: First module of NEW lab
→ Provide: Lab overview, target audience, business scenario
→ Provide: Module details, reference materials
→ Result: index.adoc, 01-overview.adoc, 02-details.adoc, module-01-*.adoc

# Step 2: Verify first module
verify-content
→ Select: module-01-*.adoc
→ Review: Fix critical issues
→ Result: Quality validated module

# Step 3: Create additional modules
lab-module
→ Answer: Continuing EXISTING lab
→ Provide: Path to previous module OR story recap
→ Result: module-02-*.adoc (continues story)

# Step 4: Final verification
verify-content
→ Select: All modules
→ Result: Batch quality report
```

### Pattern 2: Create Demo with AgnosticV

```bash
# Step 1: Create demo with catalog
demo-module
→ Answer: First module of NEW demo
→ Answer: YES to AgnosticV help
→ Provide: AgV repo path
→ Search: Existing catalog OR create new
→ Result: AgV catalog + demo module

# Step 2: Test AgV catalog in RHDP Integration
→ Create PR for AgV catalog
→ Order on integration.demo.redhat.com
→ Wait for provisioning (1-2 hours)
→ Get Advanced settings output

# Step 3: Create remaining demo modules
demo-module
→ Answer: Continuing existing demo
→ Provide: Previous module path
→ Result: Additional demo modules

# Step 4: Verify all content
verify-content
→ Select: All demo modules
→ Result: Quality validation
```

### Pattern 3: Quick Module Creation

```bash
# For experienced users with existing catalog
lab-module
→ Skip: AgV assistance (already configured)
→ Provide: Module details and references
→ Result: Single module generated

verify-content
→ Quick verification and fixes
```

---

## AgnosticV Integration

Both `lab-module` and `demo-module` offer **optional** AgnosticV catalog assistance.

### When to Use AgV Assistance

**Choose "Yes, help me create new catalog" when**:
- Creating new workshop/demo needing RHDP deployment
- No existing catalog matches your needs
- You have AgnosticV repository access

**Choose "No" when**:
- RHDP team already created catalog
- Using external/customer clusters
- Documentation-only content

### AgV Workflow Features

**1. Access Check Protocol**:
- Immediately asks for AgV repository path
- Validates access before proceeding
- Provides fallback if no access

**2. Catalog Search**:
- User-suggested catalog search (by display name/slug)
- Keyword-based recommendations
- Shows top matches with full details

**3. Reference Catalog as Template**:
- Uses existing catalogs as structural templates
- Preserves proven working structure
- Only modifies: UUID, display_name, showroom repo, workloads
- Prevents schema validation errors

**4. Critical Fixes Implemented**:

#### UUID Generation (Before File Creation)
```bash
# OLD WAY (broken):
Create files → Insert PLACEHOLDER-UUID-MUST-BE-REPLACED → User edits manually

# NEW WAY (fixed):
Ask user: "Run uuidgen and paste UUID here"
User provides: C0948860-3F44-4D96-B360-E922173AE6D0
Insert UUID directly into common.yaml template
Create files with correct UUID
```

#### Showroom Repository Auto-Detection
```bash
# Detects from current directory:
git -C $(pwd) remote get-url origin

# Converts SSH to HTTPS:
git@github.com:rhpds/showroom-name.git
→ https://github.com/rhpds/showroom-name.git

# Confirms with user before using
```

#### Git Workflow
```bash
# Before creating files:
cd /path/to/agnosticv
git checkout master  # (AgV uses master not main)
git pull origin master
git checkout -b catalog-slug  # No feature/ prefix

# After files created:
# User manually reviews, commits, and pushes
```

### AgV Testing Confirmation

**CRITICAL**: Before proceeding to module creation, skill asks:

```
Q: Have you tested the AgV catalog in RHDP Integration?

Options:
1. Yes, tested and working → Proceed to module creation
2. No, I'll test it first → Pause workflow
3. Skip testing (not recommended) → Proceed with warning
```

**Testing workflow**:
1. Create PR (auto-labeled for integration)
2. Login to https://integration.demo.redhat.com
3. Search for catalog by display name
4. Order catalog
5. Wait 1-2 hours for provisioning
6. Go to "My services" → Details → Advanced settings
7. Copy UserInfo variables
8. Verify workloads provision correctly
9. Share Advanced settings output for module creation
10. Send PR to RHDP team for merge

---

## Quality Standards

All skills enforce:

### Red Hat Corporate Style Guide

- ✅ **Headlines in sentence case** (not title case)
- ✅ **Official Red Hat product names** (no abbreviations like "OCP")
- ✅ **Numbers as numerals** (use "5 steps" not "five steps")
- ✅ **No vague language** ("robust", "leverage", "powerful")
- ✅ **No unsupported superlatives** ("best", "leading" without citations)
- ✅ **Inclusive language** (allowlist/blocklist not whitelist/blacklist)
- ✅ **Serial commas** and proper hyphenation

### Technical Accuracy

- ✅ Valid commands for current product versions
- ✅ Correct syntax and options
- ✅ Working code examples
- ✅ Accurate technical terminology
- ✅ Verification commands with expected outputs

### Workshop Structure (Labs)

- ✅ Clear learning objectives (3-4 items)
- ✅ Step-by-step instructions
- ✅ Verification checkpoints after major steps
- ✅ Troubleshooting section (top 3-5 issues)
- ✅ Learning outcomes section
- ✅ Progressive skill building
- ✅ Business context and scenarios

### Demo Structure (Demos)

- ✅ Know/Show separation
- ✅ Business value messaging
- ✅ Quantified metrics and ROI
- ✅ Presenter guidance and tips
- ✅ Visual cues for slides/diagrams
- ✅ Troubleshooting for presenters

### Accessibility (WCAG 2.1 AA)

- ✅ Alt text for all images (descriptive, not generic)
- ✅ Proper heading hierarchy (h1 → h2 → h3)
- ✅ Sufficient color contrast
- ✅ Keyboard-accessible instructions
- ✅ Clear, inclusive language

---

## File Structure

### Standard Showroom Workshop Structure

```
content/modules/ROOT/pages/
├── index.adoc                    # Workshop facilitator guide
├── 01-overview.adoc              # Business scenario, learning objectives
├── 02-details.adoc               # Timing, requirements, setup
├── module-01-<slug>.adoc         # First hands-on module
├── module-02-<slug>.adoc         # Second module
├── module-03-<slug>.adoc         # Third module
└── ...

content/modules/ROOT/
├── nav.adoc                      # Navigation (auto-updated by skills)
├── assets/images/                # All images go here
│   ├── screenshot-1.png
│   ├── architecture-diagram.png
│   └── ...
└── partials/                     # Reusable content (optional)
```

### Image Path Convention

**All images** go in: `content/modules/ROOT/assets/images/`

**AsciiDoc reference** (no subdirectories):
```asciidoc
image::pipeline-execution-1.png[Tekton pipeline showing three tasks executing in sequence,width=700,title="Pipeline Execution in Progress"]
```

**Required for every image**:
1. Meaningful alt text (accessibility)
2. Width guidance (500-800px typical)
3. Descriptive filename (no generic names)

**Placeholders** (if image doesn't exist yet):
```asciidoc
// TODO: Add screenshot
image::create-task-screenshot.png[OpenShift console showing task creation form,width=600,title="Creating a Tekton Task"]
```

### Navigation Structure

Skills automatically update `nav.adoc`:

```asciidoc
* xref:index.adoc[Workshop Guide]

* xref:01-overview.adoc[Workshop Overview]

* xref:02-details.adoc[Workshop Details]

* xref:module-01-install-aap.adoc[Module 1: Installing AAP 2.6]
** xref:module-01-install-aap.adoc#exercise-1[Exercise 1: Install Operator]
** xref:module-01-install-aap.adoc#exercise-2[Exercise 2: Deploy Controller]

* xref:module-02-configure-aap.adoc[Module 2: Configure AAP]
** xref:module-02-configure-aap.adoc#exercise-1[Exercise 1: Create Inventory]
```

---

## Best Practices

### 1. Use Dynamic Attributes (Not Hardcoded Values)

**Why**: Every RHDP deployment gets new dynamic values

**Don't create** `_attributes.adoc` with hardcoded values:
```asciidoc
❌ :console_url: https://console-openshift-console.apps.cluster-rqlkr.dynamic...
```

**Do use** dynamic placeholders in content:
```asciidoc
✅ Log into OpenShift Console at {openshift_console_url}
✅ Username: {openshift_cluster_admin_username}
✅ Password: {openshift_kubeadmin_password}
```

These get populated from AgV catalog's `agnosticd_user_info` at runtime.

### 2. Follow Verification Checkpoint Pattern

**Every major step** needs verification:

```asciidoc
. Deploy the application:
+
[source,bash]
----
oc new-app --image=myapp:latest
----

. Verify the deployment:
+
[source,bash]
----
oc get pods
----
+
Expected output:
+
----
NAME                     READY   STATUS    RESTARTS   AGE
myapp-xxxxx-xxxxx       1/1     Running   0          2m
----
+
✓ Pod status shows `Running`
✓ READY column shows `1/1`
```

### 3. Include Troubleshooting Section

**Every module** needs troubleshooting for top 3-5 issues:

```asciidoc
== Troubleshooting

**Issue**: Pods stuck in `Pending` status
**Solution**:
. Check available resources: `oc describe node | grep -A 5 "Allocated resources"`
. Verify storage class exists: `oc get storageclass`
. Check pod events: `oc describe pod <pod-name>`
```

### 4. Add Learning Outcomes (Labs Only)

**Every workshop module** needs learning confirmation:

```asciidoc
== Learning outcomes

By completing this module, you should now understand:

* ✓ How AAP Operator manages lifecycle on OpenShift
* ✓ The relationship between AutomationController CR and platform components
* ✓ How to verify AAP installation using oc CLI and API
* ✓ Common installation issues and troubleshooting approaches
```

### 5. Separate Business from Technical (Demos Only)

**Know sections**: Business value, pain points, metrics

```asciidoc
=== Know

**Current challenge**: Manual deployments take 6-8 weeks
**Business impact**: Missing market windows, losing to competitors
**Solution value**: Reduce deployment time from weeks to minutes
**Quantified benefit**: 95% reduction in deployment cycle time
```

**Show sections**: Technical demonstration steps

```asciidoc
=== Show

**What I say**: "Watch how AAP reduces 6-week deployments to minutes"

**What I do**:
. Log into AAP at {aap_controller_url}
. Click Templates → Create new Job Template
. Configure automation workflow

**What they should notice**:
✓ Self-service interface (no IT tickets)
✓ Instant job execution (vs weeks of waiting)
```

### 6. Use Reference Catalogs as Templates

**When creating new AgV catalogs**:
- Find similar existing catalog
- Use as structural template
- Only change: UUID, display_name, showroom repo, workloads
- Preserve: includes, components, propagate_provision_data

**Why**: Prevents schema validation errors and follows proven patterns.

### 7. Test AgV Before Module Creation

**Critical workflow**:
1. Create AgV catalog files
2. Submit PR
3. Test in RHDP Integration (1-2 hours)
4. Verify workloads provision successfully
5. Get Advanced settings output
6. THEN create module content using real variables

**Don't**: Create modules with placeholder variables before testing catalog.

---

## Troubleshooting

### Skill doesn't ask about AgV

**Fix**: Update to latest skill version. AgV assistance is optional and asked in Step 2.5.

### UUID placeholder in generated catalog

**Fix**: This was fixed. Skill now asks for UUID before file creation. Update skill to latest version.

### Schema validation error: "property showroom is unsupported"

**Fix**: This was fixed. Skill now uses reference catalogs as templates. Showroom repo goes in workload variables, not `__meta__`.

### Skill creates attributes file with hardcoded values

**Fix**: This was removed. Skills use dynamic placeholders like `{openshift_console_url}` that get populated at runtime from AgV catalog.

### Navigation not updated

**Fix**: Skills automatically update `nav.adoc`. If manual override needed, edit `nav.adoc` directly.

### Verification prompts not applied

**Fix**: Skills now read ALL verification prompts before generating. Content meets standards when created. No separate validation needed.

---

## Files and Directories

### Skill Definitions

- `.claude/skillslab-module/SKILL.md` - Lab module generator
- `.claude/skillsdemo-module/SKILL.md` - Demo module generator
- `.claude/skillsverify-content/SKILL.md` - Content verification

### Shared Rules

- `.claude/docs/SKILL-COMMON-RULES.md` - Shared contracts for all skills

### Verification Prompts

All in `.claude/prompts/`:
- `enhanced_verification_workshop.txt`
- `enhanced_verification_demo.txt`
- `redhat_style_guide_validation.txt`
- `verify_workshop_structure.txt`
- `verify_technical_accuracy_workshop.txt`
- `verify_technical_accuracy_demo.txt`
- `verify_accessibility_compliance_workshop.txt`
- `verify_accessibility_compliance_demo.txt`
- `verify_content_quality.txt`

### Templates and Examples

- `content/modules/ROOT/pages/workshop/templates/` - Workshop templates
- `content/modules/ROOT/pages/workshop/example/` - Complete workshop example
- `content/modules/ROOT/pages/demo/` - Demo examples

---

## Support

**Maintained By**: Red Hat Technical Marketing Team

**Last Updated**: January 2026

**Contact**: Submit issues via repository or contact RHDP team
