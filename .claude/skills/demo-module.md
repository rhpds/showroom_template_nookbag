# Demo Module Generator

Guide you through creating a Red Hat Showroom demo module using the Know/Show structure for presenter-led demonstrations.

## When to Use

**Use this skill when you want to**:
- Create presenter-led demo content
- Transform technical documentation into business-focused demos
- Add a module to an existing demo
- Create content for sales engineers or field demonstrations

**Don't use this for**:
- Hands-on workshop content → use `/lab-module`
- Converting to blog posts → use `/blog-generate`
- Reviewing existing content → use workshop-reviewer agent

## Know/Show Structure

Demos use a different format than workshops:

- **Know sections**: Business context, customer pain points, value propositions, why this matters
- **Show sections**: Step-by-step presenter instructions, what to demonstrate, expected outcomes

This separates what presenters need to **understand** (business value) from what they need to **do** (technical demonstration).

## Workflow

### Step 1: Gather Requirements

I'll ask you 7 key questions:

1. **Demo name and module number**:
   - Demo name (subdirectory under demo/)
   - Module number (03 for Module 1, 04 for Module 2, etc.)

2. **Reference materials**:
   - URLs to Red Hat docs
   - Local files (Markdown, AsciiDoc, PDF)
   - Or paste content directly

3. **Target audience**:
   - Sales engineers, C-level executives, technical managers, developers

4. **Business scenario/challenge**:
   - Auto-detect from previous module (if exists)
   - Or ask for customer scenario (e.g., "RetailCo needs faster deployments")

5. **Technology/product focus**:
   - Example: "OpenShift", "Ansible Automation Platform"

6. **Number of demo parts**:
   - Recommended: 2-4 parts (each with Know/Show sections)

7. **Key metrics/business value**:
   - Example: "Reduce deployment time from 6 weeks to 5 minutes"

### Step 2: Fetch and Analyze References

Based on your references, I'll:
- Fetch URLs and extract technical capabilities
- Read local files
- Identify business value propositions
- Extract metrics and quantifiable benefits
- Map technical features to business outcomes

### Step 3: Read Demo Templates

I'll read these before generating:
- `content/modules/ROOT/pages/demo/03-module-01.adoc`
- `content/modules/ROOT/pages/demo/01-overview.adoc`
- `.claude/prompts/redhat_style_guide_validation.txt`

### Step 4: Generate Demo Module

I'll create a module with Know/Show structure:

**For each demo part**:

**Know Section**:
- Business challenge explanation
- Current state vs desired state
- Quantified pain points
- Stakeholder impact
- Value proposition

**Show Section**:
- Step-by-step presenter instructions
- Specific commands and UI interactions
- Expected screens/outputs
- Image placeholders for key moments
- Business value callouts during demo
- Troubleshooting hints

**Example Structure**:
```asciidoc
== Part 1 — Accelerating Application Deployment

=== Know
_Customer challenge: Deployment cycles take 6-8 weeks, blocking critical business initiatives._

**Business Impact:**
* Development teams wait 6-8 weeks for platform provisioning
* Black Friday deadline in 4 weeks is at risk
* Manual processes cause errors and rework
* Competition is shipping features faster

**Value Proposition:**
OpenShift reduces deployment time from weeks to minutes through self-service developer platforms and automated CI/CD pipelines.

=== Show
* Log into OpenShift Console at {openshift_console_url}
  * Username: {user}
  * Password: {password}

* Navigate to Developer perspective → +Add

* Select "Import from Git" and enter:
  * Git Repo: `https://github.com/example/nodejs-ex`
  * Application name: `retail-checkout`
  * Deployment: Create automatically

* Click "Create" and observe:
  * Build starts automatically
  * Container image is built
  * Application deploys in ~2 minutes

image::deployment-progress.png[align="center",width=700,title="Deployment in Progress"]

* **Business Value Callout**: "What used to take your team 6-8 weeks just happened in 2 minutes. Developers can now deploy independently without waiting for infrastructure teams."

* Show the running application:
  * Click the route URL
  * Demonstrate the live application
  * Highlight the automatic scaling capability

* Connect to business outcome:
  "This self-service capability means your development team can meet the 4-week Black Friday deadline and ship updates daily instead of quarterly."
