# Testing Strategy: <Feature Name>

## Test Objectives

<What must be proven for this feature to be considered reliable?>

## Test Levels

| Level | Scope | Tool/command | Required coverage |
|---|---|---|---|
| Unit | <Pure logic and boundaries> | <Known project command> | <Cases> |
| Integration | <Database, API, services> | <Known project command> | <Cases> |
| End-to-end | <Critical user journeys> | <Known project command> | <Cases> |
| Manual | <Visual, operational, or hard-to-automate checks> | <Steps> | <Cases> |

Use commands discovered in the repository. If unknown, label them “To be confirmed” rather than inventing them.

## Test Cases

| ID | Scenario | Setup | Action | Expected result | Level |
|---|---|---|---|---|---|
| TEST-001 | Happy path | <Setup> | <Action> | <Expected> | <Level> |
| TEST-002 | Invalid input | <Setup> | <Action> | <Expected> | <Level> |
| TEST-003 | Unauthorized access | <Setup> | <Action> | <Expected> | <Level> |
| TEST-004 | Dependency failure | <Setup> | <Action> | <Expected> | <Level> |

## Fixtures and Test Data

<Required fixtures, factories, mocks, seed data, cleanup, and privacy considerations.>

## Regression Risks

<Existing behaviors likely to be affected and tests that protect them.>

## Verification Commands

```bash
# Replace with commands verified from the repository.
```

## Exit Criteria

- [ ] All critical acceptance criteria have tests or documented manual verification.
- [ ] Relevant existing regression tests pass.
- [ ] No known critical test gaps remain without explicit sign-off.
