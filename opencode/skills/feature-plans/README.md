# Feature Plans OpenCode Skill

This package contains the `feature-plans` OpenCode skill and reusable Markdown templates.

## Install globally

Copy the `feature-plans` directory to:

`~/.config/opencode/skills/feature-plans/`

Linux/macOS example:

```bash
mkdir -p ~/.config/opencode/skills
cp -r feature-plans ~/.config/opencode/skills/
```

## Install in one project

Copy the `feature-plans` directory to:

`.opencode/skills/feature-plans/`

## Usage

Ask OpenCode to create a feature plan, for example:

> Create a feature plan for passwordless email login. Inspect the existing codebase first and save the plan under docs/feature-plans/passwordless-email-login/.

The skill writes plans in English by default and always creates `overview.md`. Supporting documents are selected based on complexity.

## Contents

- `feature-plans/SKILL.md` — workflow and quality criteria
- `feature-plans/templates/overview.md`
- `feature-plans/templates/requirements.md`
- `feature-plans/templates/architecture.md`
- `feature-plans/templates/implementation-plan.md`
- `feature-plans/templates/testing.md`
- `feature-plans/templates/decisions.md`
- `feature-plans/templates/rollout.md`
