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
  body-leading: default-body-leading,
  contents-leading: default-contents-leading,
  contents-entry-spacing: default-contents-entry-spacing,
  table-after-text-gap: default-table-after-text-gap,
  table-after-table-gap: default-table-after-table-gap,
  table-before-text-gap: default-table-before-text-gap,
  table-before-heading-level-2-gap:
    default-table-before-heading-level-2-gap,
  listing-after-text-gap: default-listing-after-text-gap,
  listing-after-listing-gap: default-listing-after-listing-gap,
  listing-before-text-gap: default-listing-before-text-gap,
  listing-before-heading-level-2-gap:
    default-listing-before-heading-level-2-gap,
  listing-caption-gap: default-listing-caption-gap,
  listing-caption-indent: default-listing-caption-indent,
  listing-text-size: default-listing-text-size,
  listing-caption-text-size: default-listing-caption-text-size,
  listing-continuation-text-size: default-listing-continuation-text-size,
  long-listing-continuation-gap: default-long-listing-continuation-gap,
  long-listing-ending-gap: default-long-listing-ending-gap,
  long-listing-continuation-indent: default-long-listing-continuation-indent,
  long-listing-ending-indent: default-long-listing-ending-indent,
  table-caption-gap: default-table-caption-gap,
  long-table-continuation-gap: default-long-table-continuation-gap,
  long-table-ending-gap: default-long-table-ending-gap,
  long-table-continuation-indent: default-long-table-continuation-indent,
  long-table-ending-indent: default-long-table-ending-indent,
  table-cell-vertical-inset: default-table-cell-vertical-inset,
  title-footer-align: center,
  pagination-align: right,
  pagination-skip-pages: (),
  add-pagebreaks: true,
  section-number-prefix: false,
  headings-not-bold: default-headings-not-bold,
  heading-level-2-after-level-1-above:
    default-heading-level-2-after-level-1-above,
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
  appendix-heading-new-style: default-appendix-heading-new-style,
  appendix-heading-uppercase: default-appendix-heading-uppercase,
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
    body-leading,
    contents-leading,
    contents-entry-spacing,
    table-after-text-gap,
    table-after-table-gap,
    table-before-text-gap,
    table-before-heading-level-2-gap,
    listing-after-text-gap,
    listing-after-listing-gap,
    listing-before-text-gap,
    listing-before-heading-level-2-gap,
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
    skip-pagination-pages,
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
