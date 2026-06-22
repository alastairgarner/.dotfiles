---
name: build-requirements
description: Build a thorough requirements document for a feature or task through structured questioning. Use when starting new work, scoping a feature, or when user says "build requirements", "requirements", or "/requirements".
user-invokable: true
---

# Build Requirements Document

Build a comprehensive requirements document through iterative questioning. The goal is to produce a clear, unambiguous spec that defines **what** needs to be built and **why**, without prescribing **how**.

## Output

- **Path:** `.local/{date}-req-{feature-name}.md`
- **Date format:** `YYYY-MM-DD`
- **Feature name:** kebab-case, derived from the feature description

## Process

### Phase 1: Gather Initial Context

1. Listen to the user's description of the feature/task
2. If they reference external sources, read them:
   - **Shortcut ticket:** Use the Shortcut MCP tools to fetch the story
   - **Slite doc:** Use the Slite MCP tools to fetch the document
   - **Local file:** Read the file directly
   - **URL:** Fetch and extract relevant content
3. Summarise back what you understand so far, clearly stating any assumptions

### Phase 2: Clarify Before Writing

Before writing anything, identify gaps in your understanding and ask the user clarifying questions.

**Key areas to probe:**

- **Users:** Who is affected? All user types or specific ones? What about admin/coach users?
- **Current behaviour:** What happens today? What's broken or missing?
- **Business rules:** What are the exact conditions, thresholds, triggers?
- **Edge cases:** What if the data is missing? What if the user is in an unexpected state? What about timing/race conditions?
- **Failure modes:** What should happen when things go wrong? What errors should the user see?
- **Scope boundaries:** What explicitly is NOT part of this work? What's a follow-up?
- **Dependencies:** Does this rely on other systems, services, or features? Are there ordering constraints?
- **Observability:** How will we know this is working in production? Do we need logging, metrics, alerts?
- **Rollout:** Is this behind a feature flag? Does it need a migration? Is there a rollback plan?

Don't ask all of these at once. Work through them naturally based on what's unclear from the initial context. Group related questions together — aim for 2-4 questions per round. Continue asking until you're confident the first draft will be substantive rather than full of `[TBD]` placeholders.

Use `AskUserQuestion` for structured choices where appropriate, but prefer conversational follow-ups for open-ended questions.

### Phase 3: Generate First Draft

Once you have sufficient clarity, write the requirements document using the template below. Fill in what you can from the gathered context. Any remaining unknowns should be few and clearly marked as `[TBD]`.

Write the draft to the output path so the user can see the full picture, then ask if anything needs adjusting.

### Phase 4: Finalise

Once the requirements feel complete:

1. Update the requirements document with all gathered information
2. Remove any remaining `[TBD]` placeholders (or explicitly call them out as deliberate open questions)
3. Ask the user to review the final document
4. Iterate on any feedback until the user is satisfied

## Requirements Document Template

```markdown
# {Feature Name}

**Date:** {YYYY-MM-DD}
**Status:** Draft | Review | Approved

## Summary

{One paragraph: what is being built and why. Focus on the problem being solved and the outcome, not the implementation.}

## Background

{Context that someone unfamiliar with this area would need. Why now? What's the current state? Link to any relevant Shortcut tickets, Slite docs, or other references.}

## User Stories

{Who needs what, and why. Use the format:}

- As a {user type}, I want {capability} so that {benefit}

## Requirements

### Functional Requirements

{Specific behaviours the system must exhibit. Be precise and testable.}

- [ ] {Requirement 1}
- [ ] {Requirement 2}

### Non-Functional Requirements

{Performance, security, accessibility, compatibility constraints. Only include if relevant.}

- [ ] {Requirement}

## Acceptance Criteria

{Concrete, testable conditions that must be true for this to be considered done. Use Given/When/Then where it adds clarity.}

1. {Criterion 1}
2. {Criterion 2}

## Edge Cases

{Scenarios that could cause unexpected behaviour. What happens when...}

| Scenario    | Expected Behaviour   |
| ----------- | -------------------- |
| {Edge case} | {What should happen} |

## Out of Scope

{Explicitly list what this work does NOT include, to prevent scope creep.}

- {Thing that might seem related but isn't part of this}

## Open Questions

{Anything still unresolved that needs input from others or further investigation.}

- {Question}

## References

{Links to Shortcut tickets, Slite docs, designs, or other relevant materials.}
```

## Guidelines

- Keep the language precise. Avoid weasel words like "should probably", "might need to", "ideally".
- Every requirement should be testable. If you can't write a test for it, it's too vague.
- Don't include implementation details in the requirements doc. No file paths, no code snippets, no "use this library". That comes later.
- If the user starts going into implementation details, acknowledge them but redirect back to requirements. Implementation decisions happen after requirements are agreed.
- Be persistent about edge cases. Most bugs come from unconsidered edge cases.
- It's OK to push back on the user if something doesn't make sense or seems contradictory.
