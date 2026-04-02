#import "../constants.typ": (
  default-appendix-heading-following-par-top-level-1,
  default-appendix-heading-following-par-top-other-levels,
  default-heading-margin,
  default-heading-level-1-margin,
)
#import "appendixes.typ": is-heading-in-appendix

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

#let headings(text-size, indent, add-pagebreaks, headings-not-bold) = body => {
  show heading: set text(size: text-size)
  set heading(numbering: "1.1")

  show heading: it => {
    let heading-content = if headings-not-bold {
      [
        #set text(weight: "regular")
        #it
      ]
    } else {
      it
    }

    if it.body not in structural-heading-titles.values() {
      pad(heading-content, left: indent)
    } else {
      heading-content
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
    let heading-content = structure-heading-style(it)
    if headings-not-bold {
      [
        #set text(weight: "regular")
        #heading-content
      ]
    } else {
      heading-content
    }
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

      if paragraphs-after-heading-before-current.len() == 1 {
        let top-padding = if is-heading-in-appendix(nearest-heading) {
          if nearest-heading.level == 1 {
            default-appendix-heading-following-par-top-level-1
          } else {
            default-appendix-heading-following-par-top-other-levels
          }
        } else if nearest-heading.level == 1 {
          text-size
        } else {
          0pt
        }
        if top-padding == 0pt {
          it
        } else {
          pad(top: top-padding, it)
        }
      } else {
        it
      }
    }
  }

  body
}
