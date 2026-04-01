#import "../utils.typ": heading-numbering
#import "../constants.typ": (
  default-appendix-heading-render,
  default-appendix-heading-label-title-gap-level-1,
  default-appendix-heading-label-title-gap-other-levels,
  default-appendix-title-padding-top-level-1,
  default-appendix-title-padding-bottom-level-1,
  default-appendix-title-padding-top-other-levels,
  default-appendix-title-padding-bottom-other-levels,
  default-appendix-heading-render-legacy,
  default-appendix-heading-render-top-right,
)

#let is-heading-in-appendix(heading) = state("appendixes", false).at(
  heading.location(),
)

#let get-element-numbering(current-heading-numbering, element-numbering) = {
  if (current-heading-numbering.first() <= 0 or element-numbering <= 0) {
    return
  }
  let current-numbering = heading-numbering(current-heading-numbering.first())
  (current-numbering, numbering("1.1", element-numbering)).join(".")
}

#let appendix-heading(status, level: 1, body) = {
  heading(level: level)[(#status)\ #body]
}

#let render-appendix-heading(it) = {
  let appendix-number = numbering(
    it.numbering,
    ..counter(heading).at(it.location()),
  )
  let appendix-label = [#upper([приложение]) #appendix-number]
  let appendix-title = [#text(weight: "medium")[#it.body]]
  let label-title-gap = if it.level == 1 {
    default-appendix-heading-label-title-gap-level-1
  } else {
    default-appendix-heading-label-title-gap-other-levels
  }
  let title-top-padding = if it.level == 1 {
    default-appendix-title-padding-top-level-1
  } else {
    default-appendix-title-padding-top-other-levels
  }
  let title-bottom-padding = if it.level == 1 {
    default-appendix-title-padding-bottom-level-1
  } else {
    default-appendix-title-padding-bottom-other-levels
  }
  let appendix-title-with-padding = pad(
    top: title-top-padding,
    bottom: title-bottom-padding,
    appendix-title,
  )

  if default-appendix-heading-render == default-appendix-heading-render-top-right {
    block(width: 100%)[
      #stack(
        dir: ttb,
        spacing: label-title-gap,
        align(right)[#appendix-label],
        align(center)[#appendix-title-with-padding],
      )
    ]
  } else if default-appendix-heading-render == default-appendix-heading-render-legacy {
    block(width: 100%)[
      #stack(
        dir: ttb,
        spacing: label-title-gap,
        align(center)[#appendix-label],
        align(center)[#appendix-title-with-padding],
      )
    ]
  } else {
    block(width: 100%)[
      #stack(
        dir: ttb,
        spacing: label-title-gap,
        align(center)[#appendix-label],
        align(center)[#appendix-title-with-padding],
      )
    ]
  }
}

#let appendixes(content) = {
  set heading(numbering: heading-numbering, hanging-indent: 0pt)
  show heading: it => {
    assert(
      it.numbering != none,
      message: "В приложениях не может быть структурных заголовков или заголовков без нумерации",
    )
    counter("appendix").step()
    render-appendix-heading(it)
  }

  show heading.where(level: 1): it => context {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)

    if query(<modern-g7-32-parameters>).first().value.add-pagebreaks {
      pagebreak(weak: true)
    }
    it
  }

  set figure(numbering: it => {
    let current-heading = counter(heading).get()
    get-element-numbering(current-heading, it)
  })

  set math.equation(numbering: it => {
    let current-heading = counter(heading).get()
    [(#get-element-numbering(current-heading, it))]
  })

  state("appendixes").update(true)
  counter(heading).update(0)
  content
}
