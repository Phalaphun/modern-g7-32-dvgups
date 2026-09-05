# modern-g7-32

Шаблон для оформления документов в соответствии с ГОСТ 7.32-2017. Он был создан для автоматизации рутинных процессов при работе с научными работами. Шаблон может быть полезен студентам вузов при оформлении лабораторных, курсовых и дипломных работ.

<a href="https://typst.app/universe/package/modern-g7-32">![Typst Universe](https://img.shields.io/badge/dynamic/xml?url=https://typst.app/universe/package/modern-g7-32&query=/html/body/div/main/div[2]/aside/section[2]/dl/dd[3]&logo=typst&label=universe)</a>
<a href="https://github.com/typst-g7-32/modern-g7-32/blob/main/LICENSE"><img src="https://img.shields.io/github/license/typst-g7-32/modern-g7-32" alt="License badge"></a>
<a href="https://github.com/typst-g7-32/modern-g7-32/actions"><img src="https://github.com/typst-g7-32/modern-g7-32/actions/workflows/tests.yml/badge.svg" alt="Tests badge"></a>
<a href="https://typst-gost.ru"><img src="https://img.shields.io/website?url=https%3A%2F%2Ftypst-gost.ru" alt="Website badge"></a>

## Быстрый старт

Чтобы использовать этот шаблон, импортируйте его как показано ниже:
```typst
#import "@preview/modern-g7-32:0.2.0": gost, abstract, appendixes

#show: gost.with(
  ministry: "Наименование министерства (ведомства) или другого структурного образования, в систему которого входит организация-исполнитель",
  organization: (
    full: "Полное наименование организации — исполнителя НИР",
    short: "Сокращённое наименование организации"
  ),
  about: "О научно-исследовательской работе",
  research: "Наименование НИР",
  subject: "Наименование отчёта",
  manager: (name: "Фамилия И.О.", position: "Должность", title: "Руководитель НИР,"),
  federal: "Наименование федеральной программы",
  city: "Город",
  performers: (
    (name: "И.О. Фамилия", position: "Должность", part: "введение, раздел 1"),
    "Организация",
    (name: "И.О. Фамилия", position: "Должность"),
  ) 
)

#abstract(
  "ключевое слово",
  "шаблон",
)[
  Текст реферата
]

#outline()

= Введение
Текст введения

= Раздел 1
== Подраздел 1
=== Пункт 1
Ссылка в тексте на изображение @image.

#figure(image("assets/image.png"), caption: "Пример изображения") <image>

= Заключение

#bibliography("references.bib")

#show: appendixes

= Приложение
= Другое приложение
```

## Документация

Больше информации о проекте находится на сайте [typst-gost.ru](https://typst-gost.ru)

- Справка по использованию шаблона доступна на [странице документации](https://typst-gost.ru/docs)
- Изучить демонстрационные документы можно на [странице примеров](https://typst-gost.ru/examples)

## Параметры оформления таблиц и листингов

Значения по умолчанию хранятся во внутренних константах `src/constants.typ`. Пользователю не требуется импортировать эти константы напрямую: глобальные настройки передаются в `gost.with`, а настройки отдельной длинной таблицы или листинга — в `long-table` и `long-listing`.

В колонке «Публичный параметр» прочерк означает, что значение пока можно изменить только в исходном коде пакета. Внутренние константы не являются стабильным публичным API и могут быть переименованы между версиями.

### Документ и основной текст

| Внутренняя константа | Значение по умолчанию | Публичный параметр | Назначение |
|---|---:|---|---|
| `default-text-size` | `(default: 14pt, small: 10pt)` | `text-size` | Основной и уменьшенный размеры текста. Если передан только основной размер, уменьшенный вычисляется с сохранением исходной разницы в 4 пт. |
| `default-indent` | `0.75cm` | `indent` | Абзацный отступ документа; также используется как базовый отступ заголовков, списков и оглавления. |
| `default-margin` | `(left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)` | `margin` | Поля страницы. |
| `default-justify` | `true` | — | Включает выравнивание основного текста по ширине. |
| `default-leading` | `1.5em - 0.75em` | — | Дополнительное расстояние между строками абзаца, используемое Typst при расчёте межстрочного интервала. |
| `default-spacing` | `1em` | — | Расстояние между соседними обычными абзацами. |
| `default-figure-margin-bottom` | `0.5em` | — | Зарезервированное значение нижнего отступа фигуры; в текущей реализации не применяется. |
| `default-list-spacing` | `1em` | — | Вертикальный интервал между пунктами маркированного списка. |
| `default-enum-spacing` | `1em` | — | Вертикальный интервал между пунктами нумерованного списка. |
| `default-outline-depth` | `3` | — | Максимальная глубина заголовков, включаемых в содержание по умолчанию. |

### Заголовки и структурные разделы

| Внутренняя константа | Значение по умолчанию | Публичный параметр | Назначение |
|---|---:|---|---|
| `default-heading-margin` | `(below: 3em, above: 3em)` | — | Отступы до и после заголовков уровней 2 и ниже. |
| `default-heading-level-1-margin` | `(below: 3em, above: 0cm)` | — | Отступы до и после заголовка первого уровня. |
| `default-headings-not-bold` | `true` | `headings-not-bold` | При `true` заголовки выводятся обычным, а не полужирным начертанием. |
| `default-system-headings-normal-case-left-align` | `true` | `system-headings-normal-case-left-align` | Включает обычный регистр и выравнивание от абзацного отступа для общих служебных заголовков, кроме заголовков с отдельными настройками ниже. |
| `default-contents-heading-normal-case-left-align` | `false` | `contents-heading-normal-case-left-align` | При `true` заголовок содержания выводится слева от `indent`; при `false` — по центру. |
| `default-contents-heading-uppercase` | `false` | `contents-heading-uppercase` | Переводит заголовок содержания в верхний регистр, если для него не включено левое выравнивание. |
| `default-contents-heading-margin-bottom` | `default-leading` | `contents-heading-margin-bottom` | Расстояние после заголовка содержания до первой строки оглавления. |
| `default-introduction-heading-normal-case-left-align` | `false` | `introduction-heading-normal-case-left-align` | При `true` заголовок введения выводится слева от `indent`; при `false` — по центру. |
| `default-introduction-heading-uppercase` | `false` | `introduction-heading-uppercase` | Управляет верхним регистром заголовка введения. |
| `default-conclusion-heading-normal-case-left-align` | `false` | `conclusion-heading-normal-case-left-align` | При `true` заголовок заключения выводится слева от `indent`; при `false` — по центру. |
| `default-conclusion-heading-uppercase` | `false` | `conclusion-heading-uppercase` | Управляет верхним регистром заголовка заключения. |
| `default-references-heading-normal-case-left-align` | `false` | `references-heading-normal-case-left-align` | При `true` заголовок списка источников выводится слева от `indent`; при `false` — по центру. |
| `default-references-heading-uppercase` | `false` | `references-heading-uppercase` | Управляет верхним регистром заголовка списка использованных источников. |

Если параметр `*-normal-case-left-align` равен `true`, соответствующий заголовок всегда выводится в обычном регистре слева. Поэтому параметр `*-uppercase` влияет только на центрированный вариант заголовка.

### Приложения

| Внутренняя константа | Значение по умолчанию | Публичный параметр | Назначение |
|---|---:|---|---|
| `default-appendix-heading-new-style` | `true` | `appendix-heading-new-style` | При `true` обозначение «Приложение А» располагается справа, а название приложения — по центру; при `false` обе строки центрируются. |
| `default-appendix-heading-uppercase` | `false` | `appendix-heading-uppercase` | Переключает слово «Приложение» между написанием с прописной буквы и верхним регистром. |
| `default-appendix-heading-label-title-gap-level-1` | `24pt` | — | Расстояние между обозначением и названием приложения первого уровня. |
| `default-appendix-heading-label-title-gap-other-levels` | `18pt` | — | То же расстояние для вложенных заголовков приложения. |
| `default-appendix-title-padding-top-level-1` | `0pt` | — | Дополнительный верхний внутренний отступ названия приложения первого уровня. |
| `default-appendix-title-padding-bottom-level-1` | `-12pt` | — | Компенсационный нижний отступ названия приложения первого уровня. |
| `default-appendix-title-padding-top-other-levels` | `0pt` | — | Дополнительный верхний внутренний отступ названий остальных уровней приложения. |
| `default-appendix-title-padding-bottom-other-levels` | `-12pt` | — | Компенсационный нижний отступ названий остальных уровней приложения. |
| `default-appendix-heading-following-par-top-level-1` | `0pt` | — | Дополнительный интервал перед первым абзацем после заголовка приложения первого уровня. |
| `default-appendix-heading-following-par-top-other-levels` | `0pt` | — | Дополнительный интервал перед первым абзацем после вложенного заголовка приложения. |

### Рисунки

| Внутренняя константа | Значение по умолчанию | Публичный параметр | Назначение |
|---|---:|---|---|
| `default-image-figure-margin` | `(above: 32pt, below: 32pt)` | — | Внешние отступы блока рисунка сверху и снизу. |
| `default-image-figure-gap` | `12pt` | — | Расстояние между изображением и его подписью. |
| `default-image-par-style` | `(leading: 0.2em, first-line-indent: 0pt)` | — | Параметры абзаца внутри блока рисунка. |
| `default-image-caption-margin` | `(above: 12pt, below: 0pt)` | — | Дополнительные внешние отступы подписи рисунка. |
| `default-image-caption-text-size` | `12pt` | — | Размер текста подписи рисунка. |
| `default-image-caption-par-style` | `(leading: 0.5em, first-line-indent: 0pt)` | — | Межстрочный интервал и абзацный отступ подписи рисунка. |

### Общие константы таблиц и листингов

| Внутренняя константа | Значение по умолчанию | Назначение |
|---|---:|---|
| `default-table-and-raw-figure-margin-above` | `24pt` | Внешний отступ перед таблицами и листингами. |
| `default-table-and-raw-figure-below-lines` | `2` | Число строк основного шрифта, резервируемых после таблицы или листинга. |
| `default-table-and-raw-caption-margin` | `(above: 0pt, below: 16pt)` | Служебный запас вокруг повторяемых названий; его нижнее значение участвует в расчёте зазоров продолжения и окончания. |
| `default-table-and-raw-caption-leading` | `0.5em` | Межстрочное расстояние в многострочных названиях таблиц и листингов. |
| `default-table-and-raw-caption-first-line-indent` | `(amount: default-indent, all: true)` | Зарезервированный стиль красной строки подписи; в текущей реализации напрямую не применяется. |

### Таблицы

| Параметр `gost.with` | Внутренняя константа | Значение по умолчанию | Назначение |
|---|---|---:|---|
| `table-caption-gap` | `default-table-caption-gap` | `6pt + 1mm` | Расстояние между обычным названием таблицы и самой таблицей. Для отдельной длинной таблицы этому параметру соответствует аргумент `caption-gap`. |
| `table-cell-vertical-inset` | `default-table-cell-vertical-inset` | `6pt` | Верхнее и нижнее внутренние поля ячеек. При тексте размером 12 пт однострочная ячейка имеет высоту около 7 мм. |
| `long-table-continuation-gap` | `default-long-table-continuation-gap` | `16pt - 2mm` | Расстояние после строки «Продолжение таблицы» до повторяемой шапки. |
| `long-table-ending-gap` | `default-long-table-ending-gap` | `16pt - 2mm` | Расстояние после строки «Окончание таблицы» до повторяемой шапки. |
| `long-table-continuation-indent` | `default-long-table-continuation-indent` | `0pt` | Горизонтальный отступ строки «Продолжение таблицы». Нулевое значение выравнивает её по левой границе таблицы. |
| `long-table-ending-indent` | `default-long-table-ending-indent` | `0pt` | Горизонтальный отступ строки «Окончание таблицы». Нулевое значение выравнивает её по левой границе таблицы. |

Текст таблицы, её название и строки продолжения/окончания по умолчанию имеют размер `12pt`. Эти значения задаются внутренними константами `default-table-text-size`, `default-table-caption-text-size` и `default-long-table-continuation-text-size`.

Остальные внутренние константы таблиц:

| Внутренняя константа | Значение по умолчанию | Назначение |
|---|---:|---|
| `default-table-text-size` | `12pt` | Размер текста в ячейках обычных и длинных таблиц. |
| `default-table-caption-text-size` | `12pt` | Размер текста названия таблицы. |
| `default-table-caption-margin` | `(above: 0pt, below: 0pt)` | Дополнительные внешние отступы блока названия таблицы. |
| `default-table-cell-width` | `100%` | Ширина внутреннего блока содержимого ячейки. |
| `default-long-table-continuation-text-size` | `12pt` | Размер текста строк продолжения и окончания длинной таблицы. |
| `default-long-table-continuation-cell-inset` | `(left: default-indent, right: 0pt, top: 0pt, bottom: 16pt)` | Служебные внутренние поля повторяемой строки длинной таблицы. Фактический левый отступ заменяется параметром продолжения или окончания. |
| `default-long-table-end-marker-value` | `"modern-g7-32-long-table-end-marker"` | Служебное значение метаданных, по которому определяется последняя страница длинной таблицы. |
| `default-long-table-end-marker-cell-inset` | `(x: 0pt, y: 0pt)` | Внутренние поля невидимой ячейки-маркера конца длинной таблицы. |

### Листинги

| Параметр `gost.with` | Внутренняя константа | Значение по умолчанию | Назначение |
|---|---|---:|---|
| `listing-caption-gap` | `default-listing-caption-gap` | `6pt + 1mm` | Расстояние между обычным названием листинга и его рамкой. Для отдельного длинного листинга этому параметру соответствует аргумент `caption-gap`. |
| `listing-caption-indent` | `default-listing-caption-indent` | `0pt` | Горизонтальный отступ обычного названия листинга. Нулевое значение выравнивает название по левой границе рамки. |
| `listing-text-size` | `default-listing-text-size` | `12pt` | Размер текста внутри листинга. |
| `listing-caption-text-size` | `default-listing-caption-text-size` | `12pt` | Размер текста обычного названия листинга. |
| `listing-continuation-text-size` | `default-listing-continuation-text-size` | `12pt` | Размер текста строк «Продолжение листинга» и «Окончание листинга». |
| `long-listing-continuation-gap` | `default-long-listing-continuation-gap` | `16pt - 2mm` | Расстояние после строки «Продолжение листинга» до рамки. |
| `long-listing-ending-gap` | `default-long-listing-ending-gap` | `16pt - 2mm` | Расстояние после строки «Окончание листинга» до рамки. |
| `long-listing-continuation-indent` | `default-long-listing-continuation-indent` | `0pt` | Горизонтальный отступ строки «Продолжение листинга». Нулевое значение выравнивает её по левой границе рамки. |
| `long-listing-ending-indent` | `default-long-listing-ending-indent` | `0pt` | Горизонтальный отступ строки «Окончание листинга». Нулевое значение выравнивает её по левой границе рамки. |

Остальные внутренние константы листингов:

| Внутренняя константа | Значение по умолчанию | Назначение |
|---|---:|---|
| `default-listing-caption-margin` | `(above: 0pt, below: 0pt)` | Дополнительные внешние отступы блока названия листинга. |
| `default-listing-line-vertical-inset` | `6.5pt` | Базовые верхнее и нижнее внутренние поля строки длинного листинга. |
| `default-listing-raw-block-style` | `(width: 100%, inset: 6pt, stroke: 0.5pt + black)` | Ширина, внутреннее поле и рамка блока кода. |
| `default-long-listing-line-cell-inset` | `(x: 0pt, y: 6.5pt)` | Внутренние поля ячейки с кодом одной строки длинного листинга. |
| `default-long-listing-line-number-cell-inset` | `(left: 0pt, right: 8pt, top: 6.5pt, bottom: 6.5pt)` | Внутренние поля ячейки с номером строки. |
| `default-long-listing-continuation-text-size` | `default-listing-continuation-text-size` | Внутренний псевдоним размера текста продолжения и окончания. |
| `default-long-listing-continuation-cell-inset` | `(left: default-indent, right: 0pt, top: 0pt, bottom: 16pt)` | Служебные внутренние поля повторяемой строки длинного листинга. Фактический левый отступ заменяется параметром продолжения или окончания. |
| `default-long-listing-frame-cell-inset` | `(x: 0pt, y: 0pt)` | Внутренние поля ячейки, содержащей рамку листинга. |
| `default-long-listing-end-marker-value` | `"modern-g7-32-long-listing-end-marker"` | Служебное значение метаданных, по которому определяется последняя страница длинного листинга. |
| `default-long-listing-end-marker-cell-inset` | `(x: 0pt, y: 0pt)` | Внутренние поля невидимой ячейки-маркера конца длинного листинга. |

### Настройка отдельной длинной таблицы

Аргументы `long-table` переопределяют глобальные значения только для конкретной таблицы:

```typst
#long-table(
  table(...),
  caption: [Название таблицы],
  caption-gap: 6pt + 1mm,
  continuation-gap: 16pt - 2mm,
  ending-gap: 16pt - 2mm,
  continuation-indent: 0pt,
  ending-indent: 0pt,
)
```

| Аргумент `long-table` | Назначение |
|---|---|
| `caption-gap` | Расстояние после обычного названия таблицы. |
| `continuation-gap` | Расстояние после строки «Продолжение таблицы». Значение `auto` использует `long-table-continuation-gap` из `gost.with`. |
| `ending-gap` | Расстояние после строки «Окончание таблицы». Значение `auto` использует `long-table-ending-gap` из `gost.with`. |
| `continuation-indent` | Отступ строки «Продолжение таблицы». Значение `auto` использует `long-table-continuation-indent` из `gost.with`. |
| `ending-indent` | Отступ строки «Окончание таблицы». Значение `auto` использует `long-table-ending-indent` из `gost.with`. |

### Настройка отдельного длинного листинга

Аргументы `long-listing` переопределяют глобальные значения только для конкретного листинга:

```typst
#long-listing(
  raw("код", lang: "text", block: true),
  caption: [Название листинга],
  caption-gap: 6pt + 1mm,
  continuation-gap: 16pt - 2mm,
  ending-gap: 16pt - 2mm,
  continuation-indent: 0pt,
  ending-indent: 0pt,
  line-vertical-inset: 6.5pt,
)
```

| Аргумент `long-listing` | Назначение |
|---|---|
| `caption-gap` | Расстояние после обычного названия листинга. |
| `continuation-gap` | Расстояние после строки «Продолжение листинга». Значение `auto` использует `long-listing-continuation-gap` из `gost.with`. |
| `ending-gap` | Расстояние после строки «Окончание листинга». Значение `auto` использует `long-listing-ending-gap` из `gost.with`. |
| `continuation-indent` | Отступ строки «Продолжение листинга». Значение `auto` использует `long-listing-continuation-indent` из `gost.with`. |
| `ending-indent` | Отступ строки «Окончание листинга». Значение `auto` использует `long-listing-ending-indent` из `gost.with`. |
| `line-vertical-inset` | Верхнее и нижнее внутренние поля строк. Дефолт `6.5pt` обеспечивает высоту однострочной строки не менее 7 мм. |

### Пример глобальной настройки

```typst
#show: gost.with(
  table-caption-gap: 6pt + 1mm,
  table-cell-vertical-inset: 6pt,
  long-table-continuation-gap: 16pt - 2mm,
  long-table-ending-gap: 16pt - 2mm,
  long-table-continuation-indent: 0pt,
  long-table-ending-indent: 0pt,

  listing-caption-gap: 6pt + 1mm,
  listing-caption-indent: 0pt,
  listing-text-size: 12pt,
  listing-caption-text-size: 12pt,
  listing-continuation-text-size: 12pt,
  long-listing-continuation-gap: 16pt - 2mm,
  long-listing-ending-gap: 16pt - 2mm,
  long-listing-continuation-indent: 0pt,
  long-listing-ending-indent: 0pt,
)
```

## Возможности

* Формирование титульного листа
* Встроенные шаблоны титульных листов
* Пользовательские шаблоны титульных листов
* Автоматическое создание списка исполнителей
* Оформление структурных заголовков
* Автоматическая генерация реферата
* Автоматизированная сборка содержания
* Форматирование и нумерация элементов отчёта
* Оформление списка использованных источников
* Автоматическое оформление и нумерация приложений

## Список изменений

### [0.2.0](https://github.com/typst-g7-32/modern-g7-32/releases/tag/0.2.0)

- **Критические изменения**
    - ⚠️ Для приложений теперь применяется название `appendix` вместо `annex`
    - ⚠️ Зависимость `numberingx` заменена на собственное решение (используйте `enum-numbering` из шаблона)

- **Добавлено**
    - Опция отключения отображения количества элементов в реферате
    - Настройки для пользовательского выравнивания нумерации страниц и полей страницы
    - Параметр `title` для исполнителя и руководителя НИР
    - Параметр `add-pagebreaks`, позволяющий отключать автоматическое разбиение страниц
    - Параметр `title-footer-align`, позволяющий устанавливать выравнивание футера (город и год) на титульном листе
    - Межстрочный интервал в 1.5 строки для соответствия ГОСТ

- **Изменено**
    - Шаблон мигрирован до версии Typst 0.14.0

- **Исправлено**
    - Нумерация фигур (изображений, таблиц и т.д) в приложениях
    - Работа с параметрами исполнителей
    - Подключение шаблонов титульного листа для локального импорта пакета

### [0.1.0](https://github.com/typst-g7-32/modern-g7-32/releases/tag/0.1.0)

- Начальный релиз
