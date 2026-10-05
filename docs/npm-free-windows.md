# NPM-free Windows branch

Branch:

`feature/npm-free-windows`

This branch is for Windows desktops where `npm` is blocked, unavailable, or
restricted by PowerShell policy.

## Goal

The desktop does **not** run:

- `npm install`
- `npm ci`
- `npm start`
- Angular CLI
- Nest CLI

GitHub Actions performs dependency installation and compilation. It produces a
Windows artifact containing:

- a portable Node.js runtime
- the compiled NestJS backend
- backend dependencies and Prisma tooling
- the compiled Angular frontend
- one-click `.cmd` launchers

## Desktop requirements

You still need a reachable PostgreSQL database. It can be:

- PostgreSQL installed as a normal Windows service
- PostgreSQL on another computer on the LAN
- a remote PostgreSQL server

Docker and Redis are not required.

## How to use

1. Open the GitHub Actions run for **Build npm-free Windows bundle**.
2. Download the artifact named `pk-dts-windows-npm-free`.
3. Extract it to a normal writable folder.
4. Run `setup-database.cmd`.
5. The first run creates `backend\.env.dockerless`. Edit its
   `DATABASE_URL` if needed, then run `setup-database.cmd` again.
6. Run `start-dts.cmd`.

Frontend:

`http://localhost:4200`

Backend:

`http://localhost:3000/api/v1`

Swagger:

`http://localhost:3000/api/docs`

## Why npm may be blocked

A common Windows case is that PowerShell resolves `npm` to `npm.ps1`, while
the execution policy blocks PowerShell scripts. In that situation,
`npm.cmd --version` can still work even though `npm --version` fails.

Run `diagnose-npm.cmd` if you want a local diagnostic report. It does not
change Windows policy or install anything.

This branch avoids changing your system security settings just to run DTS.
