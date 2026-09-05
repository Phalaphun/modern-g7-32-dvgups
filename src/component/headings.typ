#import "../constants.typ": (
  default-appendix-heading-following-par-top-level-1,
  default-appendix-heading-following-par-top-other-levels,
  default-heading-margin,
  default-heading-level-1-margin,
  default-heading-level-1-following-par-top,
  default-indent,
  default-contents-heading-normal-case-left-align,
  default-contents-heading-uppercase,
  default-contents-heading-margin-bottom,
  default-introduction-heading-normal-case-left-align,
  default-introduction-heading-uppercase,
  default-conclusion-heading-normal-case-left-align,
  default-conclusion-heading-uppercase,
  default-references-heading-normal-case-left-align,
  default-references-heading-uppercase,
  default-system-headings-normal-case-left-align,
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

#let configurable-structural-heading-titles = (
  structural-heading-titles.performers,
  structural-heading-titles.abstract,
  structural-heading-titles.terms,
  structural-heading-titles.abbreviations,
  structural-heading-titles.intro,
  structural-heading-titles.conclusion,
  structural-heading-titles.references,
)

#let structure-heading-style(
  it,
  indent: default-indent,
  normal-case-left-align: false,
  uppercase: true,
) = {
  if normal-case-left-align {
    pad(left: indent, it)
  } else if uppercase {
    align(center)[#upper(it)]
  } else {
    align(center)[#it]
  }
}

#let structure-heading(body) = {
  structure-heading-style(heading(numbering: none)[#body])
}

#let headings(
  text-size,
  indent,
  add-pagebreaks,
  headings-not-bold,
  heading-level-1-following-par-top:
    default-heading-level-1-following-par-top,
  system-headings-normal-case-left-align:
    default-system-headings-normal-case-left-align,
  contents-heading-normal-case-left-align:
    default-contents-heading-normal-case-left-align,
  contents-heading-uppercase: default-contents-heading-uppercase,
  contents-heading-margin-bottom: default-contents-heading-margin-bottom,
  introduction-heading-normal-case-left-align:
    default-introduction-heading-normal-case-left-align,
  introduction-heading-uppercase: default-introduction-heading-uppercase,
  conclusion-heading-normal-case-left-align:
    default-conclusion-heading-normal-case-left-align,
  conclusion-heading-uppercase: default-conclusion-heading-uppercase,
  references-heading-normal-case-left-align:
    default-references-heading-normal-case-left-align,
  references-heading-uppercase: default-references-heading-uppercase,
) = body => {
  show heading: set text(size: text-size)
  set heading(numbering: "1.1")

  show heading: it => {
    let is-structural-heading = it.body in structural-heading-titles.values()
    let is-contents-heading = it.body == structural-heading-titles.contents
    let is-introduction-heading = it.body == structural-heading-titles.intro
    let is-conclusion-heading = it.body == structural-heading-titles.conclusion
    let is-references-heading = it.body == structural-heading-titles.references
    let is-configurable-structural-heading = (
      system-headings-normal-case-left-align
        and it.body in configurable-structural-heading-titles
    )
    let heading-content = if headings-not-bold {
      [
        #set text(weight: "regular")
        #it
      ]
    } else {
      it
    }

    if not is-structural-heading {
      pad(heading-content, left: indent)
    } else if is-contents-heading {
      structure-heading-style(
        heading-content,
        indent: indent,
        normal-case-left-align: contents-heading-normal-case-left-align,
        uppercase: contents-heading-uppercase,
      )
    } else if is-introduction-heading {
      structure-heading-style(
        heading-content,
        indent: indent,
        normal-case-left-align: introduction-heading-normal-case-left-align,
        uppercase: introduction-heading-uppercase,
      )
    } else if is-conclusion-heading {
      structure-heading-style(
        heading-content,
        indent: indent,
        normal-case-left-align: conclusion-heading-normal-case-left-align,
        uppercase: conclusion-heading-uppercase,
      )
    } else if is-references-heading {
      structure-heading-style(
        heading-content,
        indent: indent,
        normal-case-left-align: references-heading-normal-case-left-align,
        uppercase: references-heading-uppercase,
      )
    } else if is-configurable-structural-heading {
      structure-heading-style(
        heading-content,
        indent: indent,
        normal-case-left-align: true,
      )
    } else {
      structure-heading-style(heading-content, indent: indent)
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

  show heading: set block(..default-heading-margin)
  show heading.where(level: 1): set block(..default-heading-level-1-margin)
  show heading.where(
    level: 1,
    body: structural-heading-titles.contents,
  ): set block(below: contents-heading-margin-bottom)

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
          heading-level-1-following-par-top
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
