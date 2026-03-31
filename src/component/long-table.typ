#import "../constants.typ": (
  default-long-table-continuation-text-size,
  default-long-table-continuation-cell-inset,
  default-long-table-end-marker-cell-inset,
  default-long-table-end-marker-value,
  default-long-table-figure-gap,
  default-table-and-raw-caption-leading,
)

#let marker-after-current-page(marker-position, current-position) = {
  marker-position.page > current-position.page or (
    marker-position.page == current-position.page
      and marker-position.y >= current-position.y
  )
}

#let nearest-end-marker(current-position) = {
  let markers = query(metadata.where(value: default-long-table-end-marker-value))
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

#let current-table-number() = {
  let figure-elements = query(figure.where(kind: table).before(here()))
  let current-figure = figure-elements.at(-1, default: none)

  if current-figure == none {
    return counter(figure.where(kind: table)).display()
  }

  let figure-fields = current-figure.fields()
  let figure-counter = figure-fields.at(
    "counter",
    default: counter(figure.where(kind: table)),
  )
  let figure-numbering = figure-fields.at("numbering", default: "1")

  figure-counter.display(figure-numbering)
}

#let continuation-title() = context {
  let current-position = here().position()
  let figure-elements = query(figure.where(kind: table).before(here()))
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
  let number = current-table-number()
  let continuation-text = if last-page {
    [Окончание таблицы #number.]
  } else {
    [Продолжение таблицы #number]
  }

  set par(
    leading: default-table-and-raw-caption-leading,
    first-line-indent: 0pt,
  )
  set text(size: default-long-table-continuation-text-size)

  continuation-text
}

#let long-table(
  table-content,
  caption: none,
  ..figure-args,
) = {
  assert(
    type(table-content) == content and table-content.func() == table,
    message: "long-table ожидает первым аргументом table(...).",
  )
  assert(caption != none, message: "Для long-table требуется caption: ...")

  let table-fields = table-content.fields()
  let original-children = table-fields.at("children", default: ())
  let has-footer = original-children.any(child => child.func() == table.footer)
  assert(
    not has-footer,
    message: "long-table не поддерживает table.footer(...): удалите footer у исходной таблицы.",
  )

  let table-options = table-fields.pairs()
    .filter(((name, _)) => name != "children")
    .to-dict()

  let columns = table-options.at("columns", default: ())
  let column-count = if type(columns) == int {
    columns
  } else if type(columns) == array {
    columns.len()
  } else {
    0
  }
  assert(
    column-count > 0,
    message: "long-table не смог определить число колонок таблицы.",
  )

  let header-cells = original-children
    .filter(child => child.func() == table.header)
    .map(header => header.fields().at("children", default: ()))
    .flatten()

  let body-children = original-children
    .filter(child => child.func() != table.header)

  let continuation-row = table.cell(
    colspan: column-count,
    stroke: none,
    inset: default-long-table-continuation-cell-inset,
  )[
    #continuation-title()
  ]

  let combined-header = table.header(
    repeat: true,
    continuation-row,
    ..header-cells,
  )

  let end-marker-footer = table.footer(
    repeat: false,
    table.cell(
      colspan: column-count,
      stroke: none,
      inset: default-long-table-end-marker-cell-inset,
    )[
      #hide(metadata(default-long-table-end-marker-value))
    ],
  )

  {
    set figure(gap: default-long-table-figure-gap)
    figure(
      table(
        ..table-options,
        combined-header,
        ..body-children,
        end-marker-footer,
      ),
      caption: caption,
      ..figure-args,
    )
  }
}
