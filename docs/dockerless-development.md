# Dockerless development

This branch can run PK DTS without Docker Desktop, Docker Engine, Docker Compose, or a Redis container.

## What is still required

- Node.js 22+
- npm
- PostgreSQL 16+ installed locally **or** a reachable PostgreSQL server

Redis is optional. Dockerless mode uses Nest's in-memory cache by default.

## Backend

From `pk-dts-backend`:

```bash
npm install
npm run setup:dockerless
npm run start:dockerless
```

The first `setup:dockerless` run creates `.env.dockerless` from
`.env.dockerless.example`, generates Prisma Client, pushes the PostgreSQL
schema, and seeds the database.

Default database URL:

```text
postgresql://postgres:postgres@127.0.0.1:5432/document_tracking?schema=public
```

If your PostgreSQL username, password, port, host, or database name is
different, edit `pk-dts-backend/.env.dockerless` before rerunning setup.

API:

```text
http://localhost:3000/api/v1
```

Swagger:

```text
http://localhost:3000/api/docs
```

## Frontend

From `pk-dts-frontend`:

```bash
npm install
npm start
```

The existing frontend default already targets:

```text
http://localhost:3000/api/v1
```

Open:

```text
http://localhost:4200
```

## Optional Redis

Dockerless mode does not require Redis.

To use a native or remote Redis server instead, change:

```env
CACHE_DRIVER=redis
REDIS_URL=redis://127.0.0.1:6379
```

If Redis cannot be reached during startup, the API falls back to the in-memory
cache instead of failing the whole application.

## Docker remains supported

The `pk-dts-docker` directory is intentionally retained. On this branch the
Docker environment explicitly uses `CACHE_DRIVER=redis`, while dockerless mode
uses `CACHE_DRIVER=memory`.

## Branch isolation

All dockerless changes live on:

```text
feature/dockerless-local-dev
```

They are not merged into `main`.
