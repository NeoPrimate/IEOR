# IEOR build commands.
# Install `just` via: brew install just
# Then run e.g. `just build-pdf` from the repo root.

# Path to the Typst CLI. Override via env: `TYPST=typst just build-pdf`.
# Default points at the cargo-installed HEAD which has bundle/html support.
TYPST := env_var_or_default("TYPST", "~/.cargo/bin/typst")

# Default recipe — show available commands.
default:
    @just --list

# === PDF ===

# Compile the full book to a single PDF.
# --features html is needed so the `target()` function (used by helpers
# to switch between paged/html rendering) is callable.
build-pdf:
    {{TYPST}} compile --features html --root . main.typ build/main.pdf

# Watch mode: live-rebuild PDF on every save.
watch-pdf:
    {{TYPST}} watch --features html --root . main.typ build/main.pdf

# Quick single-file preview. Generates a temp wrapper, compiles, opens.
# Usage: just preview file=src/linear_algebra/vectors.typ
preview file:
    @mkdir -p build/dev
    @printf '#import "/lib/imports.typ": *\n#show: formatting\n#include "/{{file}}"\n' > build/dev/preview.typ
    {{TYPST}} compile --features html --root . build/dev/preview.typ build/dev/preview.pdf
    open build/dev/preview.pdf

# === HTML book (requires Typst HEAD with bundle support) ===

# Path to pagefind binary. Override via env: `PAGEFIND=pagefind just build-html`.
PAGEFIND := env_var_or_default("PAGEFIND", "~/.local/bin/pagefind")

# Build the multi-page HTML book end-to-end:
#   1. Typst bundle export emits all pages + sidebar + style.css.
#   2. PDF is copied into build/html/main.pdf so "Read as PDF" works locally.
#   3. Pagefind crawls the output to build the search index.
build-html: build-pdf
    rm -rf build/html
    mkdir -p build/html
    {{TYPST}} compile --features bundle,html --format bundle --root . book.typ build/html/
    cp build/main.pdf build/html/main.pdf
    {{PAGEFIND}} --site build/html

# Serve the built HTML book locally for preview.
serve:
    python3 -m http.server 8000 --directory build/html

# === Combined ===

# Build both PDF and HTML.
build: build-pdf build-html

# === Publishing ===

# Build PDF and push to git.
publish-pdf: build-pdf
    git add -A
    git commit -m "Build PDF"
    git push
