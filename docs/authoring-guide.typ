// authoring-guide.typ
// Guide for writing, building, and inspecting articles for op55n1.org.

#set document(title: "Article Authoring Guide", author: "op55n1.org")
#set page(margin: (x: 1.4in, y: 1.1in))
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#show heading: it => { v(0.5em); it; v(0.2em) }

#align(center)[
  #text(size: 20pt, weight: "bold")[Article Authoring Guide] \
  #v(0.2em)
  #text(size: 11pt, fill: luma(80))[op55n1.org — process/ articles]
]

#v(1em)

= Overview

Articles live in `process/<article-name>/`. The canonical source is a `.typ` file; `index.html` is a generated artifact. Never edit `index.html` directly — it will be overwritten by the build.

*Workflow:*

+ Write or edit `process/<name>/<name>.typ`
+ Run `npm run typst` from the repo root to compile all articles to HTML
+ Open the generated `index.html` locally to inspect
+ Commit both the `.typ` source and the generated `index.html`

= Writing

== Structure

Every article starts with a title in an `html.elem("h1")` call, followed by byline and post-meta, then body content. Use `=` for section headings (maps to `<h2>`) and `==` for subsections (`<h3>`).

```typ
#html.elem("h1")[Article Title]

#html.elem("p", attrs: (class: "byline"))[Jack Long]
#html.elem("p", attrs: (class: "post-meta"))[
  #html.elem("span", attrs: (class: "post-meta-item"))[
    Posted #html.elem("time", attrs: (datetime: "2026-01-01"))[January 1, 2026]
  ]
  #html.elem("span", attrs: (class: "post-meta-sep", "aria-hidden": "true"))[•]
  #html.elem("span", attrs: (class: "post-meta-item"))[
    Updated #html.elem("time", attrs: (datetime: "2026-01-02"))[January 2, 2026]
  ]
]

Body text here.

= Section Heading

== Subsection Heading
```

*Note:* Do not use `= Title` for the article title — Typst maps `=` to `<h2>`, which article.css styles as a section heading. Use `html.elem("h1")` explicitly.

== Prose

Plain text renders as `<p>` tags. Blank lines separate paragraphs. Standard Typst markup applies:

- `*bold*` → `<strong>`
- `_italic_` → `<em>`
- `#link("url")[text]` → `<a href="url">text</a>`
- `\#` → literal `#` (escapes the hash character)
- `\<` → literal `<` (prevents Typst from parsing it as a label — required before `<1 stop`, `<N`, etc.)
- `\[`, `\]` → literal brackets (used inside `#link(...)[\[1\]]` for citation syntax)

== Inline Note Blocks

For "quick note" asides, use a bold lead-in in a regular paragraph:

```typ
*A quick note:* Text of the note here, continuing in the same paragraph.
```

For a note that needs a line break after the lead-in:

```typ
*Another quick note:* #linebreak()
Full note text starting on the next line.
```

There is no special block style for notes — they render as regular paragraphs with a bold prefix. Keep them inline with the surrounding text.

== Blockquotes

Use `html.elem("blockquote")` with explicit `html.elem("p")` children for each paragraph. Typst's native `#quote` may not produce multi-paragraph `<blockquote>` elements reliably in HTML export.

```typ
#html.elem("blockquote")[
  #html.elem("p")[First paragraph of the quote.]

  #html.elem("p")[Second paragraph.]

  #html.elem("p")[Third paragraph.]
]
```

Styled by `article.css`: left border, italic, slightly larger line-height.

== Lists

Native Typst lists work:

```typ
- First item
- Second item
- Third item
```

Renders to `<ul><li>...</li></ul>`.

= Images

== Single Image

```typ
#html.elem("figure", attrs: (class: "todo-figure"))[
  #html.elem("img", attrs: (
    src: "/assets/process/<article>/<filename>.jpg",
    alt: "Descriptive alt text.",
    loading: "lazy",
    style: "width:80%;",
  ))
  #html.elem("figcaption")[Caption text here.]
]
```

- `src` uses an absolute path from the site root (starting with `/assets/...`)
- `loading: "lazy"` is standard on all images
- `style: "width:XX%;"` controls image width; omit to default to 100%
- PNG images get a transparent background (via CSS); JPG/AVIF get a light gray fallback

== Side-by-Side Images

Add `class: "todo-figure side-by-side"` to the figure. The CSS renders two equal columns.

```typ
#html.elem("figure", attrs: (class: "todo-figure side-by-side"))[
  #html.elem("img", attrs: (
    src: "/assets/process/<article>/img-a.jpg",
    alt: "Left image.",
    loading: "lazy",
  ))
  #html.elem("img", attrs: (
    src: "/assets/process/<article>/img-b.jpg",
    alt: "Right image.",
    loading: "lazy",
  ))
  #html.elem("figcaption")[Shared caption spanning both images.]
]
```

