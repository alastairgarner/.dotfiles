---
name: write-tests
description: Writes unit and integration tests in TypeScript projects using Jest. Use when user says "write tests", "add tests", "test this", or "/write-tests".
---

## What I do

I help write Jest tests that follow this codebase's conventions. I can:

- Write unit tests for pure functions and utilities
- Write integration tests for database operations and API routes
- Add tests to existing test files
- Generate properly structured test cases with appropriate mocks and fixtures

## When to use me

- When you need tests for a new function or module
- When you want to add test coverage to existing code
- When you're unsure about the testing patterns used in this codebase
- Invoke with `/write-tests path/to/file.ts` or just `/write-tests` and I'll ask what to test

## When not to use me

- For E2E tests (use Cypress instead)
- For frontend component tests (different patterns apply)
- When you just want to run existing tests (use `npm test` directly)

---

## Usage

```
/write-tests                           # I'll ask what you want to test
/write-tests src/services/user.ts      # Test a specific file
/write-tests functionName              # Test a specific function
```

---

## Workflow

### Step 1: Identify Target

1. Parse user input for file path or function name
2. If not provided, use `AskUserQuestion` to ask what they want to test
3. Read the source file to understand:
   - Exported functions and their signatures
   - Dependencies and imports
   - Database/external service usage

### Step 2: Determine Test Type

Auto-detect based on the code being tested:

| Code Pattern                                       | Test Type       | Rationale                         |
| -------------------------------------------------- | --------------- | --------------------------------- |
| Pure functions, no imports from models/services    | Unit            | No side effects, fast tests       |
| Database operations (Model.find, Model.save, etc.) | Integration     | Requires test database            |
| Express route handlers                             | Integration     | Requires request/response mocking |
| Functions calling external APIs                    | Unit with mocks | Mock external dependencies        |
| Utility functions, validators, formatters          | Unit            | Pure logic, no dependencies       |

### Step 3: Check for Existing Tests

1. Look for existing test files:
   - `{filename}.unit.test.ts`
   - `{filename}.integration.test.ts`
2. If found, read the existing file to:
   - Understand current test structure
   - Identify existing coverage
   - Match the existing patterns
3. Plan to add new tests to the existing `describe` block or create a new one

### Step 4: Generate Tests

Follow these codebase conventions strictly:

**File Naming:**

- Unit tests: `{name}.unit.test.ts`
- Integration tests: `{name}.integration.test.ts`

**Test Structure:**

```typescript
describe('functionName', () => {
  // For integration tests, include database lifecycle
  beforeAll(async () => {
    await connectDatabase();
  });

  afterEach(async () => {
    await clearDatabase();
  });

  afterAll(async () => {
    await closeDatabase();
  });

  it('should do X when Y', async () => {
    // Arrange
    const input = createTestInput();

    // Act
    const result = await functionUnderTest(input);

    // Assert
    expect(result).toEqual(expectedOutput);
  });

  // Use it.each for parameterized tests
  it.each([
    ['input1', 'expected1'],
    ['input2', 'expected2'],
  ])('should return %s when given %s', (input, expected) => {
    // Arrange & Act
    const result = functionUnderTest(input);

    // Assert
    expect(result).toBe(expected);
  });
});
```

**Key Rules:**

- Use `it` (not `test`) for test cases
- Always include `// Arrange`, `// Act`, `// Assert` comments
- Never use `any` type - properly type all test data
- Use `jest.mocked()` for typed mock access
- Clear mocks in `beforeEach` when testing with mocks

### Step 5: Present and Refine

1. Show the generated tests to the user
2. Offer options:
   - Add more test cases
   - Add edge case coverage
   - Modify existing tests
3. Write tests to file when user approves

---

## Codebase Conventions Reference

### Imports for Integration Tests

```typescript
import {
  clearDatabase,
  closeDatabase,
  connectDatabase,
} from '../../../__tests__/utils/testDatabase';
```

Adjust the relative path based on file location.

### Available Test Fixtures

From `apps/api/__tests__/utils/testDatabase.ts`:

| Fixture                                     | Description                       |
| ------------------------------------------- | --------------------------------- |
| `loadBasicUserFixture()`                    | Basic consumer user               |
| `loadBasicUserWithKYC()`                    | User with KYC verification passed |
| `loadUserWithStripePaymentDetailsFixture()` | User with payment setup           |
| `loadBasicGLP1UserFixture()`                | GLP1 medication programme user    |
| `loadHealthCoachFixture()`                  | Health coach/mentor user          |
| `loadBasicSuperAdminUserFixture()`          | Admin user                        |

From `apps/api/__tests__/utils/testHelpers.ts`:

| Helper                  | Description                              |
| ----------------------- | ---------------------------------------- |
| `generateTestIds(n)`    | Generate n unique MongoDB ObjectIds      |
| `generateUniqueEmail()` | Generate unique email for test isolation |

### Plan Fixtures

```typescript
import {
  loadCoreGBPlan,
  loadGlp1Plan,
} from '../../../__tests__/utils/testDatabase';
```

### Mocking Patterns

**Module Mock:**

```typescript
jest.mock('./dependency');

// In test
const mockDependency = jest.mocked(dependency);
mockDependency.someFunction.mockResolvedValue(result);
```

**Partial Mock:**

```typescript
jest.mock('./module', () => ({
  ...jest.requireActual('./module'),
  functionToMock: jest.fn(),
}));
```

**Clear Mocks:**

```typescript
beforeEach(() => {
  jest.clearAllMocks();
});
```

**Mock Return Values:**

```typescript
mockFunction.mockReturnValue(value); // Sync
mockFunction.mockResolvedValue(value); // Async success
mockFunction.mockRejectedValue(new Error()); // Async error
```

### Testing Error Cases

```typescript
it('should throw error when input is invalid', async () => {
  // Arrange
  const invalidInput = null;

  // Act & Assert
  await expect(functionUnderTest(invalidInput)).rejects.toThrow(
    'Expected error message',
  );
});
```

### Testing with MongoDB Models

```typescript
it('should create a new document', async () => {
  // Arrange
  const userData = {
    email: generateUniqueEmail(),
    firstName: 'Test',
  };

  // Act
  const user = await UserModel.create(userData);

  // Assert
  expect(user._id).toBeDefined();
  expect(user.email).toBe(userData.email);
});
```

---

## Common Patterns by Area

### API Route Tests

- Mock authentication middleware
- Use supertest for HTTP assertions
- Test success and error responses

### Service Function Tests

- Mock database models for unit tests
- Use real database for integration tests
- Test all branches and error paths

### Validation Tests

- Use `it.each` for multiple validation scenarios
- Test required fields, optional fields, invalid values
- Check error messages match expectations

---

## Guidelines

1. **Prefer integration tests** for code that touches the database - they catch real issues
2. **Use unit tests** for pure business logic and utilities - they run fast
3. **Always test error paths** - not just the happy path
4. **Use descriptive test names** - they serve as documentation
5. **Keep tests focused** - one logical assertion per test
6. **Use fixtures** - don't recreate test data manually each time
