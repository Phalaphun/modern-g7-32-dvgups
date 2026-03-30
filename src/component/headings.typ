#import "../constants.typ": default-heading-margin, default-heading-level-1-margin

#let structural-heading-titles = (
  performers: [Список исполнителей],
  abstract: [Реферат],
  contents: [Содержание],
  terms: [Термины и определения],
  abbreviations: [Перечень сокращений и обозначений],
  intro: [Введение],
  conclusion: [Заключение],
  references: [Список использованных источников],
)

#let structure-heading-style = it => {
  align(center)[#upper(it)]
}

#let structure-heading(body) = {
  structure-heading-style(heading(numbering: none)[#body])
}

#let headings(text-size, indent, add-pagebreaks) = body => {
  show heading: set text(size: text-size)
  set heading(numbering: "1.1")

  show heading: it => {
    if it.body not in structural-heading-titles.values() {
      pad(it, left: indent)
    } else {
      it
    }
  }

  show heading.where(level: 1): it => {
    if add-pagebreaks {
      pagebreak(weak: true)
    }

    it
  }

  let structural-heading = structural-heading-titles
    .values()
    .fold(selector, (acc, i) => acc.or(heading.where(body: i, level: 1)))

  show structural-heading: set heading(numbering: none)
  show structural-heading: it => {
    if add-pagebreaks {
      pagebreak(weak: true)
    }
    structure-heading-style(it)
  }

  show heading: set block(..default-heading-margin)
  show heading.where(level: 1): set block(..default-heading-level-1-margin)

  show par: it => context {
    let headings-before = query(selector(heading).before(here()))
    if headings-before.len() == 0 {
      it
    } else {
      let nearest-heading = headings-before.last()
      let paragraphs-after-heading-before-current = query(
        selector(par).after(nearest-heading.location()).before(here()),
      )

      if nearest-heading.level == 1 and paragraphs-after-heading-before-current.len() == 1 {
        pad(top: text-size, it)
      } else {
        it
      }
    }
  }

  body
}
