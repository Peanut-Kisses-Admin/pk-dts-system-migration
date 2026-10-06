# PK DTS Full CodeIgniter 3 Migration Design

Date: 2026-10-06
Branch: `migration/codeigniter3`

## Objective

Migrate the complete PK DTS application from the current Angular + NestJS architecture into the existing `pk-dts-ci3/` CodeIgniter 3 application, preserving current user-visible business rules and PostgreSQL compatibility. Migration proceeds continuously in dependency order with a commit after each independently verified module or module group.

## Governing rules

- `main` remains untouched until the migration branch is fully verified.
- Existing `pk-dts-backend/`, `pk-dts-frontend/`, `pk-dts-docker/`, and `portable/` trees remain behavioral/reference sources and are not rewritten during migration.
- PostgreSQL is the target database. The active backend example uses `PRISMA_SCHEMA_PATH=prisma/schema.postgresql.prisma` and a PostgreSQL `DATABASE_URL`.
- Preserve existing table names, IDs, relationships, workflow states, and permissions wherever practical so existing data can be used without destructive conversion.
- Use server-rendered CI3 views plus progressive plain JavaScript. Do not introduce Node/npm as a runtime requirement.
- Use CI3 sessions for authenticated browser sessions; preserve the current username/password login behavior and permission semantics.
- New CI3 code must not expose password hashes, environment secrets, stack traces, backup secrets, or unrestricted file paths.
- Every migrated module gets a contract/smoke test before it is considered complete.
- After each module reaches green verification, commit it before starting the next module.
- No merge to `main` during the continuous migration run.

## Source-of-truth priority

When source files disagree, use this order:

1. current controller/service implementation on `main`
2. current PostgreSQL Prisma schema (`pk-dts-backend/prisma/schema.postgresql.prisma`)
3. current Angular behavior/routes/forms
4. module README files
5. older MySQL Prisma schema only as historical compatibility reference

This matters because some READMEs are stale (for example, auth documentation still describes email login while the current DTO uses `username`).

## Target CI3 architecture

`pk-dts-ci3/` becomes one deployable application:

- `application/controllers/` — request orchestration and permission gates
- `application/models/` — PostgreSQL persistence/query logic grouped by domain
- `application/libraries/` — session auth, permission checks, audit recording, workflow engines, upload/storage services, backup services
- `application/helpers/` — presentation/formatting helpers only
- `application/views/` — layouts and module views
- `assets/` — plain CSS/JS/images with no build pipeline
- `tests/` — CLI contract tests and structural regression tests

Shared concerns are migrated once and reused across modules: authentication, pagination, validation, permissions, audit logs, file storage, response/flash conventions, and transaction handling.

## Migration phases and dependency order

### Phase 1 — application shell, authentication, and RBAC

1. Replace the placeholder page with shared authenticated layout/navigation.
2. Username/password login, logout, current-session user, password verification/change requirement.
3. Roles, permissions, role-permissions, users, and registration requests.
4. Central `MY_Controller` auth/permission gates and audit context.

### Phase 2 — reference/master data

5. Areas.
6. Specifics.
7. Locations.
8. Sequences/system sequence state.
9. Asset numbers.
10. Softcopy categories.
11. System settings.

### Phase 3 — documents and storage

12. Core document create/read/update/list behavior.
13. Hardcopy document metadata and physical-location relationships.
14. Softcopy documents, revisions, attachments, upload/download handling.
15. Document status history and assignments.
16. Document edit/revision request behavior and approver configuration.

### Phase 4 — workflows and work queues

17. Workflow definitions/versioning/publishing.
18. Document workflow execution and approval steps.
19. My Tasks / Work queues derived from assignments/workflow steps.
20. Dashboard counts/summary behavior.

### Phase 5 — access, transfer, and notifications

21. Document access requests, review/approval, and history.
22. Hardcopy transfer requests, approval, acceptance, workflow/history.
23. Notifications and read-state behavior.

### Phase 6 — governance and lifecycle

24. Audit-log capture, filtering, and viewing.
25. Document disposal request/review/final disposal lifecycle.
26. Reports/exports present in the current frontend/backend behavior.
27. Backup/restore, automated backup policy, factory-reset protections.

### Phase 7 — remaining administrative/AI behavior

28. AI assistant functionality that exists in the current DTS and is still reachable/required.
29. Remaining admin/settings screens and parity gaps found by route/API inventory.
30. End-to-end parity cleanup, production hardening, and cutover documentation.

## Data access strategy

CI3 models query the existing PostgreSQL tables directly. The migration does not recreate a parallel schema unless a verified source feature truly requires a new table. Writes that change multiple related records must use transactions. BigInt IDs are handled as strings at browser boundaries and passed safely through CI3/database bindings.

## Authentication and permissions

- Login uses current `username` behavior, not stale email-only documentation.
- Password hashes remain compatible with the hashes already stored by the NestJS application; verification must support the actual current hash format before users are switched over.
- The authenticated user context includes role and effective permissions.
- Controllers call a shared permission gate before sensitive actions.
- Authorization must be enforced server-side even if navigation links/buttons are hidden.

## Audit strategy

Mutating actions produce audit rows compatible with the existing `audit_logs` schema, including actor, role, module, action, method/path, entity ID, before/after state where available, reason/workflow context where relevant, IP, user agent, and timestamp. Audit write failure must not silently grant an otherwise unauthorized action.

## File and upload strategy

Preserve the current logical storage behavior while preventing path traversal and executable uploads. Uploaded files live under controlled runtime directories, are referenced by database rows, and are served only through permission-aware controllers where the existing behavior requires restricted access.

## UI strategy

The Angular UI is migrated to server-rendered CI3 screens while preserving the existing workflow and information architecture, not framework-specific implementation details. Shared shell elements are implemented once: header, drawer/sidebar, breadcrumbs/page title, tables, pagination, filters, forms, confirmation dialogs, alerts, and responsive behavior.

## Verification strategy

Each phase adds CLI contract tests covering its permissions, model contracts, routes, and critical state transitions. GitHub Actions installs CI3, runs all PHP tests/lint, verifies unauthenticated/authenticated route behavior that can run without production credentials, and performs structural checks that legacy source trees remain untouched.

Database-dependent integration tests use an isolated CI PostgreSQL database/schema when practical. Tests must never point at a production database.

## Continuous-commit policy

The migration run uses small commits named by completed capability, for example:

- `feat(ci3): migrate authentication and session guards`
- `feat(ci3): migrate users roles and permissions`
- `feat(ci3): migrate document master data`
- `feat(ci3): migrate document workflows`

A failed module remains uncommitted or receives a follow-up fix commit before the executor proceeds. No partially working module is declared migrated.

## Definition of complete migration

The branch is complete only when:

1. every current backend module reachable from `AppModule` has a CI3 equivalent or an explicitly documented justified retirement;
2. every current Angular user workflow has a CI3 route/view equivalent or documented justified retirement;
3. authentication, permissions, documents, workflows, transfers, disposal, audit, reporting, backup/restore, notifications, and administrative behavior pass migration tests;
4. PostgreSQL data compatibility is verified against the current schema;
5. the CI3 application requires PHP/Composer but no Node/npm at runtime;
6. all branch CI checks pass;
7. legacy source trees remain unchanged;
8. no merge to `main` occurs without an explicit final integration decision.
