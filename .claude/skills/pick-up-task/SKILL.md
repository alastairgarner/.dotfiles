---
name: pick-up-task
description: Pick up a task from a local task file and implement it. Use when user wants to start working on a task, pick up a slice, or says "pickup task".
user-invokable: true
---

# Pick Up Task

Pick up a scoped task and implement it.

## Process

### 1. Identify the task

If `$ARGUMENTS` specifies a task number and/or task file, use that.

Otherwise:

1. Look for `.local/*-tasks-*.md` files in the current repo
2. If there are multiple task files, ask the user which one
3. Show the summary table from the task file, highlighting tasks that are `Not Started` and unblocked
4. Ask the user which task to pick up

If no task file exists, the user can describe a custom task instead. In that case, skip the status update steps below.

### 2. Mark In Progress

Update the task's status to `In Progress` in both the summary table and the detailed section of the task file.

### 3. Read the PRD

If the task file references a parent PRD, read it for full context. Understand the broader feature before diving into this slice.

### 4. Explore the codebase

Explore the relevant parts of the codebase to understand what needs to change. Don't start writing code until you have a clear picture.

### 5. Implement

Work through the acceptance criteria methodically. Keep changes focused on this task's slice — don't drift into other tasks or unrelated improvements.

If you hit a blocker or need a decision that isn't covered by the PRD or task description, stop and ask the user rather than guessing.

### 6. Wrap up

When implementation is complete:

1. Update the task's status to `Done` in both the summary table and the detailed section
2. Summarise what was built and any decisions made during implementation
3. Note anything the user should pay attention to during review
4. If any follow-up work was discovered, mention it but don't act on it

Do NOT create branches, commits, or PRs — the user handles git themselves.
