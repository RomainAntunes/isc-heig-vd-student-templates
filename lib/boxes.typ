#import "constants.typ": *

#let option-style(
  type: none,
  size: small,
  style: "italic",
  fill: gray-40,
  body,
) = {
  [
    #if type == none {
      text(size: size, style: style, fill: fill)[#body]
    } else {
      if type == "draft" { text(size: size, style: style, fill: fill)[#body] }
    }
  ]
}

#let icon-circle(
  body,
  color: color-info,
  radius: 0.4em,
) = {
  box(
    fill: color,
    radius: radius,
    inset: 0.3em,
    baseline: 0.15em,
    text(fill: white, weight: "bold", size: 0.75em)[#body],
  )
}

#let question(body, title: "QUESTION") = [
  #let rblock = block.with(stroke: gray, radius: 0.4em, fill: gray.lighten(80%))
  #let top-left = place.with(top + left, dx: 1em, dy: -0.35em)
  #block(inset: (top: 0.35em), {
    rblock(width: 100%, inset: 1em, body)
    top-left(rblock(fill: white, outset: 0.25em, text(fill: gray.darken(20%))[*#title*]))
  })
  <question>
]

#let colorbox(
  title: "title",
  color: color-todo,
  stroke: 0.5pt,
  radius: 4pt,
  width: auto,
  body,
) = {
  let strokeColor = color
  let backgroundColor = color.lighten(50%)

  return box(
    fill: backgroundColor,
    stroke: stroke + strokeColor,
    radius: radius,
    width: width,
  )[
    #block(
      fill: strokeColor,
      inset: 8pt,
      radius: (top-left: radius, bottom-right: radius),
    )[
      #text(fill: white, weight: "bold")[#title]
    ]
    #block(
      width: 100%,
      inset: (x: 8pt, bottom: 8pt),
    )[
      #body
    ]
  ]
}

#let slanted-background(
  color: black,
  body,
) = {
  set text(fill: white, weight: "bold")
  context {
    let size = measure(body)
    let inset = 8pt
    [#block()[
      #polygon(
        fill: color,
        (0pt, 0pt),
        (0pt, size.height + (2 * inset)),
        (size.width + (2 * inset), size.height + (2 * inset)),
        (size.width + (2 * inset) + 6pt, 0cm),
      )
      #place(center + top, dy: size.height, dx: -3pt)[#body]
    ]]
  }
}

#let slanted-colorbox(
  title: "title",
  color: color-todo,
  stroke: 0.5pt,
  radius: 4pt,
  width: auto,
  body,
) = {
  let strokeColor = color
  let backgroundColor = color.lighten(50%)

  return box(
    fill: backgroundColor,
    stroke: stroke + strokeColor,
    radius: radius,
    width: width,
  )[
    #slanted-background(color: strokeColor)[#title]
    #block(
      width: 100%,
      inset: (top: -2pt, x: 10pt, bottom: 10pt),
    )[
      #body
    ]
  ]
}

#let infobox(body, title: "Info") = {
  colorbox(title: title, color: color-info, body)
}

#let warningbox(body, title: "Warning") = {
  colorbox(title: title, color: color-warning, body)
}

#let importantbox(body, title: "Important") = {
  colorbox(title: title, color: color-important, body)
}

#let ideabox(body, title: "Idea") = {
  colorbox(title: title, color: color-idea, body)
}

#let todobox(body, title: "TODO") = {
  colorbox(title: title, color: color-todo, body)
}
