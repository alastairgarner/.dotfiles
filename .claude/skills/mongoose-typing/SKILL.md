---
name: mongoose-typing
description: Type Mongoose queries, schemas, and documents correctly. Use when writing or modifying Mongoose queries, defining schemas, or typing function parameters that accept documents. Triggers on "type this query", "mongoose types", "schema typing", or any Mongoose model/query work.
---

# Mongoose Typing Guide

Reference for correctly typing Mongoose schemas, documents, and queries in this codebase.

## Query Typing Patterns

### Pattern 1: `.select()` — use `DocumentSelect`

When you call `.select()` and need Document methods:

```typescript
const USER_FIELDS = ['_id', 'email', 'programmes'] satisfies (keyof UserData)[];

const user: DocumentSelect<UserDocument, (typeof USER_FIELDS)[number]> =
  await User.findOne({ _id: userId })
    .select(USER_FIELDS)
    .orFail(new NotFoundError({ message: 'User not found' }));
```

**Pattern:** Use `satisfies (keyof Data)[]` to validate field names at compile time while preserving literal types. Derive the union type with `(typeof FIELDS)[number]`.

### Pattern 2: `.select().lean()` — use `Pick<Data, K>`

When you call `.lean()`, the result is a plain object (no Document methods). Use `Pick` on the **Data** type, not the Document type. Define fields once with a const array and `satisfies`, then derive the Pick type:

```typescript
const USER_FIELDS = ['_id', 'email'] satisfies (keyof UserData)[];

const users: Pick<UserData, (typeof USER_FIELDS)[number]>[] =
  await User.find(query)
    .select(USER_FIELDS)
    .lean();
```

**Key distinction:** `DocumentSelect` for documents with methods, `Pick<Data>` for `.lean()` plain objects.

### Pattern 3: `.populate()` — use generic type parameter

Mongoose's `.populate()` accepts a generic to type the populated field:

```typescript
const assessments = await Assessment.find({ user: userId })
  .populate<{
    assessor: Pick<UserData, '_id' | 'email' | 'firstName'>;
  }>('assessor', '_id email firstName')
  .populate<{ plan: PlanData }>('plan')
  .lean();

// assessments[0].assessor.email — OK, typed as string
// assessments[0].plan.name — OK, typed correctly
```

**Chain multiple `.populate<>()` calls** — TypeScript intersects the generic parameters.

### Pattern 4: `.populate()` on function parameters — use `Replace`

When typing a function parameter that receives an already-populated document:

```typescript
const processGroup = (
  group: Replace<GroupDocument, { users: UserDocument[] }>,
) => {
  group.users[0].email; // OK
  group.title; // OK
};
```

### Pattern 5: `.aggregate()` — define a result type

Aggregation pipelines return plain objects. Define the shape explicitly:

```typescript
type CoachWithCapacity = {
  _id: string;
  email: string;
  activeMentoredGroups: number;
  hasNewGroupCapacity: boolean;
};

const coaches: CoachWithCapacity[] = await User.aggregate([
  { $match: { mentor: true } },
  { $project: { email: 1, activeMentoredGroups: 1 } },
  // ...
]);
```

### Pattern 6: Full Document — no projection

When no `.select()` is used, the query returns the full Document type:

```typescript
const user: UserDocument = await User.findById(id).orFail(
  new NotFoundError({ message: 'User not found' }),
);
```

---

## Decision Table

| Query Shape                               | Return Type                               | Utility            |
| ----------------------------------------- | ----------------------------------------- | ------------------ |
| `Model.find(query)`                       | `ThingDocument[]`                         | None needed        |
| `Model.find(query).select(fields)`        | `DocumentSelect<ThingDocument, K>`        | `DocumentSelect`   |
| `Model.find(query).select(fields).lean()` | `Pick<ThingData, K>[]`                    | `Pick`             |
| `Model.find(query).lean()`                | `ThingData[]`                             | None (or explicit) |
| `Model.find(query).populate(field)`       | Chain `.populate<{ field: Type }>()`      | Generic parameter  |
| Function param with populated doc         | `Replace<ThingDocument, { field: Type }>` | `Replace`          |
| `Model.aggregate(pipeline)`               | Define explicit result type               | None               |
