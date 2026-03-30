#import "../constants.typ": (
  default-long-listing-continuation-cell-inset,
  default-long-listing-end-marker-cell-inset,
  default-long-listing-end-marker-value,
  default-long-listing-figure-gap,
  default-long-listing-frame-cell-inset,
  default-long-listing-line-cell-inset,
  default-listing-raw-block-style,
  default-table-and-raw-caption-leading,
)

#let marker-after-current-page(marker-position, current-position) = {
  marker-position.page > current-position.page or (
    marker-position.page == current-position.page
      and marker-position.y >= current-position.y
  )
}

#let nearest-end-marker(current-position) = {
  let markers = query(metadata.where(value: default-long-listing-end-marker-value))
    .filter(marker => {
      let marker-position = marker.location().position()
      marker-after-current-page(marker-position, current-position)
    })
    .sorted(key: marker => {
      let marker-position = marker.location().position()
      (marker-position.page, marker-position.y)
    })

  markers.at(0, default: none)
}

#let current-listing-number() = {
  let figure-elements = query(figure.where(kind: raw).before(here()))
  let current-figure = figure-elements.at(-1, default: none)

  if current-figure == none {
    return counter(figure.where(kind: raw)).display()
  }

  let figure-fields = current-figure.fields()
  let figure-counter = figure-fields.at(
    "counter",
    default: counter(figure.where(kind: raw)),
  )
  let figure-numbering = figure-fields.at("numbering", default: "1")

  figure-counter.display(figure-numbering)
}

#let continuation-title() = context {
  let current-position = here().position()
  let figure-elements = query(figure.where(kind: raw).before(here()))
  let current-figure = figure-elements.at(-1, default: none)

  if current-figure == none {
    return []
  }

  let first-page = current-position.page == current-figure.location().page()
  if first-page {
    return []
  }

  let marker = nearest-end-marker(current-position)
  let last-page = marker != none and marker.location().page() == current-position.page
  let number = current-listing-number()
  let continuation-text = if last-page {
    [Окончание листинга #number.]
  } else {
    [Продолжение листинга #number]
  }

  set par(
    leading: default-table-and-raw-caption-leading,
    first-line-indent: 0pt,
  )

  continuation-text
}

#let trim-single-trailing-empty(lines) = {
  if lines.len() > 0 and lines.at(-1) == "" {
    return lines.slice(0, lines.len() - 1)
  }
  lines
}

#let long-listing(
  raw-content,
  caption: none,
  ..figure-args,
) = {
  assert(
    type(raw-content) == content and raw-content.func() == raw,
    message: "long-listing ожидает первым аргументом raw(...).",
  )
  assert(caption != none, message: "Для long-listing требуется caption: ...")

  let raw-fields = raw-content.fields()
  let raw-block = raw-fields.at("block", default: false)
  assert(raw-block, message: "long-listing поддерживает только raw(..., block: true).")

  let raw-text = raw-fields.at("text", default: "")
  let raw-lang = raw-fields.at("lang", default: none)
  let raw-lines = trim-single-trailing-empty(raw-text.split("\n"))

  let continuation-row = table.cell(
    colspan: 1,
    stroke: none,
    inset: default-long-listing-continuation-cell-inset,
  )[
    #continuation-title()
  ]

  let lines-table = table(
    columns: (1fr,),
    stroke: none,
    ..raw-lines.map(line => {
      let line-content = if raw-lang == none {
        raw(line, block: false)
      } else {
        raw(line, lang: raw-lang, block: false)
      }

      table.cell(
        stroke: none,
        inset: default-long-listing-line-cell-inset,
      )[#line-content]
    }),
  )

  let listing-frame = block(..default-listing-raw-block-style)[#lines-table]

  let end-marker-footer = table.footer(
    repeat: false,
    table.cell(
      colspan: 1,
      stroke: none,
      inset: default-long-listing-end-marker-cell-inset,
    )[
      #hide(metadata(default-long-listing-end-marker-value))
    ],
  )

  figure(
    table(
      columns: (1fr,),
      stroke: none,
      table.header(
        repeat: true,
        continuation-row,
      ),
      table.cell(stroke: none, inset: default-long-listing-frame-cell-inset)[#listing-frame],
      end-marker-footer,
    ),
    kind: raw,
    gap: default-long-listing-figure-gap,
    caption: caption,
    ..figure-args,
  )
}
