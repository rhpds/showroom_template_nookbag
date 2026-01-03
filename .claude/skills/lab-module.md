# Lab Module Generator

Guide you through creating a single Red Hat Showroom workshop module from reference materials (URLs, files, docs, or text) with business storytelling and proper AsciiDoc formatting.

## When to Use

**Use this skill when you want to**:
- Create a new workshop module from scratch
- Convert documentation into hands-on lab format
- Add a module to an existing workshop
- Transform technical content into engaging learning experience

**Don't use this for**:
- Creating demo content → use `/demo-module`
- Converting to blog posts → use `/blog-generate`
- Reviewing existing content → use workshop-reviewer agent

## Workflow

### Step 1: Gather Requirements

I'll ask you 6 key questions:

1. **Lab name and module number**:
   - Lab name (subdirectory under workshop/)
   - Module number (03 for Module 1, 04 for Module 2, etc.)

2. **Reference materials**:
   - URLs to Red Hat docs
   - Local file paths (Markdown, AsciiDoc, text, PDF)
   - Or paste content directly

3. **Main learning objective**:
   - Example: "Create and run a CI/CD pipeline with Tekton"

4. **Business scenario**:
   - Auto-detect from previous module (if exists)
   - Or ask for company name (default: ACME Corp)

5. **Technology/product focus**:
   - Example: "OpenShift Pipelines", "Podman"

6. **Number of exercises**:
   - Recommended: 2-3

### Step 2: Fetch and Analyze References

Based on your references, I'll:
- Fetch URLs with WebFetch
- Read local files (supports PDF)
- Parse AgnosticD UserInfo YAML variables
- Extract procedures, commands, concepts
- Identify hands-on opportunities

### Step 3: Read Templates

I'll always read these before generating:
- `content/modules/ROOT/pages/workshop/templates/03-module-01.adoc`
- `content/modules/ROOT/pages/workshop/example/03-module-01.adoc`
- `.claude/prompts/redhat_style_guide_validation.txt`

### Step 4: Generate Module

I'll create a complete module with:

**Structure**:
- Learning objectives (3-4 items)
- Business introduction with scenario
- 2-3 progressive exercises
- Step-by-step instructions with commands
- Verification steps
- Image placeholders
- Module summary

**Quality**:
- Valid AsciiDoc syntax
- Proper Red Hat product names
- Sentence case headlines
- Second-person narrative
- Code blocks with syntax highlighting

### Step 5: Validate

I'll automatically run:
- **workshop-reviewer** agent: Validates structure and pedagogy
- **style-enforcer** agent: Applies Red Hat style standards

### Step 6: Update Navigation

I'll ask if you want me to add the module to `content/modules/ROOT/nav.adoc` (required for Showroom sidebar).

### Step 7: Deliver

You'll get:
- Complete module file at `content/modules/ROOT/pages/workshop/<lab-name>/<module-file>.adoc`
- Screenshot capture guide
- Navigation xref snippet
- Review checklist
- Next module suggestions

## Example Usage

```
User: Create Module 1 for OpenShift Pipelines using:
      https://docs.openshift.com/pipelines/1.12/

Skill: I'll create that module. Let me ask a few questions...
       [asks 6 questions]
       [generates module with ACME Corp scenario]
       [validates with agents]

✓ Created: workshop/openshift-pipelines/03-module-01.adoc
✓ 3 exercises: Create task, Define pipeline, Run pipeline
✓ Screenshot guide provided
✓ Ready to add to nav.adoc
```

## Tips for Best Results

- **Specific objectives**: "Build and deploy container with persistent storage" vs "Learn containers"
- **Multiple references**: More context = better content
- **Continue scenarios**: Reference previous module for narrative continuity
- **Test commands**: Always verify in real environment

## Quality Standards

Every module will have:
- ✓ Valid AsciiDoc syntax
- ✓ 3-4 clear learning objectives
- ✓ Business context introduction
- ✓ Progressive exercises (foundational → advanced)
- ✓ Verification steps
- ✓ Module summary
- ✓ Image placeholders
- ✓ Red Hat style compliance
