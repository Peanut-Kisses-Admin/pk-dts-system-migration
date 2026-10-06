# PK DTS Full CodeIgniter 3 Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Continuously migrate all reachable PK DTS NestJS/Angular functionality into `pk-dts-ci3/`, committing after every independently verified module group until full parity is reached.

**Architecture:** Use one server-rendered CodeIgniter 3 application over the existing PostgreSQL schema. Shared auth/RBAC/audit/layout primitives are built first; master-data modules follow; document/workflow modules build on those primitives; transfer, disposal, reporting, backup, notifications, and remaining parity gaps are migrated last.

**Tech Stack:** PHP 7.4+, CodeIgniter 3.1.13, Composer, PostgreSQL, CI3 sessions, plain JavaScript/CSS, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-10-06-codeigniter3-full-migration-design.md`

## Global Constraints

- Work only on `migration/codeigniter3`; never merge to `main` during execution.
- Preserve `pk-dts-backend/`, `pk-dts-frontend/`, `pk-dts-docker/`, and `portable/` unchanged.
- PostgreSQL and `schema.postgresql.prisma` are the persistence source of truth.
- Current controller/service behavior overrides stale README wording.
- No Node/npm runtime dependency in the migrated app.
- Enforce authorization server-side on every protected action.
- Never render or log passwords, hashes, environment secrets, or unrestricted backup paths.
- Commit only after the task's tests/lint are green; then immediately continue to the next task.

## Review Focus

- Existing password hashes: migrated login must verify the exact hash format already used by NestJS without resetting user passwords.
- BigInt identifiers: all form/URL/API boundaries must preserve values as strings and avoid PHP/JS truncation.
- Workflow concurrency: approval/transfer/disposal state transitions must reject stale or duplicate actions transactionally.
- File access: uploads/downloads/backups must prevent path traversal and unauthorized direct access.
- Authorization drift: hidden UI controls must never be the only permission enforcement.

---

### Task 1: Shared CI3 application shell and security primitives

**Produces:** shared layouts, navigation, flash/error components, pagination helper, `MY_Controller` authenticated/permission guards, audit context library, common validation/security helper.

- [ ] Add failing structural/security contract tests.
- [ ] Implement shared layout/navigation using plain CSS/JS.
- [ ] Add reusable pagination/filter conventions matching current list endpoints (default 10, cap 100).
- [ ] Implement controller helpers for `require_login()` and `require_permission()` without module-specific behavior.
- [ ] Run all CI3 tests and PHP lint.
- [ ] Commit `feat(ci3): add application shell and security primitives`.

### Task 2: Authentication and current-user session

**Produces:** login/logout/current-user/password-change support compatible with current username login and stored hashes.

- [ ] Capture current NestJS login/password/session rules in contract tests.
- [ ] Implement `User_model` auth lookup and password verification.
- [ ] Implement login/logout/session regeneration/current-user context.
- [ ] Implement required-password-change behavior if reachable in current UI.
- [ ] Verify invalid login, disabled/missing user, session fixation resistance, and `/auth/me` equivalent behavior.
- [ ] Commit `feat(ci3): migrate authentication and sessions`.

### Task 3: Users, roles, permissions, registrations

**Produces:** users, roles, permissions, role-permissions, registration requests, permission-aware admin screens.

- [ ] Migrate current CRUD/list/filter contracts and validation.
- [ ] Preserve role/permission relationships and unique constraints.
- [ ] Implement registration review/assignment status transitions.
- [ ] Add server-side permission gates and audit events.
- [ ] Run domain tests/lint.
- [ ] Commit `feat(ci3): migrate users roles permissions and registrations`.

### Task 4: Master/reference data

**Produces:** areas, specifics, locations, sequences/system sequence state, asset numbers, softcopy categories, system settings.

- [ ] Migrate CRUD/list/archive behavior per current services.
- [ ] Preserve dependencies and delete/archive restrictions.
- [ ] Add pagination/search/filtering where current API supports it.
- [ ] Run master-data tests/lint.
- [ ] Commit `feat(ci3): migrate document reference data`.

### Task 5: Core documents

**Produces:** document list/view/create/update/status history/assignment behavior and shared document model.

- [ ] Map current Document fields/enums from PostgreSQL schema and service behavior.
- [ ] Implement permission-aware list/detail/create/update flows.
- [ ] Implement assignments and status-history writes transactionally.
- [ ] Preserve edit-request/source-document relationships.
- [ ] Add document forms/views and current validation rules.
- [ ] Run document tests/lint.
- [ ] Commit `feat(ci3): migrate core document tracking`.

### Task 6: Hardcopy and softcopy document storage

**Produces:** hardcopy location metadata, softcopy document records, revisions, attachments, upload/download protections.

- [ ] Migrate hardcopy area/specific/location/sequence/asset relationships.
- [ ] Migrate softcopy categories, revisions, attachment approval/rejection state.
- [ ] Implement controlled upload storage and permission-aware download.
- [ ] Test traversal rejection, file metadata, and unauthorized access.
- [ ] Commit `feat(ci3): migrate document storage and attachments`.

### Task 7: Workflow definitions and document approval engine

**Produces:** workflow definitions, versions, publish lifecycle, workflow snapshots, document workflow steps, approver configuration.

- [ ] Migrate definition/version CRUD and publish rules.
- [ ] Implement execution state machine against current workflow rows/snapshots.
- [ ] Make approval/rejection actions transactional and idempotency-safe.
- [ ] Add workflow admin and document approval views.
- [ ] Run workflow tests/lint.
- [ ] Commit `feat(ci3): migrate document workflow engine`.

### Task 8: My Tasks / Work queues and dashboard

**Produces:** user work queues and dashboard metrics built from migrated assignments/workflows.

- [ ] Reproduce current task ownership/visibility queries.
- [ ] Reproduce dashboard summaries/counts.
- [ ] Add pagination/filtering and permission-aware navigation.
- [ ] Run queue/dashboard tests/lint.
- [ ] Commit `feat(ci3): migrate work queues and dashboard`.

### Task 9: Document access requests

**Produces:** request/review/approval/history flows.

- [ ] Migrate list/create/review/approve rules and histories.
- [ ] Preserve requester/reviewer/approver identity and status transitions.
- [ ] Add notification/audit hooks.
- [ ] Run access-request tests/lint.
- [ ] Commit `feat(ci3): migrate document access requests`.

### Task 10: Hardcopy transfers

**Produces:** transfer request, approval, recipient acceptance, transfer workflow steps/history, destination metadata updates.

- [ ] Migrate transfer creation/validation.
- [ ] Migrate approval and workflow rules.
- [ ] Implement acceptance/final location change transactionally.
- [ ] Reject stale/duplicate transfer actions.
- [ ] Run transfer tests/lint.
- [ ] Commit `feat(ci3): migrate hardcopy transfer workflow`.

### Task 11: Notifications and audit logs

**Produces:** notification feed/read state and full audit log capture/view/filter behavior.

- [ ] Migrate notification event/read queries.
- [ ] Implement central mutation audit recorder compatible with existing schema.
- [ ] Add audit filtering/detail screens and permissions.
- [ ] Run audit/notification tests/lint.
- [ ] Commit `feat(ci3): migrate notifications and audit logs`.

### Task 12: Disposal lifecycle

**Produces:** disposal request/review/final disposition and document status restoration/finalization rules.

- [ ] Migrate current disposal statuses/actions and reviewer rules.
- [ ] Preserve `status_before_disposal` behavior.
- [ ] Make approval/rejection/finalization transactional.
- [ ] Run disposal tests/lint.
- [ ] Commit `feat(ci3): migrate document disposal lifecycle`.

### Task 13: Reports and exports

**Produces:** all report/export routes reachable in current UI/backend.

- [ ] Inventory current report/export entry points.
- [ ] Migrate filters, data sets, and downloadable output without introducing Node tooling.
- [ ] Verify permissions and no secret/internal fields leak.
- [ ] Run report tests/lint.
- [ ] Commit `feat(ci3): migrate reports and exports`.

### Task 14: Backup, restore, automation, factory reset

**Produces:** protected PostgreSQL backup/restore administration and automation parity.

- [ ] Inventory current backup types/schedules/retention/restore/factory-reset safeguards.
- [ ] Implement command execution with strict path/argument validation and protected storage.
- [ ] Require explicit high-privilege permission and confirmation for destructive operations.
- [ ] Test invalid path/backup/archive and authorization failures before destructive happy paths.
- [ ] Commit `feat(ci3): migrate backup restore administration`.

### Task 15: Remaining AI/admin capabilities and parity sweep

**Produces:** any currently reachable AI assistant/admin behavior not already covered and an explicit parity ledger.

- [ ] Inventory Angular routes/navigation and backend modules against CI3 routes.
- [ ] Migrate still-reachable AI/admin capabilities that remain product requirements.
- [ ] Document justified retirements only when the original capability is genuinely unreachable/obsolete.
- [ ] Run full test suite and route parity checks.
- [ ] Commit `feat(ci3): complete remaining DTS feature parity`.

### Task 16: Production/cutover hardening

**Produces:** final CI, migration/cutover guide, rollback guide, and branch-level acceptance evidence.

- [ ] Run every PHP contract/integration test and lint on PHP 7.4.
- [ ] Run isolated PostgreSQL integration tests where database behavior is required.
- [ ] Verify no legacy source tree changed.
- [ ] Verify all routes require expected authentication/permissions.
- [ ] Verify upload/backup directories and production error settings.
- [ ] Produce parity/cutover/rollback documentation.
- [ ] Commit `chore(ci3): finalize full DTS migration verification`.

## Execution policy

This plan is executed natively and continuously under the user's explicit instruction. The executor does not pause between tasks. It stops only for an irreversible/destructive operation against real data, a security-sensitive external action, or a plan defect that makes safe behavior unknowable. Merge to `main` is not part of this execution plan.
