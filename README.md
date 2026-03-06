# feature-typst-renderer

This branch introduces Typst as the canonical authoring format for `process/` articles. `.typ` files compile to `index.html` via a Node.js build script. Hand-written HTML is no longer the source of truth.

## Pipeline

```
process/<article>/<article>.typ  →  npm run typst  →  process/<article>/index.html
```

**`scripts/build-typst.js`** discovers all `process/**/*.typ` files and compiles each with:

```sh
typst compile --format html --features html --root <repo-root> <file>.typ <dir>/index.html
```

The `--root` flag is required so that absolute image paths (e.g. `/assets/process/...`) resolve from the repo root rather than the file's directory.

The script extracts `<body>` content from Typst's output, wraps it in the site's article shell (favicon, fonts, `article.css`, back-link), and writes the final `index.html`.

**Never edit `index.html` directly** — it will be overwritten on the next build.

## Authoring

See `docs/authoring-guide.typ` (compiled: `docs/authoring-guide.pdf`) for the full reference. Quick notes:

- Article title: `#html.elem("h1")[Title]` — Typst maps `=` to `<h2>`, not `<h1>`
- Section headings: `=` → `<h2>`, `==` → `<h3>`
- Figures: `#html.elem("figure", attrs: (class: "todo-figure"))[...]`
- Side-by-side figures: add `class: "todo-figure side-by-side"`
- Math: wrap in `#html.frame()` (see below)

## Known Issues

### Math: waiting on upstream MathML support

Typst 0.14.x HTML export silently drops all equations. The root cause is in `crates/typst-html/src/convert.rs`: the converter has no match arm for `EquationElem`, so equations hit the unrecognized-element fallback, emit a warning (`equation was ignored during HTML export`), and are dropped entirely.

**Current workaround:** `html.frame()` renders math as an inline SVG via Typst's existing PDF/SVG pipeline. Display equations:

```typ
#html.elem("div", attrs: (class: "equation-sample"))[
  #html.frame($ log_2(500 \/ 200) = 1.32 $)
]
```

Inline math:

```typ
The guide number (#html.frame($"GN"$)) of 58m relates distance and f-stop.
```

This works and renders correctly, but it degrades authoring ergonomics — every math expression requires the `#html.frame()` wrapper rather than plain `$ ... $` syntax.

**The fix:** Typst's HTML exporter needs a `EquationElem` match arm in `convert.rs` that emits MathML (or auto-frames the equation as SVG as a stopgap). A stopgap auto-frame approach would be ~10–20 lines; full MathML output is a larger effort. This is a known gap in Typst's HTML export roadmap. Once upstream adds MathML support, the `html.frame()` wrappers in all `.typ` files can be removed — the math content itself is already valid Typst syntax.

### Other authoring friction

- `html.elem("figure")` boilerplate is verbose relative to Markdown image syntax
- No shared article header template — each `.typ` manually repeats h1 / byline / post-meta
- Escape sequences required: `\<` before `<N` comparisons, `\#` for literal `#`, `\[`/`\]` inside link text

These are all solvable with a shared `templates/article.typ` import; not yet implemented.

## Ported Articles

- `process/paper-negative/paper-negative.typ`
- `process/beebe-backyard/beebe-backyard.typ`
