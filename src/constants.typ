#let default-text-size = (default: 14pt, small: 10pt)
#let default-indent = 0.75cm
#let default-margin = (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm)
#let default-justify = true
#let default-leading = 1.5em - 0.75em
#let default-body-leading = 1.5em - 0.75em + 1mm
#let default-contents-leading = 1.5em - 0.75em + 1mm
#let default-contents-entry-spacing = 1.5em - 0.75em + 2mm
#let default-spacing = 1em
#let default-figure-margin-bottom = 0.5em
#let default-list-spacing = 1em
#let default-enum-spacing = 1em
#let default-outline-depth = 3
#let default-heading-margin = (below: 3em-2mm, above: 3em-2mm)
#let default-heading-level-1-margin = (below: 3em, above: 0cm)
#let default-heading-level-2-after-level-1-above = 3em
#let default-heading-level-1-following-par-top = 14pt + 3mm
#let default-headings-not-bold = true
#let default-system-headings-normal-case-left-align = true
#let default-contents-heading-normal-case-left-align = false
#let default-contents-heading-uppercase = false
#let default-contents-heading-margin-bottom = default-leading
#let default-introduction-heading-normal-case-left-align = false
#let default-introduction-heading-uppercase = false
#let default-conclusion-heading-normal-case-left-align = false
#let default-conclusion-heading-uppercase = false
#let default-references-heading-normal-case-left-align = false
#let default-references-heading-uppercase = false
#let default-appendix-heading-new-style = true
#let default-appendix-heading-uppercase = false
#let default-appendix-heading-label-title-gap-level-1 = 24pt
#let default-appendix-heading-label-title-gap-other-levels = 18pt
#let default-appendix-title-padding-top-level-1 = 0pt
#let default-appendix-title-padding-bottom-level-1 = -12pt
#let default-appendix-title-padding-top-other-levels = 0pt
#let default-appendix-title-padding-bottom-other-levels = -12pt
#let default-appendix-heading-following-par-top-level-1 = 0pt
#let default-appendix-heading-following-par-top-other-levels = 0pt

#let default-image-figure-margin = (above: 32pt, below: 32pt)
#let default-image-figure-gap = 12pt
#let default-image-par-style = (leading: 0.2em, first-line-indent: 0pt)
#let default-image-caption-margin = (above: 12pt, below: 0pt)
#let default-image-caption-text-size = 12pt
#let default-image-caption-par-style = (leading: 0.5em, first-line-indent: 0pt)

#let default-table-and-raw-figure-margin-above = 24pt
#let default-table-and-raw-figure-below-lines = 2
#let default-table-after-text-gap = 24pt + 2mm
#let default-table-after-table-gap = 24pt - 2mm
#let default-table-before-text-gap = 28pt + 1mm
#let default-table-before-heading-level-2-gap = 28pt - 4mm
#let default-table-and-raw-caption-margin = (above: 0pt, below: 16pt)
#let default-table-text-size = 12pt
#let default-table-caption-text-size = 12pt
#let default-table-caption-gap = 6pt + 1mm
#let default-table-caption-margin = (above: 0pt, below: 0pt)
#let default-table-cell-vertical-inset = 6pt
#let default-listing-caption-gap = 6pt + 1mm
#let default-listing-caption-indent = 0pt
#let default-listing-caption-margin = (above: 0pt, below: 0pt)
#let default-listing-text-size = 12pt
#let default-listing-caption-text-size = 12pt
#let default-listing-line-vertical-inset = 6.5pt
#let default-listing-continuation-text-size = 12pt
#let default-table-and-raw-caption-leading = 0.5em
#let default-table-and-raw-caption-first-line-indent = (
  amount: default-indent,
  all: true,
)

#let default-table-cell-width = 100%
#let default-listing-raw-block-style = (
  width: 100%,
  inset: 6pt,
  stroke: 0.5pt + black,
)
#let default-long-listing-line-cell-inset = (x: 0pt, y: default-listing-line-vertical-inset)
#let default-long-listing-end-marker-value = "modern-g7-32-long-listing-end-marker"
#let default-long-listing-continuation-cell-inset = (
  left: default-indent,
  right: 0pt,
  top: 0pt,
  bottom: default-table-and-raw-caption-margin.below,
)
#let default-long-listing-continuation-gap = (
  default-table-and-raw-caption-margin.below - 2mm
)
#let default-long-listing-ending-gap = (
  default-table-and-raw-caption-margin.below - 2mm
)
#let default-long-listing-continuation-indent = 0pt
#let default-long-listing-ending-indent = 0pt
#let default-long-listing-end-marker-cell-inset = (x: 0pt, y: 0pt)
#let default-long-listing-frame-cell-inset = (x: 0pt, y: 0pt)
#let default-long-listing-continuation-text-size = default-listing-continuation-text-size
#let default-long-listing-line-number-cell-inset = (
  left: 0pt,
  right: 8pt,
  top: default-listing-line-vertical-inset,
  bottom: default-listing-line-vertical-inset,
)

#let default-long-table-end-marker-value = "modern-g7-32-long-table-end-marker"
#let default-long-table-continuation-cell-inset = (
  left: default-indent,
  right: 0pt,
  top: 0pt,
  bottom: default-table-and-raw-caption-margin.below,
)
#let default-long-table-continuation-gap = (
  default-table-and-raw-caption-margin.below - 2mm
)
#let default-long-table-ending-gap = (
  default-table-and-raw-caption-margin.below - 2mm
)
#let default-long-table-continuation-indent = 0pt
#let default-long-table-ending-indent = 0pt
#let default-long-table-end-marker-cell-inset = (x: 0pt, y: 0pt)
#let default-long-table-continuation-text-size = 12pt
