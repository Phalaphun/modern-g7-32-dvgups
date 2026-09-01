#import "/src/export.typ": gost, long-listing

#show: gost.with(hide-title: true)
#set page(height: 170mm)

Ссылки: @listing-one, @listing-two, @listing-three.

#let make-lines(count) = range(0, count).map(i => "line " + str(i + 1))

#let make-code(count, with-empty-lines: false, trailing-newline: false) = {
  let lines = make-lines(count)
  if with-empty-lines {
    let spaced-lines = ()
    for (i, line) in lines.enumerate() {
      if calc.rem(i + 1, 5) == 0 {
        spaced-lines.push(line + "\n")
      } else {
        spaced-lines.push(line)
      }
    }
    lines = spaced-lines
  }

  let text = lines.join("\n")
  if trailing-newline {
    return text + "\n"
  }
  text
}

#long-listing(
  raw(make-code(8, with-empty-lines: true), lang: "python", block: true),
  caption: [Короткий листинг на одной странице],
) <listing-one>

#pagebreak()

#long-listing(
  raw(make-code(55, trailing-newline: true), lang: "python", block: true),
  caption: [Листинг на две страницы],
) <listing-two>

#pagebreak()

#long-listing(
  raw(make-code(95, trailing-newline: true), lang: "python", block: true),
  caption: [Листинг на три и более страниц],
) <listing-three>
