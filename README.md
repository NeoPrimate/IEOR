<h1 align="center">Industrial Engineering & Operations Research</h1>

A working book covering math, statistics, time series, operations research, supply chain, and ML — built from one set of `.typ` sources into both a PDF and a multi-page HTML book.

- **PDF** — single document → `build/main.pdf` (the only tracked build output)
- **HTML book** — multi-page, searchable, mdBook-style → <https://neoprimate.github.io/IEOR/>

## Run locally — PDF

Live preview while editing: open any `.typ` file in Zed. Tinymist auto-recompiles `main.typ` and follows your cursor (configured in `.zed/settings.json`).

One-shot build:

```sh
just build-pdf       # → build/main.pdf
just preview file=src/linear_algebra/vectors.typ   # → build/dev/preview.pdf  (single leaf)
```

## Run locally — HTML book

```sh
just build-html      # → build/html/  (also rebuilds build/main.pdf)
just serve           # → http://localhost:8000
```

Requires Typst >= 0.15.0-rc.1 (for `bundle` export + native MathML math) and
Pagefind (for search). One-time setup on macOS arm64:

```sh
curl -sL https://github.com/typst/typst/releases/download/v0.15.0-rc.1/typst-aarch64-apple-darwin.tar.xz \
  | tar -xJ --strip-components=1 -C ~/.local/bin/ typst-aarch64-apple-darwin/typst
curl -sL https://github.com/Pagefind/pagefind/releases/download/v1.5.2/pagefind-v1.5.2-aarch64-apple-darwin.tar.gz \
  | tar -xz -C ~/.local/bin/
```

## Push to GitHub

```sh
git push
```

GitHub Actions rebuilds **both** artifacts on every push to `main`:

- **HTML book** — deployed to <https://neoprimate.github.io/IEOR/>
- **PDF** — served inline at <https://neoprimate.github.io/IEOR/main.pdf> (full document, no GitHub paging) and attached to the [latest release](https://github.com/NeoPrimate/IEOR/releases/latest)

## Repository layout

```
book.toml          # book structure (single source of truth, drives PDF + HTML)
main.typ           # PDF entry
book.typ           # HTML book entry (bundle)
src/               # content (mirrors book.toml's section tree)
lib/               # typst plumbing (imports, formatting, utils)
web/               # HTML build (setup.typ, style.css)
code/              # Python — example code referenced by the book
build/             # outputs — only main.pdf is tracked, rest is regenerated
.github/workflows/ # CI: builds + deploys book and PDF
```
