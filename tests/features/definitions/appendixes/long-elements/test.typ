#import "/src/export.typ": appendixes, gost, long-listing, long-table

#show: gost.with(hide-title: true)
#set page(height: 170mm)

#let sample-table(count) = table(
  columns: 2,
  table.header([Номер], [Значение]),
  ..range(count).map(i => ([#(i + 1)], [Строка #(i + 1)])).flatten(),
)
#let sample-code(count) = raw(
  range(count).map(i => "line " + str(i + 1)).join("\n"),
  block: true,
)

= Основная часть

Ссылки: @main-table, @main-listing, @appendix-table, @appendix-listing,
@next-table, @next-listing.

#long-table(sample-table(2), caption: [Основная таблица]) <main-table>
#long-listing(sample-code(3), caption: [Основной листинг]) <main-listing>

#show: appendixes

= Многостраничные элементы

#long-table(sample-table(60), caption: [Таблица приложения]) <appendix-table>

// A second footer of the same kind must not change the preceding ending title.
#long-table(sample-table(2), caption: [Следующая короткая таблица])

== Листинги

#long-listing(sample-code(95), caption: [Листинг приложения]) <appendix-listing>
#long-listing(sample-code(3), caption: [Следующий короткий листинг])

= Следующее приложение

#long-table(sample-table(2), caption: [Таблица следующего приложения]) <next-table>
#long-listing(sample-code(3), caption: [Листинг следующего приложения]) <next-listing>

Ссылки: @main-table, @main-listing, @appendix-table, @appendix-listing,
@next-table, @next-listing.

// Counters reset between appendices while main-body reference numbers survive.
#context {
  for (target, chapter, in-appendix) in (
    (<main-table>, 1, false),
    (<main-listing>, 1, false),
    (<appendix-table>, 1, true),
    (<appendix-listing>, 1, true),
    (<next-table>, 2, true),
    (<next-listing>, 2, true),
  ) {
    let it = query(target).first()
    let loc = it.location()
    assert.eq(it.counter.at(loc), (1,))
    assert.eq(counter(heading).at(loc).first(), chapter)
    assert.eq(state("appendixes", false).at(loc), in-appendix)
  }
}
