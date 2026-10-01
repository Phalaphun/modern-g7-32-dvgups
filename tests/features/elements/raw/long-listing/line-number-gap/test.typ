#import "/src/export.typ": gost, long-listing

#set document(title: "Проверка зазора после номера строки длинного листинга")
#show: gost.with(
  hide-title: true,
  add-pagebreaks: false,
  long-listing-line-number-gap: 4mm,
)

#let make-code(count) = range(count).map(_ => "print(\"line\")").join("\n")

#long-listing(
  raw(make-code(9), lang: "python", block: true),
  caption: [Однозначные номера строк],
)

#pagebreak()

#long-listing(
  raw(make-code(105), lang: "python", block: true),
  caption: [Одно-, двух- и трёхзначные номера строк],
)
