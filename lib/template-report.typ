#import "helpers.typ": *
#import "pages-report.typ": *

#let report(
  option: (
    lang: "en",
    type: "draft",
  ),
  doc: (
    title: none,
    abbr: none,
    subtitle: none,
    url: none,
    logos: (
      tp_topleft: none,
      tp_topright: none,
      tp_bottomleft: none,
      tp_bottomright: none,
      tp_main: none,
      header: none,
    ),
    authors: (
      (
        name: none,
        abbr: none,
        email: none,
        url: none,
      ),
    ),
    school: (
      name: none,
      major: none,
      orientation: none,
      url: none,
    ),
    course: (
      name: none,
      url: none,
      prof: none,
      class: none,
      semester: none,
    ),
    keywords: ("Typst", "Template", "Report"),
    version: "v0.1.0",
  ),
  date: datetime.today(),
  tableof: (
    toc: true,
    tof: false,
    tot: false,
    tol: false,
    toe: false,
    maxdepth: 3,
  ),
  body,
) = {
  // Helper to fill default values for a dictionary
  let fill-defaults(d, defaults) = {
    if d == none { d = defaults }
    let result = (:)
    for (k, v) in defaults {
      result.insert(k, d.at(k, default: v))
    }
    result
  }

  // Sanitize inputs
  doc.title = doc.at("title", default: none)
  doc.abbr = doc.at("abbr", default: none)
  doc.subtitle = doc.at("subtitle", default: none)
  doc.url = doc.at("url", default: none)
  doc.logos = fill-defaults(doc.at("logos", default: none), (
    tp_topleft: none,
    tp_topright: none,
    tp_bottomleft: none,
    tp_bottomright: none,
    tp_main: none,
    header: none,
  ))
  doc.authors = if doc.at("authors", default: none) == none {
    ((name: none, abbr: none, email: none, url: none),)
  } else {
    doc.authors.map(a => fill-defaults(a, (name: none, abbr: none, email: none, url: none)))
  }
  doc.school = fill-defaults(doc.at("school", default: none), (
    name: none,
    major: none,
    orientation: none,
    url: none,
  ))
  doc.course = fill-defaults(doc.at("course", default: none), (
    name: none,
    url: none,
    prof: none,
    class: none,
    semester: none,
  ))
  doc.keywords = doc.at("keywords", default: ("Typst", "Template", "Report"))
  doc.version = doc.at("version", default: none)

  // basic properties
  set document(
    author: doc.authors.map(a => if a.name != none { a.name } else { "" }),
    title: doc.title,
    keywords: doc.keywords,
    date: date,
  )
  set page(margin: (top: 3cm, bottom: 3cm, left: 3cm, right: 2.5cm))

  // header and footer
  set page(
    header: context (
      if here().page() >= 2 [
        #set text(small)
        #table(
          columns: (80%, 20%),
          stroke: none,
          inset: -0.5em,
          align: (x, y) => (left + bottom, right + top).at(x),
          [#if doc.abbr != none { [#smallcaps(doc.abbr)] } #if doc.abbr != none and doc.title != none { [/] } #if (
              doc.title != none
            ) { smallcaps(doc.title) }],
          [#v(1.2cm)#doc.logos.header],
        )
        #if doc.logos.header != none {
          [
            #line(start: (-0.5em, 0cm), length: 85%, stroke: 0.5pt)
          ]
        } else {
          [
            #line(start: (-0.5em, 0cm), length: 100%, stroke: 0.5pt)
          ]
        }
      ]
    ),
    footer: context (
      if here().page() >= 2 [
        #set text(small)
        #line(start: (85%, 0cm), length: 15%, stroke: 0.5pt)
        #enumerating-emails(names: doc.authors.map(a => a.abbr), emails: doc.authors.map(a => a.email)) #if (
          doc.authors.first().abbr != none
        ) { [/] } #date.display("[year]") #h(1fr) #context counter(page).display("1 / 1", both: true)
      ]
    ),
  )

  // font & language
  set text(
    font: (
      "Libertinus Serif",
      "Fira Sans",
    ),
    fallback: true,
    lang: option.lang,
  )

  // heading
  show heading: set block(above: 1.2em, below: 1.2em)
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    set text(size: huge)
    set block(above: 1.2em, below: 1.2em)
    if it.numbering != none {
      let num = numbering(it.numbering, ..counter(heading).at(it.location()))
      let prefix = num + h(0.5em) + text(code-border)[|] + h(0.5em)
      unshift-prefix(prefix, it.body)
    } else {
      it
    }
  }

  show heading.where(level: 2): it => {
    if it.numbering != none {
      let num = numbering(it.numbering, ..counter(heading).at(it.location()))
      unshift-prefix(num + h(0.8em), it.body)
    }
  }

  // link color
  //show link: it => text(fill:blue, underline(it))
  //show link: it => text(fill:hei-blue, it)
  show link: it => text(fill: gray-80, it)

  show raw.where(block: false): set text(weight: "semibold")
  //show raw.where(block: false): it => {
  //  highlight(
  //    fill:code-bg,
  //    top-edge: "ascender",
  //    bottom-edge: "bounds",
  //    extent:1pt, it)
  //}
  show raw.where(block: true): set text(size: tiny)
  show raw.where(block: true): it => {
    block(
      fill: code-bg,
      width: 100%,
      inset: 10pt,
      radius: 4pt,
      stroke: 0.1pt + code-border,
      it,
    )
  }

  // Captions
  set figure(numbering: "1", supplement: it => get-supplement(it, lang: option.lang))
  set figure.caption(separator: " - ")
  set math.equation(numbering: "(1)", supplement: i18n("equation-name", lang: option.lang))

  show: word-count

  // Title page
  page-title-report(
    type: option.type,
    doc: doc,
    date: date,
  )

  pagebreak()
  // Table of content
  toc(
    tableof: tableof,
    lang: option.lang,
    before: <sec:glossary>,
  )

  // Main body
  set par(justify: true)

  body
}
