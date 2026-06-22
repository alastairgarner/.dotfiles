---
name: prd-to-issues
description: Break a PRD into independently-grabbable tasks using tracer-bullet vertical slices. Use when user wants to convert a PRD to tasks, create implementation tickets, or break down a PRD into work items.
---

# PRD to Tasks

Break a PRD into independently-grabbable tasks using vertical slices (tracer bullets).

## Output

- **Path:** `.local/{date}-tasks-{feature-name}.md`
- **Date format:** `YYYY-MM-DD`
- **Feature name:** kebab-case, matching the corresponding PRD file

## Process

### 1. Locate the PRD

Ask the user which PRD to break down. It may be:
- A `.local/*-prd-*.md` file in the current repo
- Already in your context window from a previous step

Read the PRD if it's not already in context.

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code.

### 3. Draft vertical slices

Break the PRD into **tracer bullet** tasks. Each task is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

Slices may be 'HITL' or 'AFK'. HITL slices require human interaction, such as an architectural decision or a design review. AFK slices can be implemented and merged without human interaction. Prefer AFK over HITL where possible.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which user stories from the PRD this addresses

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?
- Are the correct slices marked as HITL and AFK?

Iterate until the user approves the breakdown.

### 5. Write the task file

Write the task file to the output path. The file has two parts:

1. **Summary table** at the top for quick scanning
2. **Detailed sections** below for each task

Use the template below.

## Status Lifecycle

When working on tasks (or spinning up agents to work on them), update the status field:

```
Not Started → In Progress → Done / Blocked
```

Mark a task `In Progress` when it is picked up, and `Done` or `Blocked` when work finishes. This keeps the file useful as a dashboard between conversations.

## Task File Template

````markdown
# Tasks: {Feature Name}

**PRD:** `.local/{date}-prd-{feature-name}.md`
**Created:** {YYYY-MM-DD}

## Summary

| # | Task | Type | Status | Blocked by |
|---|------|------|--------|------------|
| 1 | {Title} | AFK | Not Started | — |
| 2 | {Title} | HITL | Not Started | 1 |
| 3 | {Title} | AFK | Not Started | 1 |

---

## Task 1: {Title}

**Type:** AFK
**Status:** Not Started
**Blocked by:** None — can start immediately

### What to build

A concise description of this vertical slice. Describe the end-to-end behaviour, not layer-by-layer implementation. Reference specific sections of the parent PRD rather than duplicating content.

### Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### User stories addressed

Reference by number from the parent PRD:

- User story 3
- User story 7

---

## Task 2: {Title}

...
````
