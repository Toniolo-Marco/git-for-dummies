#import "@preview/diagraph:0.3.0": *
#import "@preview/minitoc:0.1.0": *
#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes

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
  keywords: ("advanced", "git", "guide", "advanced programming"),
  date: (auto)
)

// theme for code blocks
// #set raw(theme: "themes/halcyon.tmTheme")

// #show raw: it => block(
//   fill: rgb("#1d2433"),
//   inset: 8pt,
//   radius: 5pt,
//   text(fill: rgb("#a2aabc"), it)
// )


#set quote(block: true)
#show quote: set align(center)

#show link: underline


#include "cover.typ"


// Table of contents
#pagebreak() // Avoid starting behind the cover
#pagebreak()

#outline()
#pagebreak()

#include "git-basics-theory.typ"

#include "git-basics-practice.typ"

#include "roles-duties.typ"

#include "organization.typ"

#include "inviter.typ"

#include "git-advanced.typ"

#include "inviter.typ"

#include "actions.typ"