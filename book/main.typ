#import "@preview/diagraph:0.3.0": *
#import "@preview/minitoc:0.1.0": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import "./components/code-blocks.typ": code-block, window-titlebar
#import "./components/utils.typ": n_pagebreak

#set heading(numbering: "1.")
#set page(numbering: "1")
#set page(margin: (
  top: 1.5cm,
  bottom: 1.5cm,
  x: 1.5cm,
))

#set document(
  title: [Git for Dummies],
  author: ("Toniolo Marco, Frigerio Federico"),
  keywords: ("git", "guide", "GitHub"),
  date: (auto)
)

// Code-blocks Rule
#show raw.where(block: true): it => code-block(
  stack(
    dir:ttb,
    window-titlebar,
    block.with(
      fill: rgb("#1d2433"),
      inset: 8pt,
      radius: 5pt,
    )(
      text(fill: rgb("#a2aabc"), it)
    )
  )
)

// Inline Code Rule
#show raw.where(block: false): it => box(
    fill: rgb("#1d2433"),
    inset: 5pt,
    baseline: 25%,
    radius:2pt,
    text(fill: rgb("#a2aabc"), it
  )
)

#set quote(block: true)
#show quote: set align(center)

#show link: underline

#include "cover.typ"

// Table of contents
#n_pagebreak(n: 2) // Avoid starting behind the cover

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(depth: 2, title: "Indice", indent: auto)
#pagebreak()

#include "git-basics-theory.typ"

#include "git-basics-practice.typ"

#include "git-advanced.typ"

#n_pagebreak(n: 1)

#include "roles-duties.typ"

#include "organization.typ"

#include "inviter.typ"

#include "actions.typ"

#n_pagebreak(n:2)

#bibliography("refs.yaml", style: "institute-of-electrical-and-electronics-engineers", title: "Bibliografia")