On mobile (`max-width: 900px`), the CSS collapses the grid to a single column automatically.

== Image Assets

Source images live in `assets/originals/`. Run `npm run images` to generate optimized AVIF and JPG at multiple widths in `assets/optimized/`. For process/ article images, place them in `assets/process/<article-name>/` directly (no pipeline required unless high-res optimization is needed).

= Math

Typst 0.14.x does not render math natively in HTML export — equations are silently dropped. The workaround is `html.frame()`, which renders Typst math as an inline SVG.

== Display Equations

Wrap in an `equation-sample` div for spacing:

```typ
#html.elem("div", attrs: (class: "equation-sample"))[
  #html.frame($ "GN" = "Distance" times "f-stop" $)
]
```

Renders as a centered SVG block with `margin: 18px 0 24px`.

== Inline Math

Use `html.frame()` inline in a paragraph:

```typ
The guide number (#html.frame($"GN"$)) relates distance and f-stop.

Decreasing distance by #html.frame($sqrt(2) approx 1.4$) doubles light intensity.
```

The SVG is sized to the text height and flows inline. Vertical alignment is handled by the browser's default SVG baseline behavior — check in the browser if precise alignment matters.

== Typst Math Syntax Reference

These are the symbols used in the paper-negative article:

#table(
  columns: (auto, auto),
  stroke: 0.5pt,
  [*Typst*], [*Renders as*],
  [`"GN"`], [GN (upright text in math)],
  [`upright("m")`], [m (upright unit)],
  [`sqrt(x)`], [√x],
  [`x^2`], [x²],
  [`x_2`], [x₂],
  [`x_"sub"`], [x with text subscript],
  [`times`], [×],
  [`approx`], [≈],
  [`prop`], [∝],
  [`=>`], [⟹],
  [`quad`], [wide space],
  [`1 / 6`], [⁶⁄₁ (fraction)],
  [`1 \/ 6`], [1/6 (inline slash)],
)

*Note:* When Typst's HTML math export matures, the `html.frame()` wrapper can be removed and native `$ ... $` syntax used directly. The math content itself is already valid Typst.

= Cross-References and Anchors

To create a linkable anchor on a heading (e.g. for a "see X" link elsewhere):

```typ
// Place a label after the heading (label must follow immediately):
#html.elem("h2", attrs: (id: "my-section"))[Section Title] <my-section>

// Link to it from anywhere in the document:
See #link(<my-section>)[Section Title] for details.

// Link to it from another HTML page (external):
#link("/process/article/#my-section")[cross-page link]
```

Note: The `html.elem("h2", ...)` form is required when you need an `id` attribute (for in-page anchor links). If no anchor is needed, use native Typst `= Section Title`.

= Building

== Compile All Articles

```sh
npm run typst
```

Discovers all `process/**/*.typ` files and compiles each to `index.html` in the same directory. Uses `typst compile --format html --features html --root .`.

== Compile One Article (Manual)

```sh
typst compile --format html --features html \
  --root /path/to/art_site \
  process/paper-negative/paper-negative.typ \
  process/paper-negative/index.html
```

The `--root` flag is required so that absolute image paths (`/assets/...`) resolve correctly.

== Locally Inspecting the Output

Serve the site locally to preview:

```sh
# Option 1 — npx serve (no install needed)
npx serve . -p 3000

# Option 2 — Python
python3 -m http.server 3000
```

Then open `http://localhost:3000/process/paper-negative/` in a browser.

*What to check:*
+ Article title, byline, and dates display correctly
+ Section headings are h1/h2/h3 (inspect element if unsure)
+ Images load and are sized correctly
+ Side-by-side figures display in two columns on desktop, stack on mobile (resize window)
+ Math SVGs appear inline and at the correct scale
+ Blockquote has left border and italic style
+ Back link appears in the top-left corner
+ No horizontal scroll on any element

== Common Errors

*`error: unclosed label`* — A `<` in prose is being parsed as a label start. Escape it: `\<`.

*`warning: equation was ignored`* — You used `$ ... $` without `html.frame()`. Wrap math in `#html.frame(...)`.

*`error: html export is only available when --features html is passed`* — Run with `--features html`, or use `npm run typst` which passes it automatically.

*Images not loading* — Check that the path starts with `/assets/process/<article>/` and the file exists in that location. Paths are resolved from `--root`.

*Title shows "Article"* — The build script extracts the title from the first `<h1>`. Make sure the article title uses `#html.elem("h1")[...]`, not `= Title`.