```

### Step 5: Validate

I'll automatically run:
- **workshop-reviewer** agent: Validates structure
- **style-enforcer** agent: Applies Red Hat style standards
- Verify Know/Show balance and business focus

### Step 6: Update Navigation

I'll ask if you want me to add the module to `content/modules/ROOT/nav.adoc`.

### Step 7: Deliver

You'll get:
- Complete demo module at `content/modules/ROOT/pages/demo/<demo-name>/<module-file>.adoc`
- Screenshot capture guide (with emphasis on presenter view)
- Navigation xref snippet
- Presenter notes
- Next module suggestions

## Example Usage

```
User: Create demo Module 1 for OpenShift using:
      https://docs.openshift.com/container-platform/4.14/

Skill: I'll create that demo module. Let me ask questions...

Q1: Demo name? → "openshift-platform-value"
Q2: Module number? → 03 (Module 1)
Q3: Target audience? → "Sales engineers presenting to C-level"
Q4: Business scenario? → "RetailCo needs faster time-to-market"
Q5: Technology focus? → "OpenShift Container Platform"
Q6: Number of parts? → 3
Q7: Key metrics? → "6 weeks → 5 minutes deployment time"

[Generates module with:]
- Part 1: Self-service developer platform
- Part 2: Automated CI/CD pipelines
- Part 3: Business continuity and scaling
- Each part has Know (business context) + Show (demo steps)
- Business value callouts throughout

✓ Created: demo/openshift-platform-value/03-module-01.adoc
✓ Presenter notes included
✓ Screenshot guide provided
```

## Know Section Best Practices

Good Know sections include:

**Business Challenge**:
- Specific customer pain point
- Current state with metrics
- Why it matters now (urgency)

**Current vs Desired State**:
- "Now: 6-8 week deployment cycles"
- "Goal: Deploy multiple times per day"

**Stakeholder Impact**:
- Who cares: "VP Engineering, Product Managers"
- Why: "Missing market windows, losing to competitors"

**Value Proposition**:
- Clear benefit statement
- Quantified outcome
- Business language, not tech jargon

## Show Section Best Practices

Good Show sections include:

**Clear Instructions**:
- Numbered steps
- Specific UI elements ("Click Developer perspective")
- Exact field values to enter

**Expected Outcomes**:
- What presenters should see
- Screenshots of key moments
- Success indicators

**Business Callouts**:
- Connect each technical step to business value
- Use phrases like "This eliminates..." or "This reduces..."
- Quantify where possible

**Presenter Tips**:
- Common questions to expect
- Troubleshooting hints
- Pacing suggestions

## Tips for Best Results

- **Specific metrics**: "6 weeks → 5 minutes" not "faster deployments"
- **Real scenarios**: Base on actual customer challenges
- **Visual emphasis**: Demos need more screenshots than workshops
- **Business language**: Executives care about outcomes, not features
- **Story arc**: Build narrative across parts

## Quality Standards

Every demo module will have:
- ✓ Know/Show structure for each part
- ✓ Business context before technical steps
- ✓ Quantified metrics and value propositions
- ✓ Clear presenter instructions
- ✓ Image placeholders with descriptions
- ✓ Business value callouts during Show
- ✓ Target audience appropriate language
- ✓ Red Hat style compliance

## Common Demo Patterns

**Executive Audience**:
- More Know, less Show
- Focus on business outcomes
- High-level demonstrations
- Emphasize strategic value

**Technical Audience**:
- Balanced Know/Show
- Show depth and capabilities
- Include architecture discussions
- Technical credibility focus

**Sales Engineers**:
- Detailed Show sections
- Competitive differentiators
- Objection handling
- ROI calculations

## Integration Notes

**Templates used**:
- `content/modules/ROOT/pages/demo/03-module-01.adoc`
- `content/modules/ROOT/pages/demo/01-overview.adoc`

**Agents invoked**:
- `workshop-reviewer` - Validates structure
- `style-enforcer` - Applies Red Hat style

**Files created**:
- Demo module: `content/modules/ROOT/pages/demo/<demo-name>/<module-file>.adoc`
- Assets: `content/modules/ROOT/assets/images/<demo-name>/`

**Files modified** (with permission):
- `content/modules/ROOT/nav.adoc` - Adds navigation entry
