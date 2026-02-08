#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import MarkdownIt from "markdown-it";

const rootDir = path.resolve(process.cwd());
const contentDir = path.join(rootDir, "content");
const templatePath = path.join(rootDir, "templates", "page.html");
const outputDir = rootDir;
const skipNames = new Set(["index"]);

const md = new MarkdownIt({
  html: false,
  linkify: true,
  typographer: true,
});

if (!fs.existsSync(contentDir)) {
  console.error("Missing content directory:", contentDir);
  process.exit(1);
}

const template = fs.readFileSync(templatePath, "utf8");

const files = fs
  .readdirSync(contentDir)
  .filter((file) => file.endsWith(".md"));

if (files.length === 0) {
  console.error("No markdown files found in:", contentDir);
  process.exit(1);
}

const toTitle = (value) => {
  if (!value) return "";
  return value.charAt(0).toUpperCase() + value.slice(1);
};

for (const file of files) {
  const name = path.basename(file, ".md");
  if (skipNames.has(name)) {
    continue;
  }

  const filePath = path.join(contentDir, file);
  const raw = fs.readFileSync(filePath, "utf8");
  const match = raw.match(/^#\s+(.+)$/m);
  const title = match ? match[1].trim() : toTitle(name);
  const html = md.render(raw);

  const page = template
    .replace("{{title}}", title)
    .replace("{{content}}", html.trim());

  const outPath = path.join(outputDir, `${name}.html`);
  fs.writeFileSync(outPath, page, "utf8");
  console.log("Generated", outPath);
}
