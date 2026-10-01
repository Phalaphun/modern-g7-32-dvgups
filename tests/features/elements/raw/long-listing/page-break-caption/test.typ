#import "/src/export.typ": gost, long-listing

#set document(title: "Проверка переноса подписи длинного листинга")
#show: gost.with(
  hide-title: true,
  add-pagebreaks: false,
  margin: 10mm,
)
#set page(width: 100mm, height: 100mm)

Ссылка на листинг @boundary-listing.

#v(45mm, weak: false)

#long-listing(
  raw(
    "line 1\nline 2\nline 3\nline 4",
    lang: "text",
    block: true,
  ),
  caption: [Подпись переносится вместе с первой строкой],
) <boundary-listing>

#context [Количество листингов: #query(figure.where(kind: raw)).len().]
