#import "boxes.typ": *
#import "images.typ": *
#import "constants.typ": *

#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/glossarium:0.5.3": *
#import "@preview/wordometer:0.1.4": word-count

//-------------------------------------
// Internationalization
//
#let langs = json("i18n.json")
#let i18n(
  key,
  lang: "en",
  extra-i18n: none,
) = {
  if type(extra-i18n) == dictionary {
    for (lng, keys) in extra-i18n {
      if not lng in langs {
        langs.insert(lng, (:))
      }
      langs.at(lng) += keys
    }
  }
  if not lang in langs {
    lang = "en"
  }
  let keys = langs.at(lang)
  assert(
    key in keys,
    message: "I18n key " + str(key) + " doesn't exist",
  )
  return keys.at(key)
}

#let get-supplement(
  it,
  lang: "en",
) = {
  let f = it.func()
  if (f == image) {
    i18n("figure-name", lang: lang)
  } else if (f == table) {
    i18n("table-name", lang: lang)
  } else if (f == raw) {
    i18n("listing-name", lang: lang)
  } else if (f == math.equation) {
    i18n("equation-name", lang: lang)
  } else {
    auto
  }
}
//-------------------------------------
// Reference helper function
//
#let myref(label) = context {
  if query(label).len() != 0 {
    ref(label)
  } else {
    text(fill: red)[?]
  }
}

//-------------------------------------
// Specifications
//
#let full-page(path) = {
  set page(margin: (
    top: 0cm,
    bottom: 0cm,
    x: 0cm,
  ))

  if path != none {
    image(path, width: 100%)
  } else {
    table(
      columns: 100%,
      rows: 100%,
      stroke: none,
      align: center + horizon,
      [
        #rotate(
          -45deg,
          origin: center + horizon,
        )[
          #text(fill: red, size: huger)[
            No page found
          ]
        ]
      ]
    )
  }
}

//-------------------------------------
// Table of content
//
#let toc(
  tableof: (
    toc: true,
    tof: false,
    tot: false,
    tol: false,
    toe: false,
    maxdepth: 3,
  ),
  titles: none,
  lang: "en",
  before: none,
  indent: auto,
) = {
  let default-titles = (
    toc: i18n("toc-title", lang: lang),
    tof: i18n("tof-title", lang: lang),
    tot: i18n("tot-title", lang: lang),
    tol: i18n("tol-title", lang: lang),
    toe: i18n("toe-title", lang: lang),
  )
  if titles == none { titles = default-titles }
  for (k, v) in default-titles {
    if not k in titles { titles.insert(k, v) }
  }
  // Table of content
  if tableof.toc == true {
    if before != none {
      outline(
        title: titles.toc,
        target: selector(heading).before(before, inclusive: true),
        indent: indent,
        depth: tableof.maxdepth,
      )
    } else {
      outline(
        title: titles.toc,
        indent: indent,
        depth: tableof.maxdepth,
      )
    }
  }

  // Table of figures
  if tableof.tof == true {
    outline(
      title: titles.tof,
      target: figure.where(kind: image),
      indent: indent,
      depth: tableof.maxdepth,
    )
  }

  // Table of tables
  if tableof.tot == true {
    outline(
      title: titles.tot,
      target: figure.where(kind: table),
      indent: indent,
      depth: tableof.maxdepth,
    )
  }

  // Table of listings
  if tableof.tol == true {
    outline(
      title: titles.tol,
      target: figure.where(kind: raw),
      indent: indent,
      depth: tableof.maxdepth,
    )
  }

  // Table of equation
  if tableof.toe == true {
    outline(
      title: titles.toe,
      target: math.equation.where(block: true),
      indent: indent,
      depth: tableof.maxdepth,
    )
  }
}

#let minitoc(
  after: none,
  before: none,
  addline: true,
  stroke: 0.5pt,
  length: 100%,
  depth: 3,
  lang: "en",
  title: none,
  indent: auto,
) = {
  if title == none { title = i18n("toc-title", lang: lang) }
  v(2em)
  text(large, weight: "bold", title)
  if addline == true {
    line(length: length, stroke: stroke)
  }
  let h = selector(heading.where(level: 2))
    .or(heading.where(level: 3))
    .or(heading.where(level: 4))
    .or(heading.where(level: 5))
    .or(heading.where(level: 6))
    .or(heading.where(level: 7))
    .or(heading.where(level: 8))
    .or(heading.where(level: 9))
    .or(heading.where(level: 10))
  outline(
    title: none,
    target: selector(h).after(after).before(before, inclusive: false),
    depth: depth,
    indent: indent,
  )
  if addline == true {
    line(length: length, stroke: stroke)
  }
}

