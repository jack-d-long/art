#!/usr/bin/env node
const fs = require("node:fs");
const path = require("node:path");
const sharp = require("sharp");

const rootDir = process.cwd();
const inputDir = path.join(rootDir, "assets", "originals");
const outputDir = path.join(rootDir, "assets", "optimized");
const widths = [480, 960, 1440, 1920, 2560];
const formats = [
  { ext: "avif", options: { quality: 65 } },
  { ext: "jpg", options: { quality: 85, mozjpeg: true } },
];
const supported = new Set([
  ".jpg",
  ".jpeg",
  ".png",
  ".tif",
  ".tiff",
  ".webp",
  ".avif",
]);

const walk = (dir) => {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...walk(fullPath));
    } else {
      files.push(fullPath);
    }
  }
  return files;
};

if (!fs.existsSync(inputDir)) {
  console.error("Missing input directory:", inputDir);
  process.exit(1);
}

fs.mkdirSync(outputDir, { recursive: true });

const files = walk(inputDir).filter((file) =>
  supported.has(path.extname(file).toLowerCase())
);

if (files.length === 0) {
  console.error("No supported images found in:", inputDir);
  process.exit(1);
}

const manifest = {
  generatedAt: new Date().toISOString(),
  baseDir: "assets/optimized",
  items: [],
};

const toPosix = (value) => value.split(path.sep).join("/");

const main = async () => {
  for (const file of files) {
    const relPath = path.relative(inputDir, file);
    const relDir = path.dirname(relPath);
    const ext = path.extname(relPath);
    const baseName = path.basename(relPath, ext);
    const outDir = path.join(outputDir, relDir);

    fs.mkdirSync(outDir, { recursive: true });

    const image = sharp(file, { failOnError: false }).rotate();
    const meta = await image.metadata();

    if (!meta.width || !meta.height) {
      console.warn("Skipping (missing dimensions):", relPath);
      continue;
    }

    const targetWidths =
      widths.filter((width) => width <= meta.width).length > 0
        ? widths.filter((width) => width <= meta.width)
        : [meta.width];

    const item = {
      source: toPosix(path.join("assets", "originals", relPath)),
      width: meta.width,
      height: meta.height,
      variants: [],
    };

    for (const width of targetWidths) {
      const height = Math.round((meta.height * width) / meta.width);
      const resized = image.clone().resize({ width, withoutEnlargement: true });

      for (const format of formats) {
        const fileName = `${baseName}-${width}.${format.ext}`;
        const outPath = path.join(outDir, fileName);

        if (format.ext === "avif") {
          await resized.clone().avif(format.options).toFile(outPath);
        } else if (format.ext === "jpg") {
          await resized.clone().jpeg(format.options).toFile(outPath);
        } else {
          await resized.clone().toFile(outPath);
        }

        item.variants.push({
          width,
          height,
          format: format.ext,
          file: toPosix(path.join("assets", "optimized", relDir, fileName)),
        });
      }
    }

    manifest.items.push(item);
    console.log("Processed", toPosix(relPath));
  }

  const manifestPath = path.join(outputDir, "manifest.json");
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
  console.log("Wrote manifest", toPosix(path.relative(rootDir, manifestPath)));
};

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
