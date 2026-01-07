# Claude Skills for Showroom Content

Quick guide to using Claude Code skills for creating Red Hat Showroom workshops and demos.

## Getting Started

1. Clone this repository and navigate to the directory
2. Start a Claude Code session
3. Run `/skills` to list available skills
4. Run a skill by name (without `/`): `lab-module`, `demo-module`, or `verify-content`

## Available Skills

### `lab-module` - Create Workshop Modules

Creates hands-on workshop modules with:
- Step-by-step instructions
- Verification commands
- Troubleshooting guidance
- Red Hat style compliance

**When to use**: Creating workshops for developers, architects, SREs

### `demo-module` - Create Demo Content

Creates presenter-led demo modules with:
- Business value messaging (Know sections)
- Technical demonstration steps (Show sections)
- Presenter guidance and tips
- ROI quantification

**When to use**: Creating sales demos, executive presentations

### `verify-content` - Quality Verification

Checks content for:
- Red Hat Corporate Style Guide compliance
- Technical accuracy
- Accessibility standards (WCAG 2.1 AA)
- Workshop structure and pedagogy

**When to use**: Before submitting PRs, during content reviews

## Quick Workflow

### Create a New Workshop

```
1. Run: lab-module
2. Answer: First module of NEW lab
3. Provide lab overview and module details
4. Review and refine generated content
5. Run: verify-content
```

### Continue Existing Workshop

```
1. Run: lab-module
2. Answer: Continuing EXISTING lab
3. Provide path to previous module
4. Content continues the story automatically
```

### Create a Demo

```
1. Run: demo-module
2. Follow the workflow prompts
3. Skills guide you through Know/Show structure
4. Run: verify-content to check quality
```

## Documentation

- **Detailed Guide**: `.claude/CLAUDE-SKILLS-GUIDE.md` - Comprehensive documentation for RHDP content developers
- **Skill Definitions**: `.claude/skills/*/SKILL.md` - Individual skill documentation

## Support

Red Hat Technical Marketing Team | January 2026
