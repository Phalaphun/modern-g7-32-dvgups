#import "../utils.typ": heading-numbering
#import "../constants.typ": (
  default-appendix-heading-new-style,
  default-appendix-heading-label-title-gap-level-1,
  default-appendix-heading-label-title-gap-other-levels,
  default-appendix-title-padding-top-level-1,
  default-appendix-title-padding-bottom-level-1,
  default-appendix-title-padding-top-other-levels,
  default-appendix-title-padding-bottom-other-levels,
  default-headings-not-bold,
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

#let render-appendix-heading(
  it,
  headings-not-bold: default-headings-not-bold,
  appendix-heading-new-style: default-appendix-heading-new-style,
) = {
  let appendix-number = numbering(
    it.numbering,
    ..counter(heading).at(it.location()),
  )
  let appendix-label = [#upper([приложение]) #appendix-number]
  let appendix-title-weight = if headings-not-bold { "regular" } else { "medium" }
  let appendix-title = [#text(weight: appendix-title-weight)[#it.body]]
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

  if headings-not-bold {
    set text(weight: "regular")
  }

  if appendix-heading-new-style {
    block(width: 100%)[
      #stack(
        dir: ttb,
        spacing: label-title-gap,
        align(right)[#appendix-label],
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
  show heading: it => context {
    assert(
      it.numbering != none,
      message: "В приложениях не может быть структурных заголовков или заголовков без нумерации",
    )
    let parameters = query(<modern-g7-32-parameters>).first(default: none)
    let headings-not-bold = if parameters == none {
      default-headings-not-bold
    } else {
      parameters.value.at("headings-not-bold", default: default-headings-not-bold)
    }
    let appendix-heading-new-style = if parameters == none {
      default-appendix-heading-new-style
    } else {
      parameters.value.at(
        "appendix-heading-new-style",
        default: default-appendix-heading-new-style,
      )
    }

    counter("appendix").step()
    render-appendix-heading(
      it,
      headings-not-bold: headings-not-bold,
      appendix-heading-new-style: appendix-heading-new-style,
    )
  }

  show heading.where(level: 1): it => context {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)

    let parameters = query(<modern-g7-32-parameters>).first(default: none)
    let add-pagebreaks = if parameters == none {
      true
    } else {
      parameters.value.at("add-pagebreaks", default: true)
    }

    if add-pagebreaks {
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
