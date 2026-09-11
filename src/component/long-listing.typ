#import "../constants.typ": (
  default-long-listing-continuation-text-size,
  default-long-listing-continuation-cell-inset,
  default-long-listing-continuation-gap,
  default-long-listing-ending-gap,
  default-long-listing-continuation-indent,
  default-long-listing-ending-indent,
  default-long-listing-end-marker-cell-inset,
  default-long-listing-end-marker-value,
  default-long-listing-frame-cell-inset,
  default-long-listing-line-cell-inset,
  default-long-listing-line-number-cell-inset,
  default-long-listing-semantic-caption-marker,
  default-listing-raw-block-style,
  default-listing-caption-gap,
  default-listing-caption-indent,
  default-listing-caption-text-size,
  default-long-listing-data-cell-marker,
  default-long-listing-first-line-cell-marker,
  default-table-and-raw-caption-leading,
  default-indent,
)
//TODO: Реализовать автоматическое выравнивание по левому краю. Чтобы отрезались лишние отступы табуляции. 
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

#let page-title(
  caption,
  caption-gap,
  continuation-gap: auto,
  ending-gap: auto,
  continuation-indent: auto,
  ending-indent: auto,
) = context {
  let current-position = here().position()
  let figure-elements = query(figure.where(kind: raw).before(here()))
  let current-figure = figure-elements.at(-1, default: none)

  if current-figure == none {
    return []
  }

  let first-page = current-position.page == current-figure.location().page()
  let number = current-listing-number()
  let figure-fields = current-figure.fields()
  let supplement = figure-fields.at("supplement", default: [Листинг])
  let separator = figure-fields.at("caption").fields().at(
    "separator",
    default: " – ",
  )
  let parameters = query(<modern-g7-32-parameters>).first(default: none)
  let configured = if parameters == none { (:) } else { parameters.value }
  let title = if first-page {
    (
      text: [#supplement #number#separator#caption],
      indent: configured.at(
        "listing-caption-indent",
        default: default-listing-caption-indent,
      ),
      gap: caption-gap,
      size: configured.at(
        "listing-caption-text-size",
        default: default-listing-caption-text-size,
      ),
      artifact-kind: "other",
    )
  } else {
    let marker = nearest-end-marker(current-position)
    let last-page = marker != none and marker.location().page() == current-position.page
    let continuation-text-size = configured.at(
      "listing-continuation-text-size",
      default: default-long-listing-continuation-text-size,
    )
    let document-indent = configured.at("indent", default: default-indent)
    let configured-continuation-indent = configured.at(
      "long-listing-continuation-indent",
      default: default-long-listing-continuation-indent,
    )
    let configured-ending-indent = configured.at(
      "long-listing-ending-indent",
      default: default-long-listing-ending-indent,
    )
    let configured-continuation-gap = configured.at(
      "long-listing-continuation-gap",
      default: default-long-listing-continuation-gap,
    )
    let configured-ending-gap = configured.at(
      "long-listing-ending-gap",
      default: default-long-listing-ending-gap,
    )
    let resolved-continuation-indent = if continuation-indent == auto {
      configured-continuation-indent
    } else {
      continuation-indent
    }
    let resolved-ending-indent = if ending-indent == auto {
      configured-ending-indent
    } else {
      ending-indent
    }
    let title-indent = if last-page {
      if resolved-ending-indent == auto {
        document-indent
      } else {
        resolved-ending-indent
      }
    } else {
      if resolved-continuation-indent == auto {
        document-indent
      } else {
        resolved-continuation-indent
      }
    }
    let title-gap = if last-page {
      if ending-gap == auto { configured-ending-gap } else { ending-gap }
    } else {
      if continuation-gap == auto {
        configured-continuation-gap
      } else {
        continuation-gap
      }
    }
    (
      text: if last-page {
        [Окончание листинга #number]
      } else {
        [Продолжение листинга #number]
      },
      indent: title-indent,
      gap: title-gap,
      size: continuation-text-size,
      artifact-kind: "pagination-other",
    )
  }

  set par(
    leading: default-table-and-raw-caption-leading,
    first-line-indent: 0pt,
  )
  set text(size: title.size)

  let gap-shift = default-long-listing-continuation-cell-inset.bottom - title.gap
  pdf.artifact(
    kind: title.artifact-kind,
    pad(left: title.indent, move(dy: gap-shift, title.text)),
  )
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
  caption-gap: default-listing-caption-gap,
  continuation-gap: auto,
  ending-gap: auto,
  continuation-indent: auto,
  ending-indent: auto,
  line-vertical-inset: auto,
  ..figure-args,
) = {
  assert(
    type(raw-content) == content and raw-content.func() == raw,
    message: "long-listing ожидает первым аргументом raw(...).",
  )
  assert(caption != none, message: "Для long-listing требуется caption: ...")

  let continuation-cell-inset = default-long-listing-continuation-cell-inset
  continuation-cell-inset.insert("left", 0pt)

  let raw-fields = raw-content.fields()
  let raw-block = raw-fields.at("block", default: false)
  assert(raw-block, message: "long-listing поддерживает только raw(..., block: true).")

  let raw-text = raw-fields.at("text", default: "")
  let raw-lang = raw-fields.at("lang", default: none)
  let raw-lines = trim-single-trailing-empty(raw-text.split("\n"))

  let line-cell-inset = if line-vertical-inset == auto {
    0pt
  } else {
    let inset = default-long-listing-line-cell-inset
    inset.insert("top", line-vertical-inset)
    inset.insert("bottom", line-vertical-inset)
    inset
  }
  let line-number-cell-inset = if line-vertical-inset == auto {
    0pt
  } else {
    let inset = default-long-listing-line-number-cell-inset
    inset.insert("top", line-vertical-inset)
    inset.insert("bottom", line-vertical-inset)
    inset
  }

  let continuation-row = table.cell(
    colspan: 1,
    stroke: none,
    inset: continuation-cell-inset,
  )[
    #page-title(
      caption,
      caption-gap,
      continuation-gap: continuation-gap,
      ending-gap: ending-gap,
      continuation-indent: continuation-indent,
      ending-indent: ending-indent,
    )
  ]

  let lines-table = table(
    columns: (auto, 1fr),
    stroke: none,
    ..raw-lines.enumerate().map(((index, line)) => {
      let line-content = if raw-lang == none {
        raw(line, block: false)
      } else {
        raw(line, lang: raw-lang, block: false)
      }
      let line-number = raw(str(index + 1), block: false)
      let first-line-marker = if index == 0 {
        hide(metadata(default-long-listing-first-line-cell-marker))
      } else {
        none
      }

      (
        table.cell(
          stroke: none,
          inset: line-number-cell-inset,
          align: right,
        )[
          #hide(metadata(default-long-listing-data-cell-marker))
          #first-line-marker
          #line-number
        ],
        table.cell(
          stroke: none,
          inset: line-cell-inset,
          align: left,
        )[
          #hide(metadata(default-long-listing-data-cell-marker))
          #first-line-marker
          #line-content
        ],
      )
    }).flatten(),
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

  // Keep the visible title with the repeated header while retaining one native
  // caption for PDF semantics. A bottom, zero-height caption also keeps the
  // figure destination on the first page that actually contains the listing.
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
    gap: 0pt,
    caption: figure.caption(
      position: bottom,
      [
        #hide(metadata(default-long-listing-semantic-caption-marker))
        #caption
      ],
    ),
    ..figure-args,
  )
}
