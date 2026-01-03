# Blog Generator

Transform completed Red Hat Showroom lab modules or demo content into blog posts for Red Hat Developer, internal blogs, or marketing platforms.

## When to Use

**Use this skill when you want to**:
- Convert workshop modules into developer blog posts
- Transform demo content into product announcements
- Create marketing content from technical labs
- Repurpose Showroom content for broader audiences

**Don't use this for**:
- Creating new lab content → use `/lab-module`
- Creating new demo content → use `/demo-module`
- Editing existing blog posts → use technical-editor agent

## Workflow

### Step 1: Identify Source Content

I'll ask you:

1. **Source modules**:
   - Which completed modules to base the blog on?
   - Provide file paths (e.g., `workshop/openshift-pipelines/03-module-01.adoc`)
   - Can combine multiple modules into one blog

2. **Source type**:
   - Workshop module (hands-on lab)
   - Demo module (presenter-led)
   - Both (combined perspective)

### Step 2: Determine Blog Parameters

I'll ask:

3. **Target platform**:
   - Red Hat Developer blog (developers.redhat.com)
   - Internal Red Hat blogs (Source, Memo, The Stack)
   - Marketing/announcement format (product launches)
   - Custom/Other

4. **Blog type**:
   - Technical tutorial ("How to...")
   - Product announcement ("Introducing...")
   - Thought leadership ("Why...")
   - Case study/success story
   - Quick start guide

5. **Technical depth**:
   - Highly technical (code-heavy, for developers)
   - Moderately technical (balanced, for technical managers)
   - Marketing-focused (business benefits, light on code)

6. **Blog parameters**:
   - Desired word count (500-800 / 1000-1500 / 2000+)
   - Include code samples? (Yes / Minimal / No)
   - Target audience level (Beginner / Intermediate / Advanced)

### Step 3: Read Source Content

I'll:
- Read all specified module files
- Extract key concepts, procedures, commands
- Identify business value propositions
- Note technical highlights
- Capture screenshots/diagrams to reference

### Step 4: Transform Content

Based on source type and target, I'll transform:

**Workshop → Developer Blog**:
- Convert step-by-step exercises → narrative "how to" flow
- Keep technical depth and code samples
- Add context and explanation
- Include "Try it yourself" CTA with Showroom link

**Demo → Product Announcement**:
- Extract business value from Know sections
- Highlight capabilities from Show sections
- Emphasize customer benefits
- Include competitive differentiators

**Workshop → Marketing Blog**:
- Focus on "what you can achieve" not "how to do it"
- Minimize technical steps
- Emphasize business outcomes
- Use executive-friendly language

**Demo → Thought Leadership**:
- Extract patterns and best practices
- Industry trends and challenges
- Strategic perspectives
- Minimal code, maximum insights

### Step 5: Generate Blog Structure

I'll create a blog post with:

**For Technical Blogs**:
```markdown
# [Engaging Title]

**Introduction** (100-150 words):
- Hook: Problem statement or interesting fact
- What readers will learn
- Why it matters now

**Background/Context** (150-200 words):
- Technical landscape
- Current challenges
- Solution approach

**Main Content** (organized by sections):
- Progressive narrative (not step 1, 2, 3...)
- Code examples in context
- Explanatory paragraphs between code
- Screenshots where helpful
- Technical insights and tips

**Conclusion** (100 words):
- Summary of what was covered
- Key takeaways
- Next steps or advanced topics

**Call-to-Action**:
- Try the full workshop: [Showroom link]
- Related resources
- Community links

**Metadata**:
- Title
- Description/summary
- Tags/categories
- Author info
```

**For Marketing Blogs**:
```markdown
# [Benefit-Focused Title]

**Introduction**:
- Business challenge hook
- What this means for readers
- Value proposition

**The Challenge**:
- Current state pain points
- Industry context
- Why change is needed

**The Solution**:
- Product/capability overview
- Key benefits (not features)
- Customer success snippets

**Business Impact**:
- Quantified outcomes
- Strategic advantages
- ROI considerations

**Getting Started**:
- Simple next steps
- Resources available
- Support options

**CTA**:
- Request demo
- Try it yourself
- Contact sales

**Metadata**:
- Executive-friendly title
- SEO-optimized description
- Product tags
```

### Step 6: Apply Platform-Specific Formatting

**Red Hat Developer Blog**:
- Markdown format
- Code blocks with syntax highlighting
- Developer-focused tone
- Technical accuracy paramount
- Community engagement encouraged

**Internal Red Hat Blogs**:
- AsciiDoc or Markdown (ask preference)
- Red Hat product naming standards
- Internal links to resources
- Team/org specific context

**Marketing Format**:
- Business language
- Minimal jargon
- Visual emphasis (suggest infographics)
- Customer success quotes
- Lead generation CTAs

### Step 7: Validate and Deliver

I'll:
- Run technical-editor agent for tone and clarity
- Run style-enforcer agent for Red Hat standards
- Verify all code samples are complete
- Check links and references

You'll get:
- Complete blog post file (Markdown or AsciiDoc)
- Metadata section (title, description, tags, author)
- Image reference list (what visuals to create/include)
- SEO recommendations
- Platform submission checklist

## Transformation Examples

### Example 1: Workshop → Developer Tutorial

