# PK DTS Monorepo

PK DTS is the unified monorepo for the Peanut Kisses Document Tracking System, including its backend API, frontend application, and Docker deployment stack.

This repository contains the PK Document Tracking System source tree:

- `pk-dts-backend` — NestJS API
- `pk-dts-frontend` — Angular application
- `pk-dts-docker` — Docker Compose deployment stack

The repository and local workspace use the PK DTS / Document Tracking System identity. Runtime API, database, environment, and service identifiers remain unchanged for compatibility.

## Dockerless development branch

The branch `feature/dockerless-local-dev` supports local development without
Docker. Redis is optional and the backend uses in-memory caching by default.
PostgreSQL can run as a native local service or be provided by any reachable
PostgreSQL server.

See `docs/dockerless-development.md` on that branch for setup instructions.

The `main` branch is intentionally unchanged by this work.

## Legacy repositories

The original backend, frontend, and Docker Git histories remain preserved in their existing remote repositories. Their local Git metadata was archived outside this working tree during the monorepo conversion.
