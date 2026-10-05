# PK DTS CodeIgniter 3 Migration Setup Design

Date: 2026-10-06
Branch: `migration/codeigniter3`

## Objective

Create an isolated CodeIgniter 3 migration foundation for PK DTS without changing the existing `main` implementation and without migrating DTS features yet.

The current NestJS backend, Angular frontend, Docker stack, and related runtime files remain preserved. This branch establishes the structure that later migration work can target.

## Scope for this stage

This stage is setup only.

Included:

- CodeIgniter 3 application foundation
- PostgreSQL-ready database configuration
- environment-driven configuration pattern
- base controller and base model conventions
- application routes
- session configuration
- reusable helpers/libraries directories
- assets directories for CSS, JavaScript, and images
- writable/runtime directories required by the application
- minimal DTS placeholder page used only to verify the CI3 application boots
- migration documentation describing how the current architecture will map to CI3 later

Explicitly excluded:

- authentication implementation
- user, role, or permission migration
- document tracking workflows
- My Tasks / Work modules
- document transfer and hardcopy transfer logic
- disposal module
- workflow builder
- audit/activity log migration
- backup/restore implementation
- AI assistant integration
- reports
- production data migration
- removal of the existing NestJS or Angular applications
- merging this branch into `main`

## Architecture direction

Use one CodeIgniter 3 application for the eventual server-rendered DTS application instead of recreating the current separate Angular frontend and NestJS backend split.

This is intentional because the migration goal is to reduce the project's Node/npm dependency and make local deployment simpler. The existing Angular and NestJS applications remain in the repository during migration so features can be ported incrementally and compared against the current system.

The CI3 application should be introduced in a new top-level directory:

```text
pk-dts-ci3/
```

The current directories remain untouched:

```text
pk-dts-backend/
pk-dts-frontend/
pk-dts-docker/
portable/
```

## Proposed CI3 structure

```text
pk-dts-ci3/
├── application/
│   ├── cache/
│   ├── config/
│   ├── controllers/
│   ├── core/
│   │   ├── MY_Controller.php
│   │   └── MY_Model.php
│   ├── helpers/
│   ├── hooks/
│   ├── language/
│   ├── libraries/
│   ├── logs/
│   ├── models/
│   ├── third_party/
│   └── views/
│       ├── layouts/
│       └── migration/
├── assets/
│   ├── css/
│   ├── images/
│   └── js/
├── system/
├── uploads/
├── .env.example
├── .gitignore
├── .htaccess
├── index.php
└── README.md
```

The framework `system/` directory must remain stock CodeIgniter 3 code. Application behavior belongs in `application/`.

## Environment configuration

Runtime configuration must not hardcode credentials in committed files.

`.env.example` documents the required values, including at minimum:

```text
APP_ENV=development
APP_URL=http://localhost/pk-dts-ci3
DB_HOST=127.0.0.1
DB_PORT=5432
DB_NAME=pk_dts
DB_USER=postgres
DB_PASSWORD=
DB_DRIVER=postgre
SESSION_DRIVER=files
```

A lightweight bootstrap mechanism may read environment variables available to PHP. The setup must not require Node.js or npm.

Secrets must remain ignored by Git.

## Database direction

Keep PostgreSQL as the migration target so the CI3 branch remains compatible with the existing DTS database direction.

For this initial setup:

- configure CI3's database layer for PostgreSQL
- do not recreate the production schema
- do not run destructive migrations
- do not alter current data
- provide a connection-ready configuration only

Future feature migration work should map existing entities and constraints deliberately instead of blindly translating ORM models.

## Base application conventions

### `MY_Controller`

Provide one common application controller base class for future concerns such as:

- common layout data
- authentication guards
- permission checks
- flash messages
- current-user context
- audit hooks

Only generic bootstrapping belongs there during setup. No DTS business logic is implemented in this stage.

### `MY_Model`

Provide a small base model abstraction for shared database behavior. It should remain thin and should not become a generic repository containing feature logic.

Future feature-specific queries belong in feature models.

## Routing

The setup needs only minimal routes:

- `/` -> migration placeholder/home page
- `404_override` configured normally
- URI dash translation left disabled unless a later migrated module requires it

No legacy API route emulation is required at this stage.

## Sessions

Use CodeIgniter 3 sessions with the file driver initially because this minimizes infrastructure requirements.

The application should keep session configuration centralized so a database-backed session driver can be introduced later if the migrated DTS requires it.

## Placeholder verification page

The CI3 root route should render a minimal PK DTS migration page that confirms:

- CodeIgniter 3 booted
- the environment was loaded
- the application configuration is reachable

It must not expose credentials or sensitive environment values.

A database connection test may be documented separately, but the landing page should not fail solely because PostgreSQL is not configured yet during the scaffolding stage.

## Migration mapping

Later feature migration should happen module by module rather than as one rewrite.

Suggested migration order:

1. shared layout and navigation
2. authentication and user session handling
3. users, roles, and permissions
4. core document records and document metadata
5. document tracking and workflow actions
6. My Tasks / Work queues
7. hardcopy transfer
8. audit/activity logs
9. reports
10. disposal workflow
11. backup/restore administration
12. AI-related capabilities, only after the core DTS is stable

Each later module should have its own migration design and verification criteria.

## Compatibility strategy

During migration:

- the existing NestJS/Angular implementation remains the behavioral reference
- the CI3 implementation should preserve user-visible business rules unless a later task explicitly changes them
- database changes must be backward-aware until a cutover strategy is approved
- production data must not be mutated simply to make the new implementation easier

## Error handling and diagnostics

The initial CI3 setup should:

- use development error reporting only in development
- disable detailed PHP errors in production
- write CI3 logs to the application logs directory
- keep sensitive configuration out of rendered error pages
- provide a clean 404 path

## Testing and verification for setup

Before the setup stage can be called complete, verify:

1. PHP can execute the CI3 front controller.
2. The root route renders the migration placeholder.
3. No Node/npm tooling is required to run the CI3 application.
4. Environment configuration has safe defaults and an example file.
5. PostgreSQL configuration is syntactically valid but does not require production credentials.
6. Existing NestJS, Angular, Docker, and portable directories remain untouched.
7. `main` remains unchanged.
8. No DTS business feature is claimed as migrated.

## Definition of done for this stage

The setup stage is complete when the `migration/codeigniter3` branch contains a clean, bootable CodeIgniter 3 application skeleton and migration documentation, with no functional DTS modules migrated yet.

Further work must proceed through separate, reviewable migration steps rather than an all-at-once rewrite.
