# PK DTS CodeIgniter 3 Migration Map

The `migration/codeigniter3` branch introduces a separate `pk-dts-ci3/` application while preserving the existing DTS implementation. This document records migration order only; it does not mark any DTS feature as migrated.

## Current state

- CodeIgniter 3 foundation: setup target
- PostgreSQL: configured as the future database target, not required by the placeholder page
- Sessions: file-backed initially
- Existing NestJS, Angular, Docker, and portable trees: retained as-is
- Business modules migrated: none

## Approved module order

1. Shared layout and navigation
2. Authentication and user session handling
3. Users, roles, and permissions
4. Core document records and document metadata
5. Document tracking and workflow actions
6. My Tasks / Work queues
7. Hardcopy transfer
8. Audit and activity logs
9. Reports
10. Disposal workflow
11. Backup and restore administration
12. AI-related capabilities, only after the core DTS is stable

Each module should receive its own design, tests, migration notes, and verification criteria before implementation. Existing DTS behavior remains the reference unless a later approved design explicitly changes a rule.

## Data safety

Do not reshape or destructively migrate production data merely to simplify the CI3 rewrite. Schema and data changes must be reviewed independently, remain backward-aware during the transition, and include a rollback or restore path before production use.

## Cutover

No cutover is authorized by this setup. The CI3 application remains isolated until the migrated modules reach parity and a separate cutover plan is approved.
