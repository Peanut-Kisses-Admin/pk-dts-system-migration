# PK DTS CodeIgniter 3 Setup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a clean, bootable CodeIgniter 3 setup under `pk-dts-ci3/` without migrating any DTS business features or changing the existing NestJS/Angular applications.

**Architecture:** Introduce a single server-rendered CI3 application beside the current monorepo applications. Keep CodeIgniter 3.1.13 stock and dependency-managed, copy its `system/` directory into the CI3 app during setup, load runtime settings from environment variables, and keep PostgreSQL/session configuration centralized for later migration work.

**Tech Stack:** PHP, CodeIgniter 3.1.13, Composer, PostgreSQL configuration, Apache-compatible `.htaccess`, plain PHP smoke tests.

**Spec:** `docs/superpowers/specs/2026-10-06-codeigniter3-migration-design.md`

## Global Constraints

- Work only on branch `migration/codeigniter3`; do not merge to `main`.
- Create the migration application at `pk-dts-ci3/`.
- Keep `pk-dts-backend/`, `pk-dts-frontend/`, `pk-dts-docker/`, and `portable/` untouched.
- Use CodeIgniter 3.1.13; the official CodeIgniter download page identifies 3.1.13 as the current CI3 maintenance release.
- Do not require Node.js or npm to run the CI3 application.
- Keep PostgreSQL as the database target and use CI3 driver `postgre`.
- Use file-backed CI3 sessions initially.
- Never commit real credentials; `.env.example` contains placeholders only.
- Do not migrate authentication, roles, permissions, document workflows, reports, backup, AI, audit logs, or any other DTS business module in this plan.
- The root placeholder must not fail just because PostgreSQL is not configured yet.

## File Structure

```text
pk-dts-ci3/
├── application/
│   ├── cache/.gitkeep
│   ├── config/
│   │   ├── autoload.php
│   │   ├── config.php
│   │   ├── constants.php
│   │   ├── database.php
│   │   └── routes.php
│   ├── controllers/Home.php
│   ├── core/
│   │   ├── MY_Controller.php
│   │   └── MY_Model.php
│   ├── helpers/.gitkeep
│   ├── hooks/.gitkeep
│   ├── language/.gitkeep
│   ├── libraries/.gitkeep
│   ├── logs/.gitkeep
│   ├── models/.gitkeep
│   ├── third_party/.gitkeep
│   └── views/
│       ├── errors/html/error_404.php
│       └── migration/home.php
├── assets/
│   ├── css/app.css
│   ├── images/.gitkeep
│   └── js/app.js
├── bootstrap/env.php
├── system/.gitkeep
├── tests/
│   ├── config_contract_test.php
│   └── env_loader_test.php
├── tools/sync-ci3-system.php
├── uploads/.gitkeep
├── .env.example
├── .gitignore
├── .htaccess
├── composer.json
├── index.php
└── README.md
```

`system/` is generated from the exact installed `codeigniter/framework` 3.1.13 package and must not contain application code.

## Review Focus

- Missing `.env` file: application must use safe development defaults and still render the placeholder page.
- Existing process environment variables: `.env` loading must not overwrite values already supplied by the OS/web server.
- Empty database password: PostgreSQL config must accept an empty development password without syntax errors or accidental disclosure.
- Unavailable PostgreSQL server: root page must not open a database connection and therefore must still render.
- Production environment: detailed PHP/CI errors must not be enabled by the app bootstrap.

---

### Task 1: Framework bootstrap and environment loader

**Files:**
- Create: `pk-dts-ci3/composer.json`
- Create: `pk-dts-ci3/.env.example`
- Create: `pk-dts-ci3/.gitignore`
- Create: `pk-dts-ci3/bootstrap/env.php`
- Create: `pk-dts-ci3/tools/sync-ci3-system.php`
- Create: `pk-dts-ci3/index.php`
- Create: `pk-dts-ci3/system/.gitkeep`
- Create: `pk-dts-ci3/tests/env_loader_test.php`

