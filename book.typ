// HTML book entry. Compile via:
//   typst compile --features bundle,html --format bundle --root . book.typ build/html/
// Then run `pagefind --site build/html` to add the search index.
//
// Reads /book.toml; emits one document(path: "…/index.html", title: …)
// per leaf section, plus index.html for the landing page. Sidebar, prev/next
// nav, and page shell are all generated inline by Typst — no external
// orchestrator. CSS is emitted once as a sibling asset and linked from each
// page. Cross-page #link(<label>) resolves automatically via bundle.

#import "/lib/imports.typ": *
#show: formatting
#show: web_setup

#let book = toml("/book.toml")
#let src-prefix = "/" + book.book.src + "/"

// === Path helpers ===

#let slug(s) = {
  let r = lower(s)
  for replacement in (
    (" ", "-"), ("/", "-"), ("(", ""), (")", ""),
    (",", ""), (".", ""), ("?", ""), ("'", ""),
  ) {
    r = r.replace(replacement.at(0), replacement.at(1))
  }
  r
}

#let section-path(title, parent: "") = {
  if parent == "" { slug(title) } else { parent + "/" + slug(title) }
}

// Collect leaves in book.toml order — used for prev/next navigation.
#let collect-leaves(secs, parent: "") = {
  let r = ()
  for sec in secs {
    let p = section-path(sec.title, parent: parent)
    if "files" in sec {
      r.push((path: p, title: sec.title))
    }
    if "sections" in sec {
      r += collect-leaves(sec.sections, parent: p)
    }
  }
  r
}

#let leaves = collect-leaves(book.sections)

// Relative path prefix (e.g. "../../") to reach the site root from a page.
#let rel-to-root(path) = {
  if path == "" { "" } else { "../" * (path.split("/").len()) }
}

// === Render sidebar (nested <ul>) ===

#let render-sidebar(secs, current-path, rel, parent: "") = {
  html.elem("ul", attrs: (class: "nav-list"), {
    for sec in secs {
      let p = section-path(sec.title, parent: parent)
      let is-leaf = "files" in sec
      let is-current = is-leaf and p == current-path
      let cls = "nav-item " + (if is-leaf { "nav-leaf" } else { "nav-group" }) + (if is-current { " current" } else { "" })
      html.elem("li", attrs: (class: cls), {
        if is-leaf {
          html.elem("a", attrs: (href: rel + p + "/index.html"), sec.title)
        } else {
          html.elem("span", attrs: (class: "nav-group-title"), sec.title)
        }
        if "sections" in sec {
          render-sidebar(sec.sections, current-path, rel, parent: p)
        }
      })
    }
  })
}

// === Render prev/next page nav ===

#let nav-bar(i, rel) = {
  html.elem("footer", attrs: (class: "page-nav"), {
    if i > 0 {
      let prev = leaves.at(i - 1)
      html.elem("a", attrs: (class: "nav-arrow prev", href: rel + prev.path + "/index.html"), "← " + prev.title)
    } else {
      html.elem("span")
    }
    if i < leaves.len() - 1 {
      let nxt = leaves.at(i + 1)
      html.elem("a", attrs: (class: "nav-arrow next", href: rel + nxt.path + "/index.html"), nxt.title + " →")
    } else {
      html.elem("span")
    }
  })
}

// === Render the page shell (sidebar + main + Pagefind hooks) ===

#let page-shell(current-path, content) = {
  let rel = rel-to-root(current-path)
  // CSS + Pagefind UI assets (linked relatively)
  html.elem("link", attrs: (rel: "stylesheet", href: rel + "style.css"), [])
  html.elem("link", attrs: (rel: "stylesheet", href: rel + "pagefind/pagefind-ui.css"), [])
  html.elem("script", attrs: (src: rel + "pagefind/pagefind-ui.js"), [])

  // Mobile nav toggle
  html.elem(
    "button",
    attrs: (class: "nav-toggle", "aria-label": "Toggle navigation", onclick: "document.body.classList.toggle('nav-open')"),
    "☰",
  )

  html.elem("aside", attrs: (class: "sidebar", "aria-label": "Site navigation"), {
    html.elem("header", attrs: (class: "site-title"), {
      html.elem("a", attrs: (href: rel + "index.html"), book.book.title)
    })
    html.elem("div", attrs: (id: "search"))
    html.elem("nav", render-sidebar(book.sections, current-path, rel))
    html.elem(
      "a",
      attrs: (class: "pdf-link", href: rel + "main.pdf", target: "_blank"),
      "📄 Read as PDF",
    )
  })

  html.elem("main", attrs: (id: "main"), content)

  // Pagefind UI init
  html.elem(
    "script",
    "window.addEventListener('DOMContentLoaded', () => { if (typeof PagefindUI !== 'undefined') new PagefindUI({ element: '#search', showSubResults: true }); });",
  )
}

// === Emit a leaf page ===

#let emit(sec, parent: "") = {
  let p = section-path(sec.title, parent: parent)
  if "files" in sec {
    let i = leaves.position(l => l.path == p)
    let rel = rel-to-root(p)
    document(p + "/index.html", title: sec.title)[
      #page-shell(p, {
        html.elem("article", attrs: ("data-pagefind-body": ""), {
          heading(level: 1, sec.title)
          for f in sec.files {
            include src-prefix + f
          }
        })
        nav-bar(i, rel)
      })
    ]
  }
  if "sections" in sec {
    for child in sec.sections { emit(child, parent: p) }
  }
}

// === Emit landing page ===

#document("index.html", title: book.book.title)[
  #page-shell("", {
    html.elem("article", {
      heading(level: 1, book.book.title)
      html.elem("p", "An interactive book covering linear algebra, calculus, probability, statistics, time series, operations research, supply chain, and more. Use the sidebar to navigate, search the index, or read as a single PDF.")
      html.elem("p", {
        html.elem("a", attrs: (class: "cta", href: "main.pdf", target: "_blank"), "📄 Read as PDF")
      })
    })
  })
]

// === Emit all leaves ===

#for sec in book.sections { emit(sec) }

// === Emit CSS as a sibling asset ===

#asset("style.css", read("/web/style.css"))
