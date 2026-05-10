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
    ("& ", ""), (" & ", " "), ("&", ""),
    ("–", "-"), ("—", "-"),
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

// Cross-page link tag: section path with "/" → "-" (e.g.
// calculus/calculus-i/quotient-rule → calculus-calculus-i-quotient-rule).
// Source files reference it via #link(<calculus-calculus-i-quotient-rule>)[…].
#let path-tag(p) = p.replace("/", "-")

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

// === Render sidebar (nested <ul>, with <details> for collapsible groups) ===

// True if `current-path` is inside the subtree rooted at `path` (ancestor or self).
#let is-ancestor-of(path, current) = {
  current == path or current.starts-with(path + "/")
}

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
        } else if "sections" in sec {
          // Collapsible group via <details>. Open by default if the current
          // page is inside this subtree, otherwise collapsed.
          let open-attrs = if is-ancestor-of(p, current-path) { (open: "") } else { (:) }
          html.elem("details", attrs: open-attrs, {
            html.elem("summary", sec.title)
            render-sidebar(sec.sections, current-path, rel, parent: p)
          })
        } else {
          html.elem("span", attrs: (class: "nav-group-title"), sec.title)
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
  // CSS + Pagefind UI assets (linked relatively).
  // Order matters: style.css must come AFTER pagefind-ui.css so our
  // overrides (input height, drawer position, scaled icon) win on
  // ties of specificity with Pagefind's `.svelte-...` scoped rules.
  html.elem("link", attrs: (rel: "stylesheet", href: rel + "pagefind/pagefind-ui.css"), [])
  html.elem("link", attrs: (rel: "stylesheet", href: rel + "style.css"), [])
  html.elem("script", attrs: (src: rel + "pagefind/pagefind-ui.js"), [])

  // === Top bar: nav-toggle, back/forward buttons, search === //
  // nav-toggle handler is wired up in the JS block at the bottom
  // (handles desktop collapse + mobile slide-in based on viewport).
  html.elem("header", attrs: (class: "topbar"), {
    html.elem(
      "button",
      attrs: (class: "nav-toggle", "aria-label": "Toggle navigation"),
      "☰",
    )
    html.elem("div", attrs: (class: "nav-buttons"), {
      html.elem(
        "button",
        attrs: (class: "history-btn", "aria-label": "Back", onclick: "history.back()"),
        "←",
      )
      html.elem(
        "button",
        attrs: (class: "history-btn", "aria-label": "Forward", onclick: "history.forward()"),
        "→",
      )
    })
    html.elem("div", attrs: (id: "search"))
  })

  // === Sidebar === //
  html.elem("aside", attrs: (class: "sidebar", "aria-label": "Site navigation"), {
    html.elem("header", attrs: (class: "site-title"), {
      html.elem("a", attrs: (href: rel + "index.html"), book.book.title)
    })
    html.elem("nav", render-sidebar(book.sections, current-path, rel))
  })

  // Drag handle for resizing the sidebar (desktop only — hidden on mobile
  // and when the sidebar is collapsed). JS below tracks pointer drag and
  // updates --sidebar-w (persisted in localStorage).
  html.elem("div", attrs: (class: "sidebar-resizer", "aria-hidden": "true"))

  html.elem("main", attrs: (id: "main"), content)

  // Pagefind UI init. processResult appends a text-fragment
  // (`#:~:text=<query>`) to each result URL so that clicking a result lands
  // on the page scrolled to the matched text with native browser highlight
  // (no extra JS / mark.js needed; supported in Chrome, Edge, Safari 16.1+,
  // Firefox 131+).
  html.elem(
    "script",
    "window.addEventListener('DOMContentLoaded', () => {"
      + " if (typeof PagefindUI === 'undefined') return;"
      + " const addTextFrag = (url, q) => {"
      + "   if (!q) return url;"
      + "   const enc = encodeURIComponent(q);"
      + "   if (url.includes(':~:text=')) return url;"
      + "   return url.includes('#') ? url + ':~:text=' + enc"
      + "                            : url + '#:~:text=' + enc;"
      + " };"
      + " new PagefindUI({"
      + "   element: '#search',"
      + "   showSubResults: true,"
      + "   processResult: (result) => {"
      + "     const inp = document.querySelector('.pagefind-ui__search-input');"
      + "     const q = inp ? inp.value.trim() : '';"
      + "     result.url = addTextFrag(result.url, q);"
      + "     if (result.sub_results) {"
      + "       result.sub_results.forEach(sr => { sr.url = addTextFrag(sr.url, q); });"
      + "     }"
      + "     return result;"
      + "   },"
      + " });"
      + "});",
  )

  // Sidebar toggle (top-left button) + drag-to-resize handle.
  // - Toggle: click button → on desktop collapses/expands the sidebar
  //   (body class `sidebar-collapsed`, persisted); on mobile, slides it in
  //   (body class `nav-open`, the existing overlay behavior).
  // - Resize: pointer-drag the .sidebar-resizer to set --sidebar-w
  //   (clamped 180–600px, persisted in localStorage). Drag below 120px
  //   auto-collapses the sidebar (release threshold).
  html.elem(
    "script",
    "(() => {"
      + " const root = document.documentElement, body = document.body;"
      + " const W_KEY = 'ieor-sidebar-w', C_KEY = 'ieor-sidebar-collapsed';"
      + " const MOBILE = 900;"
      + " const savedW = localStorage.getItem(W_KEY);"
      + " if (savedW) root.style.setProperty('--sidebar-w', savedW + 'px');"
      + " if (localStorage.getItem(C_KEY) === '1' && window.innerWidth > MOBILE)"
      + "   body.classList.add('sidebar-collapsed');"
      + " const btn = document.querySelector('.nav-toggle');"
      + " if (btn) btn.addEventListener('click', () => {"
      + "   if (window.innerWidth <= MOBILE) {"
      + "     body.classList.toggle('nav-open');"
      + "   } else {"
      + "     body.classList.toggle('sidebar-collapsed');"
      + "     localStorage.setItem(C_KEY, body.classList.contains('sidebar-collapsed') ? '1' : '0');"
      + "   }"
      + " });"
      + " const rz = document.querySelector('.sidebar-resizer');"
      + " if (rz) rz.addEventListener('pointerdown', (e) => {"
      + "   e.preventDefault();"
      + "   rz.setPointerCapture(e.pointerId);"
      + "   body.classList.add('resizing');"
      + "   const COLLAPSE_AT = 120;"
      + "   let cleanup;"
      + "   const onMove = (ev) => {"
      + "     if (ev.clientX < COLLAPSE_AT) {"
      + "       body.classList.add('sidebar-collapsed');"
      + "       localStorage.setItem(C_KEY, '1');"
      + "       cleanup();"
      + "       return;"
      + "     }"
      + "     const w = Math.min(600, Math.max(180, ev.clientX));"
      + "     root.style.setProperty('--sidebar-w', w + 'px');"
      + "   };"
      + "   cleanup = () => {"
      + "     try { rz.releasePointerCapture(e.pointerId); } catch (_) {}"
      + "     body.classList.remove('resizing');"
      + "     rz.removeEventListener('pointermove', onMove);"
      + "     rz.removeEventListener('pointerup', cleanup);"
      + "     const w = parseInt(getComputedStyle(root).getPropertyValue('--sidebar-w'));"
      + "     if (!isNaN(w)) localStorage.setItem(W_KEY, String(w));"
      + "   };"
      + "   rz.addEventListener('pointermove', onMove);"
      + "   rz.addEventListener('pointerup', cleanup);"
      + " });"
      + "})();",
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
          [#heading(level: 1, sec.title) #std.label(path-tag(p))]
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
      html.elem("p", "An interactive book covering linear algebra, calculus, probability, statistics, time series, operations research, supply chain, and more. Use the sidebar to navigate or search the index.")
    })
  })
]

// === Emit all leaves ===

#for sec in book.sections { emit(sec) }

// === Emit CSS as a sibling asset ===

#asset("style.css", read("/web/style.css"))
