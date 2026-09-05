#import "component/headings.typ": headings, structural-heading-titles
#import "component/appendixes.typ": is-heading-in-appendix

#import "constants.typ": *

#let figure-flow-state = state("modern-g7-32-figure-flow", "other")

#let gost-style(
  year,
  city,
  hide-title,
  text-size,
  small-text-size,
  indent,
  margin,
  body-leading,
  contents-leading,
  contents-entry-spacing,
  outline-depth,
  table-after-text-gap,
  table-after-table-gap,
  table-before-text-gap,
  table-before-heading-level-2-gap,
  listing-after-text-gap,
  listing-after-listing-gap,
  listing-before-text-gap,
  listing-before-heading-level-2-gap,
  image-after-text-gap,
  image-caption-gap,
  image-before-text-gap,
  image-after-image-gap,
  image-before-heading-level-2-gap,
  listing-caption-gap,
  listing-caption-indent,
  listing-text-size,
  listing-caption-text-size,
  listing-continuation-text-size,
  long-listing-continuation-gap,
  long-listing-ending-gap,
  long-listing-continuation-indent,
  long-listing-ending-indent,
  table-caption-gap,
  long-table-continuation-gap,
  long-table-ending-gap,
  long-table-continuation-indent,
  long-table-ending-indent,
  table-cell-vertical-inset,
  title-footer-align,
  pagination-align,
  pagination-skip-pages,
  section-number-prefix,
  add-pagebreaks,
  headings-not-bold,
  heading-level-2-after-level-1-above,
  heading-level-1-following-par-top,
  system-headings-normal-case-left-align,
  contents-heading-normal-case-left-align,
  contents-heading-uppercase,
  contents-heading-margin-bottom,
  introduction-heading-normal-case-left-align,
  introduction-heading-uppercase,
  conclusion-heading-normal-case-left-align,
  conclusion-heading-uppercase,
  references-heading-normal-case-left-align,
  references-heading-uppercase,
  appendix-heading-new-style,
  appendix-heading-uppercase,
  body,
) = {
  let page-top-margin = if type(margin) == dictionary {
    margin.at("top", default: 0pt)
  } else {
    margin
  }
  let small-text-difference = (
    default-text-size.default - default-text-size.small
  )
  if small-text-size == none {
    small-text-size = text-size - small-text-difference
  }
  [#metadata((
    small-text-size: small-text-size,
    indent: indent,
    body-leading: body-leading,
    contents-leading: contents-leading,
    contents-entry-spacing: contents-entry-spacing,
    outline-depth: outline-depth,
    table-after-text-gap: table-after-text-gap,
    table-after-table-gap: table-after-table-gap,
    table-before-text-gap: table-before-text-gap,
    table-before-heading-level-2-gap: table-before-heading-level-2-gap,
    listing-after-text-gap: listing-after-text-gap,
    listing-after-listing-gap: listing-after-listing-gap,
    listing-before-text-gap: listing-before-text-gap,
    listing-before-heading-level-2-gap: listing-before-heading-level-2-gap,
    image-after-text-gap: image-after-text-gap,
    image-caption-gap: image-caption-gap,
    image-before-text-gap: image-before-text-gap,
    image-after-image-gap: image-after-image-gap,
    image-before-heading-level-2-gap: image-before-heading-level-2-gap,
    listing-caption-gap: listing-caption-gap,
    listing-caption-indent: listing-caption-indent,
    listing-text-size: listing-text-size,
    listing-caption-text-size: listing-caption-text-size,
    listing-continuation-text-size: listing-continuation-text-size,
    long-listing-continuation-gap: long-listing-continuation-gap,
    long-listing-ending-gap: long-listing-ending-gap,
    long-listing-continuation-indent: long-listing-continuation-indent,
    long-listing-ending-indent: long-listing-ending-indent,
    table-caption-gap: table-caption-gap,
    long-table-continuation-gap: long-table-continuation-gap,
    long-table-ending-gap: long-table-ending-gap,
    long-table-continuation-indent: long-table-continuation-indent,
    long-table-ending-indent: long-table-ending-indent,
    table-cell-vertical-inset: table-cell-vertical-inset,
    add-pagebreaks: add-pagebreaks,
    section-number-prefix: section-number-prefix,
    headings-not-bold: headings-not-bold,
    heading-level-2-after-level-1-above:
      heading-level-2-after-level-1-above,
    heading-level-1-following-par-top: heading-level-1-following-par-top,
    system-headings-normal-case-left-align:
      system-headings-normal-case-left-align,
    contents-heading-normal-case-left-align:
      contents-heading-normal-case-left-align,
    contents-heading-uppercase: contents-heading-uppercase,
    contents-heading-margin-bottom: contents-heading-margin-bottom,
    introduction-heading-normal-case-left-align:
      introduction-heading-normal-case-left-align,
    introduction-heading-uppercase: introduction-heading-uppercase,
    conclusion-heading-normal-case-left-align:
      conclusion-heading-normal-case-left-align,
    conclusion-heading-uppercase: conclusion-heading-uppercase,
    references-heading-normal-case-left-align:
      references-heading-normal-case-left-align,
    references-heading-uppercase: references-heading-uppercase,
    appendix-heading-new-style: appendix-heading-new-style,
    appendix-heading-uppercase: appendix-heading-uppercase,
  )) <modern-g7-32-parameters>]


  set page(margin: margin)

  set text(size: text-size, lang: "ru", hyphenate: false, font:("Times New Roman","Arial","Liberation Serif","Libertinus Serif"))

  set par(
    justify: default-justify,
    first-line-indent: (
      amount: indent,
      all: true,
    ),
    leading: body-leading,
    spacing: default-spacing,
  )
  show par: it => context {
    let previous-kind = figure-flow-state.at(here())
    let figure-base-below = text-size * default-table-and-raw-figure-below-lines
    let gap-adjustment = if previous-kind == "table" {
      table-before-text-gap - figure-base-below
    } else if previous-kind == "listing" {
      listing-before-text-gap - figure-base-below
    } else {
      0pt
    }
    [
      #if gap-adjustment != 0pt { v(gap-adjustment, weak: false) }
      #figure-flow-state.update("text")
      #it
    ]
  }

  set outline(indent: indent, depth: outline-depth)
  show outline: set par(leading: contents-leading)
  show outline: set block(below: indent / 2)
  show outline.entry: it => {
    show linebreak: [ ]
    let entry = if is-heading-in-appendix(it.element) {
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
    block(below: contents-entry-spacing, entry)
  }

  set ref(supplement: none)
  set figure.caption(separator: " – ")







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
  show figure.where(kind: image): it => context {
    let previous-kind = figure-flow-state.at(here())
    let at-page-top = here().position().y <= page-top-margin + 0.5pt
    let image-adjustment = if not at-page-top and previous-kind == "text" {
      image-after-text-gap - default-image-figure-margin.above
    } else if not at-page-top and previous-kind == "image" {
      image-after-image-gap - default-image-figure-margin.above
    } else {
      0pt
    }

    [
      #if image-adjustment != 0pt { v(image-adjustment, weak: false) }
      #it
      #figure-flow-state.update("image")
    ]
  }
  show figure.where(kind: image): set block(
    above: default-image-figure-margin.above,
    below: image-before-text-gap,
  )
  show figure.where(kind: image): set figure(gap: image-caption-gap)
  show figure.where(kind: image): set par(..default-image-par-style)
  show figure.caption.where(kind: image): set block(..default-image-caption-margin)
  show figure.caption.where(kind: image): set text(size: default-image-caption-text-size)
  show figure.caption.where(kind: image): set par(..default-image-caption-par-style)

  show figure.where(kind: table): it => context {
    let previous-kind = figure-flow-state.at(here())
    let above-space = if previous-kind == "text" {
      table-after-text-gap
    } else if previous-kind == "table" {
      table-after-table-gap
    } else {
      default-table-and-raw-figure-margin-above
    }
    let below-space = text-size * default-table-and-raw-figure-below-lines

    set figure.caption(position: top)
    set block(
      breakable: true,
      above: 0pt,
      below: 0pt,
    )
    set figure(gap: table-caption-gap)
    set align(left)
    set text(size: default-table-text-size)
    set table(inset: (x: 5pt, y: table-cell-vertical-inset))
    show table.cell: set align(left)
    show table.cell: set block(width: default-table-cell-width)
    show table.cell.where(y: 0): set align(center)
    block(
      breakable: true,
      above: above-space,
      below: 0pt,
    )[
      #figure-flow-state.update("other")
      #it
      #figure-flow-state.update("table")
      #v(below-space, weak: false)
    ]
  }
  show figure.caption.where(kind: table): it => {
    set align(left)
    set block(..default-table-caption-margin)
    set text(size: default-table-caption-text-size)
    set par(
      leading: default-table-and-raw-caption-leading,
      first-line-indent: 0pt,
    )

    [#it.supplement #it.counter.display(it.numbering)#it.separator#it.body]
  }
  show figure.where(kind: raw): it => context {
    let previous-kind = figure-flow-state.at(here())
    let above-space = if previous-kind == "text" {
      listing-after-text-gap
    } else if previous-kind == "listing" {
      listing-after-listing-gap
    } else {
      default-table-and-raw-figure-margin-above
    }
    let below-space = text-size * default-table-and-raw-figure-below-lines
    set figure.caption(position: top)
    set block(
      breakable: true,
      above: 0pt,
      below: 0pt,
    )
    set figure(gap: listing-caption-gap)
    set align(left)
    set text(size: listing-text-size)
    show raw.where(block: true): set block(..default-listing-raw-block-style)
    block(
      breakable: true,
      above: above-space,
      below: 0pt,
    )[
      #figure-flow-state.update("other")
      #it
      #figure-flow-state.update("listing")
      #v(below-space, weak: false)
    ]
  }
  show figure.caption.where(kind: raw): it => {
    set align(left)
    set block(..default-listing-caption-margin)
    set text(size: listing-caption-text-size)
    set par(
      leading: default-table-and-raw-caption-leading,
      first-line-indent: (amount: listing-caption-indent, all: true),
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
  show heading: it => context {
    let previous-kind = figure-flow-state.at(here())
    let previous-is-image = (
      previous-kind == "image"
        and here().position().y > page-top-margin + 0.5pt
    )
    let figure-base-below = text-size * default-table-and-raw-figure-below-lines
    let gap-adjustment = if previous-kind == "table" and it.level == 2 {
      table-before-heading-level-2-gap - figure-base-below
    } else if previous-kind == "listing" and it.level == 2 {
      listing-before-heading-level-2-gap - figure-base-below
    } else if previous-is-image and it.level == 2 {
      image-before-heading-level-2-gap - default-heading-margin.above
    } else {
      0pt
    }
    [
      #if gap-adjustment != 0pt { v(gap-adjustment, weak: false) }
      #figure-flow-state.update("other")
      #it
    ]
  }

  set list(marker: [-], indent: indent, spacing: default-list-spacing)
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
  show bibliography: it => {
    show regex("(?m)^\\d+\\."): it => [#h(indent)#it]
    show regex("\\t"): _ => h(0.5em)
    it
  }

  show: headings(
    text-size,
    indent,
    add-pagebreaks,
    headings-not-bold,
    heading-level-2-after-level-1-above:
      heading-level-2-after-level-1-above,
    heading-level-1-following-par-top:
      heading-level-1-following-par-top,
    system-headings-normal-case-left-align:
      system-headings-normal-case-left-align,
    contents-heading-normal-case-left-align:
      contents-heading-normal-case-left-align,
    contents-heading-uppercase: contents-heading-uppercase,
    contents-heading-margin-bottom: contents-heading-margin-bottom,
    introduction-heading-normal-case-left-align:
      introduction-heading-normal-case-left-align,
    introduction-heading-uppercase: introduction-heading-uppercase,
    conclusion-heading-normal-case-left-align:
      conclusion-heading-normal-case-left-align,
    conclusion-heading-uppercase: conclusion-heading-uppercase,
    references-heading-normal-case-left-align:
      references-heading-normal-case-left-align,
    references-heading-uppercase: references-heading-uppercase,
  )
  body
}