**Source** (workshop exercise):
```asciidoc
== Exercise 1: Create Tekton Pipeline

. Create a task definition:
+
[source,yaml]
----
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: build-app
----

. Apply the task:
+
[source,bash]
----
oc apply -f task.yaml
----
```

**Output** (blog narrative):
```markdown
## Building Your First CI/CD Pipeline with Tekton

Tekton Pipelines brings cloud-native CI/CD to OpenShift. Instead of wrestling with
complex Jenkins configurations, you can define your entire build process as
Kubernetes-native resources.

Let's start by creating a simple build task. In Tekton, tasks are reusable building
blocks that define a series of steps:

\`\`\`yaml
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: build-app
spec:
  steps:
    - name: build
      image: maven:3.8
      script: |
        mvn clean package
\`\`\`

Apply this task to your cluster with `oc apply -f task.yaml`, and you've just
created your first reusable CI/CD component. What makes this powerful is...
```

### Example 2: Demo → Product Announcement

**Source** (demo Know section):
```asciidoc
=== Know
_Customer challenge: Deployment cycles take 6-8 weeks, blocking critical business initiatives._

**Business Impact:**
* Development teams wait 6-8 weeks for platform provisioning
* Manual processes cause errors and rework
```

**Output** (marketing blog):
```markdown
## Accelerating Time-to-Market with OpenShift

For many organizations, application deployment isn't just slow—it's a strategic
bottleneck. We've seen development teams wait 6 to 8 weeks just to provision
infrastructure, turning agile development into waterfall delivery.

OpenShift eliminates this bottleneck through self-service developer platforms that
reduce deployment time from weeks to minutes. Your developers get the infrastructure
they need when they need it, without manual ticket-and-wait processes...
```

## Example Usage

```
User: Create a developer blog from my OpenShift Pipelines workshop modules:
      workshop/openshift-pipelines/03-module-01.adoc
      workshop/openshift-pipelines/04-module-02.adoc

Skill: I'll transform those modules into a developer blog. Let me ask...

Q1: Source modules? → [already provided]
Q2: Source type? → Workshop modules
Q3: Target platform? → Red Hat Developer blog
Q4: Blog type? → Technical tutorial
Q5: Technical depth? → Highly technical (for developers)
Q6: Word count? → 1500-2000 words
Q7: Include code samples? → Yes, comprehensive
Q8: Audience level? → Intermediate

[Reads both modules]
[Extracts: Tekton tasks, pipeline definitions, execution steps]
[Transforms exercises into narrative flow]
[Generates:]

✓ Created: blog-posts/openshift-pipelines-tutorial.md
✓ Format: Markdown for Red Hat Developer
✓ Length: ~1800 words
✓ Includes: 5 code examples, 3 screenshot references
✓ CTA: Links back to full Showroom workshop
✓ Metadata: Title, tags, description included
```

## Tips for Best Results

**For Technical Blogs**:
- Keep code samples complete and tested
- Explain the "why" not just "what"
- Progressive disclosure (simple → complex)
- Link to full lab for hands-on practice

**For Marketing Blogs**:
- Lead with business value
- Use customer language, not product features
- Quantify outcomes where possible
- Include visual elements (suggest infographics)

**General**:
- One blog per major topic (don't combine unrelated modules)
- Maintain consistent voice throughout
- SEO-friendly titles and descriptions
- Platform-appropriate CTAs

## Transformation Patterns

### Workshop Exercise → Tutorial Section

**Pattern**:
1. Introduce the capability (what and why)
2. Show the implementation (code/commands)
3. Explain the outcome (what it does)
4. Connect to larger context (why it matters)

**Don't**:
- List steps 1, 2, 3 without narrative
- Include every verification command
- Use "Now we will..." repeatedly

**Do**:
- Tell a story with the code
- Explain decisions and tradeoffs
- Highlight insights and best practices

### Demo Know Section → Blog Value Prop

**Pattern**:
1. State the business challenge
2. Quantify the pain (metrics)
3. Introduce the solution
4. Emphasize the transformation

**Don't**:
- Use generic marketing speak
- Overstate capabilities
- Skip the "why it matters"

**Do**:
- Use specific, credible numbers
- Connect to industry trends
- Show customer perspective

## Quality Standards

Every generated blog will have:
- ✓ Engaging title (SEO-friendly)
- ✓ Strong introduction hook
- ✓ Narrative flow (not instructional steps)
- ✓ Platform-appropriate tone
- ✓ Complete code samples (if technical)
- ✓ Clear CTAs
- ✓ Metadata (title, description, tags)
- ✓ Red Hat style compliance
- ✓ Proper product naming

## Platform-Specific Guidelines

**Red Hat Developer**:
- Developer-to-developer tone
- Hands-on and practical
- Open source friendly
- Community engagement focus
- Link to GitHub/docs generously

**Internal Blogs (Source/Memo)**:
- Red Hat employee context
- Internal project references OK
- Team collaboration emphasis
- Process and culture relevant

**Marketing**:
- Executive language
- Business benefit focus
- Customer success stories
- Lead generation optimized
- Competitive positioning

## Integration Notes

**Agents invoked**:
- `technical-editor` - Refines tone and clarity
- `style-enforcer` - Applies Red Hat standards

**Output formats**:
- Markdown (.md) - Primary format
- AsciiDoc (.adoc) - If requested

**Output location**:
- Default: `blog-posts/<topic-slug>.md`
- Or user-specified path
