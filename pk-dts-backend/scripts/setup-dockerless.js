const { copyFileSync, existsSync } = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { loadEnv } = require('./env-runtime');

const rootDir = path.resolve(__dirname, '..');
const envPath = path.join(rootDir, '.env.dockerless');
const examplePath = path.join(rootDir, '.env.dockerless.example');

if (!existsSync(envPath)) {
  copyFileSync(examplePath, envPath);
  console.log('Created .env.dockerless from .env.dockerless.example');
}

loadEnv(rootDir, 'dockerless');

process.env.PRISMA_SCHEMA_PATH =
  process.env.PRISMA_SCHEMA_PATH || 'prisma/schema.postgresql.prisma';
process.env.CACHE_DRIVER = process.env.CACHE_DRIVER || 'memory';

if (!process.env.DATABASE_URL) {
  console.error('DATABASE_URL is required in .env.dockerless.');
  process.exit(1);
}

function runNode(scriptPath, args) {
  const result = spawnSync(process.execPath, [scriptPath, ...args], {
    cwd: rootDir,
    env: process.env,
    stdio: 'inherit',
    shell: false,
  });

  if ((result.status ?? 1) !== 0) {
    process.exit(result.status ?? 1);
  }
}

const prismaWrapper = path.join(rootDir, 'scripts', 'prisma-env.js');
const tsNodeCli = path.join(rootDir, 'node_modules', 'ts-node', 'dist', 'bin.js');

console.log('Preparing dockerless PostgreSQL database...');
runNode(prismaWrapper, ['--app-env', 'dockerless', 'generate']);
runNode(prismaWrapper, ['--app-env', 'dockerless', 'db', 'push']);
runNode(tsNodeCli, ['prisma/seed.ts']);

console.log('');
console.log('Dockerless setup complete.');
console.log('Start the API with: npm run start:dockerless');
console.log('Start the frontend separately from pk-dts-frontend with: npm start');