//--------------------------------------
// Heading shift
//
// #unshift-prefix[Prefix][Body]
#let unshift-prefix(prefix, content) = context {
  pad(left: -measure(prefix).width, prefix + content)
}

//-------------------------------------
// Research
//
// item, item, item and item List
//
#let enumerating-authors(
  items: none,
  multiline: false,
) = {
  let i = 1
  if items != none {
    for item in items {
      if item != none {
        if "name" in item {
          if i > 1 {
            if multiline == true {
              if items.len() > 2 {
                [\ ]
              } else {
                [, ]
              }
            } else {
              [, ]
            }
          }
          i = i + 1
          if "institute" in item {
            [#item.name#super(repr(item.institute))]
          } else {
            [#item.name]
          }
        }
      }
    }
  }
}

#let enumerating-institutes(
  items: none,
) = {
  let i = 1
  if items != none {
    for item in items {
      if item != none {
        [_#super(repr(i))_ #if item.research_group != none { [_ #item.research_group - _] } _ #item.name __, #item.address _ \ ]
        i = i + 1
      }
    }
  }
}

//-------------------------------------
// Script
//
// item, item, item and item List
//
#let enumerating-items(
  items: none,
  bold: false,
  italic: false,
) = {
  let i = 1
  if items != none {
    for item in items {
      if item != none {
        if bold == true and italic == true {
          [#text(style: "italic")[*#item*]]
        } else if bold == true {
          [*#item*]
        } else if italic == true {
          [#text(style: "italic")[#item]]
        } else {
          [#item]
        }
        if i < items.len() {
          [, ]
        }
      }
      i = i + 1
    }
  }
}
#let enumerating-links(
  names: none,
  links: none,
) = {
  if names != none {
    let i = 0
    for name in names {
      if name != none {
        [#link(links.at(i))[#name]]
        if i + 1 < names.len() {
          [, ]
        }
      }
      i = i + 1
    }
  }
}
#let enumerating-emails(
  names: none,
  emails: none,
) = {
  if names != none {
    let i = 0
    for name in names {
      if name != none {
        [#link("mailto:" + emails.at(i))[#name]]
        if i + 1 < names.len() {
          [, ]
        }
      }
      i = i + 1
    }
  }
}

//-------------------------------------
// safe-link
//
#let safe-link(
  name: none,
  url: none,
) = {
  if name != none {
    if url != none {
      link(url)[#name]
    } else {
      name
    }
  } else {
    if url != none {
      link(url)[#url]
    } else {
      none
    }
  }
}

//-------------------------------------
// Chapter
//
#let add-chapter(
  file: none,
  heading-offset: 0,
  after: none,
  before: none,
  pb: false,
  lang: "en",
  minitoc-title: none,
  body,
) = [
  #if minitoc-title == none { minitoc-title = i18n("toc-title", lang: lang) }
  #if (after != none and before != none) {
    minitoc(title: minitoc-title, after: after, before: before, indent: auto, lang: lang)
    if pb {
      pagebreak()
    }
  }
  #set heading(offset: heading-offset)

  #if (file != none) {
    include file
  } else {
    body
  }
  #set heading(offset: 0)
]

//-------------------------------------
// Blockquote
//
#let blockquote(body) = {
  block(
    width: 100%,
    inset: (left: 1.5em, top: 0.5em, bottom: 0.5em),
    stroke: (left: 2pt + gray-50),
  )[
    #text(style: "italic", fill: gray-60)[#body]
  ]
}

//-------------------------------------
// Keyboard shortcut
//
#let kbd(key) = {
  box(
    stroke: 0.5pt + gray-50,
    radius: 3pt,
    inset: (x: 0.4em, y: 0.2em),
    baseline: 0.2em,
    fill: gray-10,
  )[
    #text(size: 0.85em, weight: "semibold")[#raw(key)]
  ]
}