**Interfaces:**
- Consumes: none.
- Produces: `dts_load_env(string $path): void` and `dts_env(string $key, $default = null)` from `bootstrap/env.php`; a generated `pk-dts-ci3/system/` copied from `vendor/codeigniter/framework/system/`; CI3 front controller constants `ENVIRONMENT`, `BASEPATH`, `APPPATH`, and `VIEWPATH` through the normal CI3 bootstrap.

- [ ] **Step 1: Write the failing environment-loader test**

Create `tests/env_loader_test.php` with assertions that `dts_load_env()` reads `KEY=value`, ignores blank/comment lines, preserves an already-defined environment variable, and returns the supplied default from `dts_env()` for a missing key.

- [ ] **Step 2: Run the test and verify it fails**

Run: `php pk-dts-ci3/tests/env_loader_test.php`

Expected: non-zero exit because `bootstrap/env.php` does not exist yet.

- [ ] **Step 3: Implement the minimal environment bootstrap**

In `bootstrap/env.php`, define only:

```php
function dts_load_env(string $path): void;
function dts_env(string $key, $default = null);
```

`dts_load_env()` must parse simple `KEY=value` lines, trim surrounding whitespace and matching single/double quotes, ignore comments/blank lines, and never overwrite a key already present in `getenv()`.

- [ ] **Step 4: Add framework dependency and system sync**

Create `composer.json` requiring exactly `codeigniter/framework` version `3.1.13`. Add Composer `post-install-cmd` and `post-update-cmd` hooks that execute `php tools/sync-ci3-system.php`.

`tools/sync-ci3-system.php` must copy `vendor/codeigniter/framework/system/` recursively into top-level `system/`, removing only previously generated contents under that `system/` directory before copying. It must abort if the source framework directory is missing.

- [ ] **Step 5: Add the CI3 front controller**

Create `index.php` that loads optional `.env`, maps `APP_ENV` to CI3 `ENVIRONMENT`, sets the system path to `system`, the application path to `application`, and otherwise follows the standard CI3 front-controller bootstrap. Production must not enable display_errors.

- [ ] **Step 6: Add safe example environment values and ignores**

`.env.example` must contain:

```text
APP_ENV=development
APP_URL=http://localhost/pk-dts-ci3
APP_KEY=
DB_HOST=127.0.0.1
DB_PORT=5432
DB_NAME=pk_dts
DB_USER=postgres
DB_PASSWORD=
DB_DRIVER=postgre
SESSION_DRIVER=files
```

`.gitignore` must ignore `.env`, `vendor/`, generated `system/*` while preserving `system/.gitkeep`, runtime cache/log contents while preserving their `.gitkeep`, and uploaded runtime files while preserving `uploads/.gitkeep`.

- [ ] **Step 7: Run the environment test and Composer validation**

Run:

```bash
php pk-dts-ci3/tests/env_loader_test.php
cd pk-dts-ci3 && composer validate --strict
```

Expected: environment test prints PASS and exits 0; Composer validation succeeds.

- [ ] **Step 8: Commit Task 1**

```bash
git add pk-dts-ci3
git commit -m "chore: bootstrap CodeIgniter 3 migration app"
```

### Task 2: Central application, PostgreSQL, route, and session configuration

**Files:**
- Create: `pk-dts-ci3/application/config/config.php`
- Create: `pk-dts-ci3/application/config/database.php`
- Create: `pk-dts-ci3/application/config/routes.php`
- Create: `pk-dts-ci3/application/config/autoload.php`
- Create: `pk-dts-ci3/application/config/constants.php`
- Create: `pk-dts-ci3/tests/config_contract_test.php`

**Interfaces:**
- Consumes: `dts_env()` from Task 1.
- Produces: CI3 `$config`, `$db['default']`, `$route`, and `$autoload` configuration arrays used by the framework.

- [ ] **Step 1: Write the failing config-contract test**

Create `tests/config_contract_test.php` that defines the CI3 guard constants needed to include config files and asserts:

