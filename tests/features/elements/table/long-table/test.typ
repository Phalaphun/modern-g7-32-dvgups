#import "/src/export.typ": gost, long-table

#show: gost.with(hide-title: true)
#set page(height: 170mm)

#let rows(count) = (
  for i in range(0, count) {
    ([Строка #(i + 1)], [Значение #(i + 1)],)
  }
).flatten()

#let sample-table(count) = table(
  columns: 2,
  table.header([Колонка 1], [Колонка 2]),
  ..rows(count),
)

#long-table(
  sample-table(10),
  caption: [Короткая таблица на одной странице],
)

#pagebreak()

#long-table(
  sample-table(25),
  caption: [Таблица на две страницы],
)

#pagebreak()

#long-table(
  sample-table(90),
  caption: [Таблица на три и более страниц],
)
