#import "/lib/imports.typ": *

#set document(
  title: "Industrial Engineering & Operations Research",
  author: "Vlad",
)

#show: formatting

// Read the book structure from book.toml at the project root.
#let book = toml("/book.toml")
#let src-prefix = "/" + book.book.src + "/"

// Recursively walk sections.
//   depth 1        → top-level group, gets a title page
//   depth ≥2 group → heading at level (depth − 1)
//   leaf           → no injection at all; the file supplies its own title
//                    (`= Title` or, at depth 1, `#title_page("Title")`) and
//                    its own cross-page label, e.g. `<linear_algebra_vectors>`
//                    — other files write `#link(<linear_algebra_vectors>)[…]`.
#let render(sections, depth: 1) = {
  for sec in sections {
    let is-leaf = "files" in sec
    if not is-leaf {
      if depth == 1 { title_page(sec.title) } else { heading(level: depth - 1, sec.title) }
    }
    // Offset included headings by the page's nesting depth so a file's own
    // title heading (`=`) always lands exactly where the group heading above
    // would, at any depth. Scoped to this block so it never leaks to
    // sibling/child titles. (depth 1 & 2 → offset 0; depth 3 → 1; …)
    {
      set heading(offset: calc.max(0, depth - 2))
      for f in sec.at("files", default: ()) {
        include src-prefix + f
      }
    }
    if "sections" in sec {
      render(sec.sections, depth: depth + 1)
    }
  }
}

#pagebreak()

#outline(indent: 1em, depth: 2)

#pagebreak()

#render(book.sections)
