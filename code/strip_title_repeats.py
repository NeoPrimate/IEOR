#!/usr/bin/env python3
"""Strip in-file page-title repeats and normalize heading levels.

book.toml is the single source of truth for page titles; the build injects the
title. A source file must therefore NOT repeat its own title, and its shallowest
heading should be `==` (one level below the injected title).

For each leaf page's FIRST file:
  1. find the first heading line (ignoring lines inside ``` fenced code blocks),
  2. if its text matches the page title -> delete it (+ one trailing blank line),
  3. then shift ALL heading lines so the shallowest becomes `==`.
Files whose first heading does NOT match the title are left untouched and flagged.

Usage:
  python3 code/strip_title_repeats.py            # dry-run, prints report
  python3 code/strip_title_repeats.py --apply    # writes changes
"""
from __future__ import annotations
import re
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BOOK = ROOT / "book.toml"

HEADING_RE = re.compile(r"^(=+)\s+(.*\S)\s*$")
FENCE_RE = re.compile(r"^\s*```")
LABEL_RE = re.compile(r"\s*(<[^>]+>)\s*$")  # trailing Typst label, e.g. `<newton_method>`

# Human-confirmed title repeats whose first heading doesn't pass exact-match
# (extra "the", reordered words, or a trailing descriptive subtitle). Map
# path -> the exact original heading text, so the strip is idempotent: once the
# heading is gone, a re-run finds no match and leaves the file alone. Paths
# relative to src/.
FORCE_STRIP = {
    "probability_theory/mgf.typ": "Moment Generating Function (MGF)",
    "probability_theory/joint_marginal_conditional.typ": "Joint, Conditional and Marginal Probabilities",
    "statistics/distributions/differentiating_normal.typ": "Differentiating Normal Distribution",
    "operations_research/quality_engineering/acceptance_sampling.typ": "Acceptance sampling: OC curve, AOQ, AOQL, single/double/sequential plans",
}


def normalize(s: str) -> str:
    """Loose comparison key: drop markup, punctuation, case, whitespace."""
    s = s.strip()
    s = re.sub(r"<[^>]+>", "", s)            # Typst labels (compare title, not anchor)
    s = re.sub(r"\$[^$]*\$", "", s)          # inline math
    s = re.sub(r"[*_`#]", "", s)             # emphasis / raw / heading marks
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "", s)         # punctuation & spaces
    return s


def leaves(sections, src: Path):
    """Yield (title, [abs file paths]) for every section that has files."""
    for sec in sections:
        files = sec.get("files")
        if files:
            yield sec["title"], [src / f for f in files]
        for sub in sec.get("sections", []) or []:
            yield from leaves([sub], src)


def heading_lines(lines):
    """Yield (index, level, text) for heading lines outside ``` fences."""
    in_fence = False
    for i, line in enumerate(lines):
        if FENCE_RE.match(line):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        m = HEADING_RE.match(line)
        if m:
            yield i, len(m.group(1)), m.group(2)


def process(path: Path, title: str):
    """Return (action, detail, new_text) for a file. action in
    {stripped, flagged, no-heading, missing}."""
    if not path.exists():
        return "missing", str(path), None
    text = path.read_text()
    lines = text.split("\n")
    heads = list(heading_lines(lines))
    if not heads:
        return "no-heading", "", text

    notes = []
    rel = str(path.relative_to(ROOT / "src"))

    # 1. (first file only) delete a leading heading that repeats the page title.
    if title is not None:
        first_idx, _, first_text = heads[0]
        forced = rel in FORCE_STRIP and normalize(first_text) == normalize(FORCE_STRIP[rel])
        if normalize(first_text) == normalize(title) or forced:
            label = LABEL_RE.search(first_text)
            if label:
                # Heading carries a cross-referenced label — keep the anchor so
                # #link(<…>) still resolves; just drop the visible heading.
                lines[first_idx] = f"#metadata(none) {label.group(1)}"
                notes.append(f"removed title repeat (kept label {label.group(1)})")
            else:
                del lines[first_idx]
                if first_idx < len(lines) and lines[first_idx].strip() == "":
                    del lines[first_idx]
                notes.append("removed title repeat")

    # 2. shift ALL remaining headings so the shallowest becomes `==` (one level
    #    below the injected page title). Preserves relative structure.
    remaining = list(heading_lines(lines))
    if remaining:
        shallowest = min(lvl for _, lvl, _ in remaining)
        shift = 2 - shallowest
        if shift != 0:
            for idx, lvl, txt in remaining:
                lines[idx] = "=" * (lvl + shift) + " " + txt
            notes.append(f"shifted {shift:+d} (shallowest {shallowest}->2)")

    if not notes:
        return "ok", "", text
    return "changed", "; ".join(notes), "\n".join(lines)


def main():
    apply = "--apply" in sys.argv
    data = tomllib.loads(BOOK.read_text())
    src = ROOT / data["book"]["src"]

    counts = {"changed": 0, "ok": 0, "no-heading": 0, "missing": 0}
    changed = []
    seen = set()

    for title, files in leaves(data["sections"], src):
        # Only the first file may repeat the page title; later files in the same
        # page get level-normalized but never title-stripped.
        for n, f in enumerate(files):
            if f in seen:
                continue
            seen.add(f)
            action, detail, new_text = process(f, title if n == 0 else None)
            counts[action] += 1
            if action == "changed":
                changed.append((f.relative_to(ROOT), detail))
                if apply and new_text is not None:
                    f.write_text(new_text)

    print(f"{'APPLIED' if apply else 'DRY-RUN'}  "
          f"changed={counts['changed']} ok={counts['ok']} "
          f"no-heading={counts['no-heading']} missing={counts['missing']}\n")
    print("== CHANGED ==")
    for rel, detail in changed:
        print(f"  {rel}  [{detail}]")


if __name__ == "__main__":
    main()