- base URL comes from `APP_URL` with a trailing slash normalized;
- session driver defaults to `files`;
- database driver defaults to `postgre`;
- DB hostname, port, database, username, and password map from environment values;
- default route is `home/index`;
- database is not globally autoloaded.

- [ ] **Step 2: Run the config test and verify it fails**

Run: `php pk-dts-ci3/tests/config_contract_test.php`

Expected: non-zero exit because the config files do not exist.

- [ ] **Step 3: Implement CI3 app configuration**

`config.php` must set `base_url`, `index_page=''`, URI protocol `REQUEST_URI`, encryption key from `APP_KEY`, file session driver, writable session path under `application/cache/sessions`, CSRF protection disabled for this setup-only placeholder, and environment-appropriate logging without exposing secrets.

Create `application/cache/sessions/.gitkeep` and make runtime setup documentation require write permission for `application/cache/`, `application/logs/`, and `uploads/`.

- [ ] **Step 4: Implement PostgreSQL-ready database configuration**

`database.php` must use environment values and CI3 driver `postgre`. It must not connect during file inclusion and must not print credentials.

- [ ] **Step 5: Implement routing and autoload policy**

`routes.php` must set `default_controller='home'`, normal `404_override`, and `translate_uri_dashes=FALSE`.

`autoload.php` must not autoload the database. It may autoload only lightweight helpers required by the placeholder such as `url`.

- [ ] **Step 6: Run config tests and PHP syntax checks**

Run:

```bash
php pk-dts-ci3/tests/config_contract_test.php
find pk-dts-ci3/application/config -name '*.php' -print -exec php -l {} \;
```

Expected: config test PASS; every syntax check reports no syntax errors.

- [ ] **Step 7: Commit Task 2**

```bash
git add pk-dts-ci3/application/config pk-dts-ci3/application/cache pk-dts-ci3/tests/config_contract_test.php
git commit -m "chore: configure CI3 runtime and PostgreSQL"
```

### Task 3: Base classes and boot-verification page

**Files:**
- Create: `pk-dts-ci3/application/core/MY_Controller.php`
- Create: `pk-dts-ci3/application/core/MY_Model.php`
- Create: `pk-dts-ci3/application/controllers/Home.php`
- Create: `pk-dts-ci3/application/views/migration/home.php`
- Create: `pk-dts-ci3/application/views/errors/html/error_404.php`
- Create: `pk-dts-ci3/assets/css/app.css`
- Create: `pk-dts-ci3/assets/js/app.js`
- Create placeholder `.gitkeep` files for empty app/assets/runtime directories from the approved structure.

**Interfaces:**
- Consumes: CI3 `CI_Controller`, `CI_Model`, configuration values from Task 2.
- Produces: `MY_Controller`, `MY_Model`, `Home::index(): void`, and the root migration verification page.

- [ ] **Step 1: Add a failing structural smoke assertion**

Extend `tests/config_contract_test.php` with checks that `Home.php`, `MY_Controller.php`, `MY_Model.php`, and `views/migration/home.php` exist and that the home controller does not load the database.

- [ ] **Step 2: Run the test and verify the new assertions fail**

Run: `php pk-dts-ci3/tests/config_contract_test.php`

Expected: FAIL on the first missing application class/view.

- [ ] **Step 3: Implement the thin base classes**

`MY_Controller` extends `CI_Controller` and provides only generic view/bootstrap context for this setup. `MY_Model` extends `CI_Model` and contains no DTS-specific query or business behavior.

- [ ] **Step 4: Implement the root controller and placeholder view**

`Home::index(): void` must render `migration/home` with only safe values: application name, CI environment, and a message that the CI3 migration foundation is active. It must not query PostgreSQL and must not render secrets.

- [ ] **Step 5: Add minimal presentation assets and 404 view**

Use plain CSS/JS only; no npm-built assets or frontend framework. The page should be clean and readable but is not a production DTS UI.

- [ ] **Step 6: Run structural and syntax checks**

Run:

