---
name: feature-plans
description: Create implementation-ready feature plans for software projects, including overview.md, requirements, architecture, data flows, implementation tasks, testing, risks, and decisions. Use when planning a new feature or a substantial change before implementation.
compatibility: opencode
metadata:
  audience: developers
  workflow: feature-planning
---

# Feature Plans

## Purpose

Create clear, implementation-ready documentation for a proposed feature before changing application code. The plan must explain what the feature does, why it exists, how it fits into the current system, and how to implement and verify it.

## When to use

Use this skill when the user asks to:
- plan, design, scope, or prepare a feature before coding;
- create a feature plan or implementation plan;
- document a new capability or substantial behavior change;
- break a feature into implementation phases or tasks.

Do not use it for a tiny bug fix unless the user explicitly requests a plan.

## Core rules

1. **Inspect before documenting.** Explore the repository's instructions, structure, relevant source files, tests, dependencies, and existing architecture. Follow project-specific guidance such as `AGENTS.md`, `AGENTS.md` equivalents, and README files when present.
2. **Describe the actual codebase.** Distinguish verified facts from assumptions. Never invent existing modules, endpoints, tables, conventions, or dependencies.
3. **Plan, do not implement.** Do not modify application source code while producing a plan. Only create or update plan documentation unless the user explicitly asks to implement the feature too.
4. **Keep it actionable.** Prefer concrete file paths, component names, API contracts, data shapes, state transitions, acceptance criteria, and test cases over generic advice.
5. **Separate requirements from solutions.** State user-visible behavior and constraints first, then explain the proposed technical design.
6. **Minimize unnecessary files.** Always create `overview.md`. Create other documents based on the feature's complexity, using the templates in `templates/`. Do not create empty or irrelevant documents.
7. **Track uncertainty.** Record unresolved questions, assumptions, risks, and decisions that need confirmation. Do not silently turn guesses into facts.
8. **Respect scope.** Include non-goals and explicit exclusions to prevent scope creep.
9. **Use English.** Write all plan documents in concise, professional English unless the user explicitly requests another language.
10. **Link documents.** `overview.md` is the entry point and must link to every other file in the plan directory.

## Workflow

### 1. Understand the request
Extract the feature goal, target users, desired behavior, constraints, and any acceptance criteria already supplied. If a missing detail materially changes the design, ask a focused question. Otherwise proceed with clearly labeled assumptions.

### 2. Inspect the repository
- Read repository-level agent instructions and relevant project documentation.
- Identify the stack, application entry points, architecture, conventions, and related implementations.
- Inspect relevant tests and test commands.
- Identify likely files to create, update, or avoid.
- Do not scan unrelated directories exhaustively; follow the feature's dependency path.

### 3. Choose the plan location
Use an existing project convention if one exists. Otherwise create:
`docs/feature-plans/<feature-slug>/`

Use a short, lowercase, hyphenated slug. Do not overwrite an unrelated plan. If a plan for the same feature already exists, inspect it and update it deliberately.

### 4. Create `overview.md`
This file is mandatory and must be useful on its own. Include:
- feature name and status;
- summary and problem statement;
- goals and non-goals;
- users and primary use cases;
- high-level proposed solution;
- key behavior and flow;
- scope and dependencies;
- major risks and open questions;
- links to all companion documents;
- implementation phases and definition of done.

### 5. Add supporting documents as needed
Use these files where applicable:
- `requirements.md` — functional requirements, non-functional requirements, acceptance criteria, edge cases.
- `architecture.md` — components, responsibilities, integrations, data flow, API contracts, data model, permissions, and error handling.
- `implementation-plan.md` — ordered, independently verifiable tasks with dependencies, target files, and completion checks.
- `testing.md` — test strategy, test cases, fixtures, automation, and verification commands.
- `decisions.md` — architecture/design decisions, alternatives considered, rationale, and unresolved decisions.
- `rollout.md` — migrations, compatibility, feature flags, deployment, monitoring, and rollback for operationally significant changes.

Do not create a document just to fill a checklist. For small features, keep relevant sections in `overview.md` and create only the documents that add clarity.

### 6. Make the plan implementation-ready
- Reference real paths discovered in the repository; label proposed new paths as **Proposed**.
- For each task, specify the expected result and how to verify it.
- Define acceptance criteria in observable, testable terms.
- Document important failure paths, validation, authorization, and boundary conditions.
- Include backward compatibility, accessibility, security, privacy, performance, and migration considerations when relevant.
- Identify assumptions and open questions explicitly.

### 7. Validate the documentation
Before finishing:
- Ensure all links between plan documents are correct.
- Check for contradictions between overview, requirements, architecture, and tasks.
- Check that every goal maps to acceptance criteria and implementation tasks.
- Check that every major behavior has a verification strategy.
- Check that no unverified repository details are stated as facts.
- Check that the plan does not imply implementation has already happened.

### 8. Report back
Summarize the plan directory and the documents created. Call out important assumptions and unanswered questions. Do not claim tests or implementation were performed unless they actually were.

## Recommended output structure

```text
docs/feature-plans/<feature-slug>/
├── overview.md
├── requirements.md          # when useful
├── architecture.md          # when useful
├── implementation-plan.md   # for multi-step features
├── testing.md               # when test scope warrants it
├── decisions.md             # when decisions or uncertainty matter
└── rollout.md               # for migrations or operational changes
```

## Quality bar

A developer unfamiliar with the conversation should be able to read `overview.md`, follow its links, understand the feature's intended behavior and technical approach, and begin implementation without needing to infer critical requirements. The plan is a proposal, not proof that the design is correct; make uncertainty visible.
