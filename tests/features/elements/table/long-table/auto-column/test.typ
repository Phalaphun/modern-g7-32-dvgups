#import "/src/export.typ": gost, long-table

#set document(title: "Проверка колонки auto в длинной таблице")
#show: gost.with(
  hide-title: true,
  add-pagebreaks: false,
  margin: 10mm,
)
#set page(width: 140mm, height: 100mm)

#let rows = range(24).map(i => {
  let number = if i < 8 {
    i + 1
  } else if i < 16 {
    i + 2
  } else {
    i + 85
  }
  (
    table.cell(align: right)[#number],
    [Значение строки #number],
  )
}).flatten()

#long-table(
  table(
    columns: (auto, 1fr),
    table.header([Номер], [Значение]),
    ..rows,
  ),
  caption: [Колонка auto с одно-, двух- и трёхзначными значениями],
)
