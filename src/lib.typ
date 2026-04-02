#import "style.typ": gost-style
#import "utils.typ": fetch-field
#import "component/title-templates.typ": templates
#import "component/performers.typ": fetch-performers, performers-page

#import "constants.typ": *

#let gost-common(
  title-template,
  title-arguments,
  city,
  year,
  hide-title,
  performers,
  force-performers,
) = {
  set par(justify: false)

  title-arguments = title-arguments.named()

  title-arguments.insert("year", year)

  let show-performers-page = false
  if performers != none {
    performers = fetch-performers(performers)
    if (performers.len() > 1 or force-performers) {
      show-performers-page = true
    } else {
      title-arguments.insert("performer", performers.first())
    }
  }

  if not hide-title {
    title-template(..title-arguments)
  }

  if show-performers-page { performers-page(performers) }
}

#let gost(
  title-template: templates.default,
  text-size: default-text-size,
  indent: default-indent,
  margin: default-margin,
  title-footer-align: center,
  pagination-align: center,
  pagination-skip-pages: (),
  add-pagebreaks: true,
  section-number-prefix: false,
  headings-not-bold: default-headings-not-bold,
  appendix-heading-new-style: default-appendix-heading-new-style,
  city: none,
  year: auto,
  hide-title: false,
  performers: none,
  force-performers: false,
  ..title-arguments,
  body,
) = {
  if year == auto {
    year = int(datetime.today().display("[year]"))
  }

  text-size = fetch-field(text-size, ("default*", "small"))

  let skip-pagination-pages = pagination-skip-pages
  if skip-pagination-pages == none {
    skip-pagination-pages = ()
  } else if type(skip-pagination-pages) != array {
    skip-pagination-pages = (skip-pagination-pages,)
  }

  show: gost-style.with(
    year,
    city,
    hide-title,
    text-size.default,
    text-size.small,
    indent,
    margin,
    title-footer-align,
    pagination-align,
    skip-pagination-pages,
    section-number-prefix,
    add-pagebreaks,
    headings-not-bold,
    appendix-heading-new-style,
  )

  gost-common(
    title-template,
    title-arguments,
    city,
    year,
    hide-title,
    performers,
    force-performers,
  )

  body
}
