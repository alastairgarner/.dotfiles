---
name: mongoose-docs
description: >
  Fetch up-to-date Mongoose documentation before writing or reviewing
  MongoDB queries. Use when writing Mongoose queries, debugging query
  behavior, or typing Mongoose operations. Triggers on "mongoose docs",
  "check mongoose", "mongoose typing".
---

# Mongoose Documentation Lookup

Fetch current Mongoose documentation to verify API behavior before writing or reviewing queries.

## When to use

- You're unsure about current Mongoose API behavior (method signatures, options, return types)
- The user corrects you or questions your understanding of Mongoose
- You're writing a complex query and want to verify the approach
- TypeScript typing for Mongoose operations is unclear
- You need to check migration/deprecation notes

**Don't fetch docs for basic operations you're confident about** — this is for when you need to verify.

## How to use

1. Identify which topic area is relevant
2. Use `WebFetch` to fetch the appropriate page(s) from the index below
3. Base URL: `https://mongoosejs.com/docs/8.x`
4. Extract the specific information you need, then proceed

**Important:** We use Mongoose v8, not the latest. All doc URLs use the `/docs/8.x/` prefix.

## Documentation Index

### Core Concepts

| Topic | Path |
|-------|------|
| Schemas | /docs/8.x/docs/guide.html |
| SchemaTypes | /docs/8.x/docs/schematypes.html |
| Models | /docs/8.x/docs/models.html |
| Documents | /docs/8.x/docs/documents.html |
| Subdocuments | /docs/8.x/docs/subdocs.html |
| Connections | /docs/8.x/docs/connections.html |

### Querying & Data

| Topic | Path |
|-------|------|
| Queries | /docs/8.x/docs/queries.html |
| Population (joins) | /docs/8.x/docs/populate.html |
| Validation | /docs/8.x/docs/validation.html |
| Middleware (hooks) | /docs/8.x/docs/middleware.html |
| Transactions | /docs/8.x/docs/transactions.html |
| Lean queries | /docs/8.x/docs/tutorials/lean.html |
| Discriminators | /docs/8.x/docs/discriminators.html |
| GeoJSON | /docs/8.x/docs/geojson.html |

### API Reference

| Topic | Path |
|-------|------|
| Model API | /docs/8.x/docs/api/model.html |
| Query API | /docs/8.x/docs/api/query.html |
| Aggregate API | /docs/8.x/docs/api/aggregate.html |
| Document API | /docs/8.x/docs/api/document.html |
| Schema API | /docs/8.x/docs/api/schema.html |
| Connection API | /docs/8.x/docs/api/connection.html |
| SchemaType API | /docs/8.x/docs/api/schematype.html |
| VirtualType API | /docs/8.x/docs/api/virtualtype.html |

### TypeScript

| Topic | Path |
|-------|------|
| TypeScript guide | /docs/8.x/docs/typescript.html |

### Tutorials

| Topic | Path |
|-------|------|
| findOneAndUpdate | /docs/8.x/docs/tutorials/findoneandupdate.html |
| Query casting | /docs/8.x/docs/tutorials/query_casting.html |
| Getters & setters | /docs/8.x/docs/tutorials/getters-setters.html |
| Virtuals | /docs/8.x/docs/tutorials/virtuals.html |
| Dates | /docs/8.x/docs/tutorials/dates.html |
| Custom casting | /docs/8.x/docs/tutorials/custom-casting.html |

### Operations & Migration

| Topic | Path |
|-------|------|
| Jest testing | /docs/8.x/docs/jest.html |
| Deprecations | /docs/8.x/docs/deprecations.html |
| Migrate to v9 | /docs/8.x/docs/migrating_to_9.html |
| Migrate to v8 | /docs/8.x/docs/migrating_to_8.html |
| Next.js integration | /docs/8.x/docs/nextjs.html |
| Plugins | /docs/8.x/docs/plugins.html |
