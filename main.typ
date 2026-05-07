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
//   depth 1  → top-level section, gets a title page
//   depth ≥2 → heading at level (depth − 1)
#let render(sections, depth: 1) = {
  for sec in sections {
    if depth == 1 {
      title_page(sec.title)
    } else {
      heading(level: depth - 1, sec.title)
    }
    for f in sec.at("files", default: ()) {
      include src-prefix + f
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