```bash
php pk-dts-ci3/tests/config_contract_test.php
find pk-dts-ci3/application -name '*.php' -print -exec php -l {} \;
```

Expected: PASS and no PHP syntax errors.

- [ ] **Step 7: Commit Task 3**

```bash
git add pk-dts-ci3/application pk-dts-ci3/assets
 git commit -m "feat: add CI3 migration verification page"
```

### Task 4: Web bootstrap verification and migration documentation

**Files:**
- Create: `pk-dts-ci3/.htaccess`
- Create: `pk-dts-ci3/README.md`
- Create: `docs/codeigniter3-migration.md`

**Interfaces:**
- Consumes: complete CI3 setup from Tasks 1-3.
- Produces: documented local setup/run workflow and module migration map for subsequent tasks.

- [ ] **Step 1: Install the exact framework dependency**

Run:

```bash
cd pk-dts-ci3
composer install
```

Expected: Composer installs CodeIgniter 3.1.13 and the post-install hook populates `system/` with stock framework files.

- [ ] **Step 2: Verify framework version and generated system directory**

Run a PHP command that loads `system/core/CodeIgniter.php` metadata or inspect the installed Composer package metadata and assert version `3.1.13`; verify `system/core/CodeIgniter.php` exists.

Expected: exact CI3 version 3.1.13 and generated stock system directory present.

- [ ] **Step 3: Add Apache rewrite configuration**

`.htaccess` must route non-file/non-directory requests to `index.php` and must not expose `.env`.

- [ ] **Step 4: Start the PHP development server and verify the root page**

Run from `pk-dts-ci3/`:

```bash
php -S 127.0.0.1:8080
```

From another shell:

```bash
curl -fsS http://127.0.0.1:8080/
```

Expected: HTTP 200 and body contains `PK DTS` plus a migration-foundation message even when PostgreSQL is unavailable.

- [ ] **Step 5: Verify a missing route uses the 404 path**

Run:

```bash
curl -i http://127.0.0.1:8080/route-that-does-not-exist
```

Expected: HTTP 404 without credentials, stack traces, or environment secrets.

- [ ] **Step 6: Document setup and future module migration order**

`pk-dts-ci3/README.md` must document prerequisites, `composer install`, `.env.example` copy, writable directories, PHP built-in server usage, Apache notes, PostgreSQL variables, and explicitly state that no DTS feature has been migrated yet.

`docs/codeigniter3-migration.md` must record the approved migration order: shared layout/navigation; auth; users/roles/permissions; document records; tracking/workflows; My Tasks/Work; hardcopy transfer; audit logs; reports; disposal; backup/restore; AI last.

- [ ] **Step 7: Confirm legacy applications are untouched**

Run:

```bash
git diff main...HEAD -- pk-dts-backend pk-dts-frontend pk-dts-docker portable
```

Expected: no diff.

- [ ] **Step 8: Run final verification**

Run:

```bash
php pk-dts-ci3/tests/env_loader_test.php
php pk-dts-ci3/tests/config_contract_test.php
cd pk-dts-ci3 && composer validate --strict
find application bootstrap tools tests -name '*.php' -print -exec php -l {} \;
```

Expected: all tests and validations pass.

- [ ] **Step 9: Commit Task 4**

```bash
git add pk-dts-ci3/.htaccess pk-dts-ci3/README.md docs/codeigniter3-migration.md
git commit -m "docs: document CodeIgniter 3 migration setup"
```

## Final acceptance

The setup is accepted only when:

1. `migration/codeigniter3` boots CI3 3.1.13 after `composer install`.
2. `/` returns the migration placeholder without requiring PostgreSQL.
3. `.env` secrets are ignored and never rendered.
4. PostgreSQL configuration uses `postgre` and environment variables.
5. Sessions default to the file driver.
6. No Node/npm command is needed.
7. Existing NestJS, Angular, Docker, and portable source trees have no migration-branch changes.
8. No DTS business module is represented as migrated.
9. `main` remains unchanged.
