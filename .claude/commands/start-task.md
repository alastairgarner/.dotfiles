---
description: Start a new task with requirements gathering
---

## New Task: $ARGUMENTS

Before writing any code, help me think through the requirements for this task.

## Phase 1: Requirements Gathering

Ask me clarifying questions to understand:

- What exactly needs to be built
- Scope and boundaries (what's in/out)
- Expected behavior and edge cases
- How we'll know it's done (acceptance criteria)

Ask questions one or two at a time. Don't overwhelm me.

## Phase 2: Write the Spec

Once we've discussed enough, write a spec to `.opencode/specs/<task-name>.md` with:

- **Summary**: One sentence
- **Requirements**: Numbered list of specific things to build
- **Acceptance Criteria**: How to verify each requirement is met
- **Files to Modify**: Which files need changes (explore the codebase first)
- **Open Questions**: Anything unresolved

## Phase 3: Implementation

Only after I approve the spec, proceed to implementation.

During implementation:

- Work through requirements methodically
- After completing significant chunks, ask @review to check the code
- Address review feedback before continuing

Do NOT write any code until I explicitly approve the spec.
