#import "/src/export.typ": gost, long-table

#set document(title: "Проверка переноса подписи длинной таблицы")
#show: gost.with(
  hide-title: true,
  add-pagebreaks: false,
  margin: 10mm,
)
#set page(width: 100mm, height: 100mm)

Ссылка на таблицу @boundary-table.

#v(40mm, weak: false)

#long-table(
  table(
    columns: 2,
    table.header([Колонка 1], [Колонка 2]),
    [Строка 1], [Значение 1],
    [Строка 2], [Значение 2],
    [Строка 3], [Значение 3],
    [Строка 4], [Значение 4],
  ),
  caption: [Подпись переносится вместе с первой строкой],
) <boundary-table>

#context [Количество таблиц: #query(figure.where(kind: table)).len().]
