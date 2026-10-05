# PK DTS — CodeIgniter 3 Migration Foundation

This directory is the isolated CodeIgniter 3 migration target for PK DTS. It is intentionally setup-only: no authentication, permissions, document workflow, reports, backup, AI, or other DTS business module has been migrated yet.

## Requirements

- PHP 7.4+ with the extensions required by CodeIgniter and your eventual PostgreSQL connection
- Composer 2
- PostgreSQL is optional for the current verification page; it is required only when database-backed modules begin migrating
- Apache with `mod_rewrite`, or PHP's built-in server for local verification

Node.js and npm are not required.

## Install

From `pk-dts-ci3/`:

```bash
composer install
cp .env.example .env
```

On Windows, copy `.env.example` to `.env` using File Explorer or:

```bat
copy .env.example .env
```

Composer installs `codeigniter/framework` at exactly `3.1.13`. The post-install hook copies the stock framework `system/` directory from `vendor/codeigniter/framework/system/` into this application. Do not add application code under `system/`.

## Environment

The example environment uses safe development placeholders:

- `APP_ENV` — `development`, `testing`, or `production`
- `APP_URL` — application base URL
- `APP_KEY` — reserved for application encryption/session needs; do not commit a real value
- `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` — PostgreSQL connection values
- `DB_DRIVER` — keep `postgre`
- `SESSION_DRIVER` — currently `files`

Real `.env` files are ignored by Git. Existing process/server environment variables take precedence over values in `.env`.

## Writable directories

The web/PHP process must be able to write to:

```text
application/cache/
application/cache/sessions/
application/logs/
uploads/
```

Do not grant broader write permissions than required by your server account.

## Local verification

After `composer install`, from `pk-dts-ci3/` run:

```bash
php -S 127.0.0.1:8080 index.php
```

Then open `http://127.0.0.1:8080/`. The page should report that the PK DTS CodeIgniter 3 migration foundation is active. It intentionally does not open a database connection, so the page must work even when PostgreSQL is unavailable.

Run the setup checks from the repository root:

```bash
php pk-dts-ci3/tests/env_loader_test.php
php pk-dts-ci3/tests/config_contract_test.php
```

## Apache

Point the virtual host/document root at `pk-dts-ci3/` and allow overrides if `.htaccess` is used. The included rewrite sends non-file/non-directory requests to `index.php` and denies direct `.env` access.

In production:

- set `APP_ENV=production`
- use HTTPS
- provide credentials through the server environment or a protected `.env`
- verify writable directory ownership/permissions
- keep the document root scoped to this application

## Migration status

Current status: **foundation only**.

The current NestJS backend, Angular frontend, Docker setup, and portable tooling remain the behavioral reference while modules are migrated incrementally. See `../docs/codeigniter3-migration.md` for the approved migration order.
