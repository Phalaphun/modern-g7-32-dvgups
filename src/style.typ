#import "component/headings.typ": headings, structural-heading-titles
#import "component/appendixes.typ": is-heading-in-appendix

#import "constants.typ": *

#let gost-style(
  year,
  city,
  hide-title,
  text-size,
  small-text-size,
  indent,
  margin,
  title-footer-align,
  pagination-align,
  pagination-skip-pages,
  section-number-prefix,
  add-pagebreaks,
  body,
) = {
  let small-text-difference = (
    default-text-size.default - default-text-size.small
  )
  if small-text-size == none {
    small-text-size = text-size - small-text-difference
  }
  [#metadata((
    small-text-size: small-text-size,
    add-pagebreaks: add-pagebreaks,
    section-number-prefix: section-number-prefix,
  )) <modern-g7-32-parameters>]


  set page(margin: margin)

  set text(size: text-size, lang: "ru", hyphenate: false, font:("Times New Roman","Arial","Liberation Serif","Libertinus Serif"))

  set par(
    justify: default-justify,
    first-line-indent: (
      amount: indent,
      all: true,
    ),
    leading: default-leading,
    spacing: default-spacing,
  )

  set outline(indent: indent, depth: default-outline-depth)
  show outline: set block(below: indent / 2)
  show outline.entry: it => {
    show linebreak: [ ]
    if is-heading-in-appendix(it.element) {
      let body = it.element.body
      link(it.element.location(), it.indented(
        none,
        [Приложение #it.prefix() #it.element.body]
          + sym.space
          + box(width: 1fr, it.fill)
          + sym.space
          + sym.wj
          + it.page(),
      ))
    } else {
      it
    }
  }

  set ref(supplement: none)
  set figure.caption(separator: " — ")







    let figure-numbering = it => {
    let heading-state = counter(heading).get()
    if heading-state == none or heading-state.len() == 0 {
      return numbering("1", it)
    }

    let top-level = heading-state.first()
    if top-level == none {
      return numbering("1", it)
    }

    let chapter = if type(top-level) == array {
      top-level.at(0, default: 0)
    } else {
      top-level
    }
    if chapter <= 0 {
      return numbering("1", it)
    }

    numbering("1.1", chapter, it)
  }

  set figure(numbering: figure-numbering)






  // Equation numbering: with optional chapter prefix
  // if section-number-prefix {
    let equation-numbering = it => {
      let heading-state = counter(heading).get()
      let top-level = if heading-state == none or heading-state.len() == 0 { none } else { heading-state.first() }
      let chapter = if type(top-level) == array { top-level.at(0, default: 0) } else { top-level }
      let use = type(chapter) == int and chapter > 0 and it > 0
      let text = if use { numbering("1.1", chapter, it) } else { numbering("1", it) }
      [(#text)]
    }
    set math.equation(numbering: equation-numbering)
  // } else {
  //   set math.equation(numbering: "(1)")
  // }

  show image: set align(center)
  show figure.where(kind: image): set figure(supplement: [Рисунок])
  show figure.where(kind: image): set block(above: 24pt, below: 24pt)
  show figure.where(kind: image): set par(leading: 0.2em, first-line-indent: 0pt)
  show figure.caption.where(kind: image): set block(above: 12pt, below: 0pt)
  show figure.caption.where(kind: image): set par(leading: 0.5em, first-line-indent: 0pt)

  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    set block(breakable: true, above: 18pt, below: text-size)
    set align(left)
    it
  }
  show figure.caption.where(kind: table): it => {
    set align(left)
    set block(above: 0pt, below: 10pt)
    set par(
      leading: 0.5em,
      first-line-indent: (amount: default-indent, all: true),
    )

    [#it.supplement #it.counter.display(it.numbering)#it.separator#it.body]
  }
  show table.cell: set align(left)
  show table.cell: set block(width: 100%)
  // TODO: Расположить table.header по центру и сделать шрифт жирным

  show figure.where(kind: raw): it => {
    set figure.caption(position: top)
    set block(breakable: true, above: 18pt, below: text-size)
    set align(left)
    show raw.where(block: true): set block(
      width: 100%,
      inset: 6pt,
      stroke: 0.5pt + black,
    )
    it
  }
  show figure.caption.where(kind: raw): it => {
    set align(left)
    set block(above: 0pt, below: 10pt)
    set par(
      leading: 0.5em,
      first-line-indent: (amount: default-indent, all: true),
    )

    [#it.supplement #it.counter.display(it.numbering)#it.separator#it.body]
  }

  show heading.where(level: 1): it => context {
    if not state("appendixes", false).at(it.location()) {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      if section-number-prefix {
        counter(math.equation).update(0)
      }
    }
    it
  }

  set list(marker: [–], indent: indent, spacing: default-list-spacing)
  set enum(indent: indent, spacing: default-enum-spacing)


  set page(footer: context {
    let page-state = counter(page).get()
    let page-number = if page-state.len() > 0 { page-state.at(0) } else { none }
    if page-state == (1,) and not hide-title {
      align(title-footer-align)[#city #year]
    } else if page-number != none and pagination-skip-pages.any(page => page == page-number) {
      align(pagination-align)[ ]
    } else {
      align(pagination-align)[#counter(page).display()]
    }
  })

  set bibliography(
    style: "csl/gost-r-7-0-100-2018-numeric-alphabetical.csl",
    title: structural-heading-titles.references,
  )

  show: headings(text-size, indent, add-pagebreaks)
  body
}
