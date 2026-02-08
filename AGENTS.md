# AGENTS.md

## Project Intent
- Build a minimal static site in the repo root.
- Use `fun-with-clip-path-main/` only as a reference library, not as the site itself.
- Menu should:
  - Open on hover.
  - Also be togglable by click, and close reliably (hover should not immediately re-open after click-close).
  - Use a black/white theme where “black” is `#333A3F` (stored as a CSS variable).
  - Have a white reveal (menu panel) on black background.
- Menu-linked pages are minimal: paper background with ink text.
- Photo page should stress-test rendering: 3 columns, highest-res AVIFs.
- TIFFs should be piped to AVIF by default before being shown.
- Use a local build pipeline for image optimization (AVIF + JPG).

## Current Structure
- Root site (active):
  - `index.html` (menu example + hover/click handling)
  - `styles.css` (menu styles + hover-lock logic)
  - `photo.html` (image grid)
  - Simple pages: `about.html`, `events.html`, `exhibits.html`, `congresses.html`, `sports.html`, `work.html`, `insights.html`, `contact.html`
- Reference library only:
  - `fun-with-clip-path-main/` (original example)
- Assets:
  - Originals: `assets/originals/`
    - `assets/originals/lake/` (TIFF + JPG sources)
    - `assets/originals/last_of/` (JPG sources)
  - Optimized: `assets/optimized/`
    - `assets/optimized/lake/` (AVIF/JPG outputs)
    - `assets/optimized/last_of/` (AVIF/JPG outputs)
  - Menu corner image: `assets/index/IMG_1181.png`
- Scripts:
  - `scripts/build-images.js` (image pipeline)
  - `scripts/dev.sh` (build + serve + open)

## Theme Variables
- In `styles.css`:
  - `--ink: #333A3F`
  - `--paper: #fff`
- Menu label transitions are delayed on close to avoid flicker.

## Menu Behavior (Key Details)
- Hover opens menu.
- Click toggles menu open/close.
- A hover-lock mechanism is used to prevent hover from keeping the menu open after click-close.
  - `.app.hover-locked` disables hover-triggered open.
  - JS toggles `hover-locked` when checkbox is unchecked, and unlocks on `mouseleave` of label or overlay.

## Photo Page Behavior
- `photo.html` displays highest-res AVIFs.
- 3-column grid for stress testing.
- Currently includes:
  - Lake: `img04-1920.avif`, `img16-1920.avif`, `img26-1920.avif`, `lake-08-1920.avif`
  - Last_of: all unique images at their highest available size (2560 when present, else 1920/1440).
- If new originals are added, re-run image pipeline and update `photo.html`.

## Image Pipeline
- Script: `scripts/build-images.js`
  - Inputs: `assets/originals/`
  - Outputs: `assets/optimized/`
  - Generates AVIF + JPG (AVIF quality ~65, JPG quality ~85)
  - Widths: 480, 960, 1440, 1920, 2560
- Run: `npm run images`

## Known Logs / Diagnostics
### npm + cwd errors
```
Error: ENOENT: no such file or directory, uv_cwd
```
- Happens when running `npm` in a directory that no longer exists (e.g., deleted `site/`).
- Fix: `cd /Users/jacklong/Documents/art_site` and rerun.

### npm dev script
```
npm error Missing script: "dev"
```
- Expected: root `package.json` has no `dev` script.

### Build pipeline deps
```
ERR_MODULE_NOT_FOUND: Cannot find package 'markdown-it'
```
- This was from the previous markdown build pipeline which is now disabled.

### Server / port
- Port 3000 can be in use; `serve` may pick another port.
- Python http server may fail with `PermissionError: [Errno 1] Operation not permitted` in restricted environments.

## Current Deviations / Cleanup Notes
- Markdown renderer pipeline is disabled (build script removed from `package.json`), but files remain:
  - `scripts/build.js`, `content/`, `templates/`, `page.css`
- If not needed, these can be removed.
- `scripts/dev.sh` exists to build+serve+open; may need to ignore `open` failures if desired.

## Future Improvements (Optional)
- Auto-generate `photo.html` from `assets/optimized/` to avoid manual updates.
- Add `srcset` on photo images if switching back from stress-test mode.
- Add CSS or layout tweaks for better loading/perf when scaling to many images.
