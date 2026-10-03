const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(process.argv[2] || '.');
const port = Number(process.argv[3] || 4200);

const mime = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.map': 'application/json; charset=utf-8'
};

function safeFile(urlPath) {
  const clean = decodeURIComponent(urlPath.split('?')[0]).replace(/^\/+/, '');
  const candidate = path.resolve(root, clean || 'index.html');

  if (!candidate.startsWith(root)) {
    return null;
  }

  return candidate;
}

function sendFile(res, filePath) {
  fs.stat(filePath, (error, stat) => {
    if (!error && stat.isDirectory()) {
      filePath = path.join(filePath, 'index.html');
    }

    fs.readFile(filePath, (readError, data) => {
      if (readError) {
        const fallback = path.join(root, 'index.html');
        fs.readFile(fallback, (fallbackError, fallbackData) => {
          if (fallbackError) {
            res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
            res.end('Not found');
            return;
          }

          res.writeHead(200, {
            'Content-Type': 'text/html; charset=utf-8',
            'Cache-Control': 'no-cache'
          });
          res.end(fallbackData);
        });
        return;
      }

      res.writeHead(200, {
        'Content-Type': mime[path.extname(filePath).toLowerCase()] || 'application/octet-stream'
      });
      res.end(data);
    });
  });
}

http.createServer((req, res) => {
  const filePath = safeFile(req.url || '/');

  if (!filePath) {
    res.writeHead(400, { 'Content-Type': 'text/plain; charset=utf-8' });
    res.end('Bad request');
    return;
  }

  sendFile(res, filePath);
}).listen(port, '127.0.0.1', () => {
  console.log(`PK DTS frontend: http://localhost:${port}`);
});
