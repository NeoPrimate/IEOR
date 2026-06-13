#import "/lib/imports.typ": *

#set document(
  title: "Industrial Engineering & Operations Research",
  author: "Vlad",
)

#show: formatting

// Read the book structure from book.toml at the project root.
#let book = toml("/book.toml")
#let src-prefix = "/" + book.book.src + "/"

// Path/label helpers — mirrored from book.typ so cross-page #link(<…>) refs
// resolve in PDF builds too. Source files write `#link(<linear-algebra-determinant>)[…]`.
#let slug(s) = {
  let r = lower(s)
  for replacement in (
    ("& ", ""),
    (" & ", " "),
    ("&", ""),
    ("–", "-"),
    ("—", "-"),
    (" ", "-"),
    ("/", "-"),
    ("(", ""),
    (")", ""),
    (",", ""),
    (".", ""),
    ("?", ""),
    ("'", ""),
  ) {
    r = r.replace(replacement.at(0), replacement.at(1))
  }
  r
}

#let section-path(title, parent: "") = {
  if parent == "" { slug(title) } else { parent + "/" + slug(title) }
}

#let path-tag(p) = p.replace("/", "-")

// Recursively walk sections.
//   depth 1  → top-level section, gets a title page
//   depth ≥2 → heading at level (depth − 1)
#let render(sections, depth: 1, parent: "") = {
  for sec in sections {
    let p = section-path(sec.title, parent: parent)
    if depth == 1 {
      title_page(sec.title)
      // Attach the cross-page label after the title page so #link(<path-tag>) resolves.
      [#metadata(none) #std.label(path-tag(p))]
    } else {
      // Emit heading + label together so the label attaches to the heading.
      [#heading(level: depth - 1, sec.title) #std.label(path-tag(p))]
    }
    // Offset included headings by the page's nesting depth so a file's
    // shallowest heading (`==`) always lands exactly one level below the
    // injected title, at any depth. Scoped to this block so it never leaks to
    // sibling/child titles. (depth 1 & 2 → offset 0; depth 3 → 1; …)
    {
      set heading(offset: calc.max(0, depth - 2))
      for f in sec.at("files", default: ()) {
        include src-prefix + f
      }
    }
    if "sections" in sec {
      render(sec.sections, depth: depth + 1, parent: p)
    }
  }
}

#pagebreak()

#outline(indent: 1em, depth: 2)

#pagebreak()

#render(book.sections)
