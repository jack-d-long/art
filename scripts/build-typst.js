#!/usr/bin/env node
// scripts/build-typst.js
// Compiles all process/**/*.typ files to index.html using typst --format html.
// Usage: npm run typst

import { execSync } from 'child_process';
import { readFileSync, writeFileSync, unlinkSync, readdirSync, statSync } from 'fs';
import { join, dirname, relative } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, '..');

function findTypFiles(dir) {
  const results = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    if (statSync(full).isDirectory()) {
      results.push(...findTypFiles(full));
    } else if (entry.endsWith('.typ')) {
      results.push(full);
    }
  }
  return results;
}

const typFiles = findTypFiles(join(ROOT, 'process'));

if (typFiles.length === 0) {
  console.log('No .typ files found in process/');
  process.exit(0);
}

let errors = 0;

for (const inputPath of typFiles) {
  const relPath = relative(ROOT, inputPath);
  const outDir = dirname(inputPath);
  const tmpPath = join(outDir, '_typst_tmp.html');
  const finalPath = join(outDir, 'index.html');

  try {
    execSync(
      `typst compile --format html --features html --root "${ROOT}" "${inputPath}" "${tmpPath}"`,
      { stdio: 'pipe' }
    );
  } catch (err) {
    console.error(`✗ ${relPath}`);
    console.error(err.stderr?.toString() || err.message);
    errors++;
    continue;
  }

  const typstHtml = readFileSync(tmpPath, 'utf8');
  unlinkSync(tmpPath);

  // Extract everything inside <body>
  const bodyMatch = typstHtml.match(/<body[^>]*>([\s\S]*?)<\/body>/i);
  const bodyContent = bodyMatch ? bodyMatch[1].trim() : typstHtml;

  // Extract plain-text title from first <h1>
  const h1Match = bodyContent.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i);
  const title = h1Match ? h1Match[1].replace(/<[^>]+>/g, '').trim() : 'Article';

  const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${title}</title>
  <link rel="icon" type="image/png" href="/assets/ascii-eye-fav.png" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="/article.css" />
</head>
<body>
  <a class="back-link" href="/process/">back</a>
  <main>
    ${bodyContent}
  </main>
</body>
</html>`;

  writeFileSync(finalPath, html);
  console.log(`✓ ${relPath} → index.html`);
}

if (errors > 0) {
  console.error(`\n${errors} file(s) failed to compile.`);
  process.exit(1);
}
