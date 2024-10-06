#import "@preview/ctheorems:1.1.2": *

// simil tail box with custom title
#let custom-box = thmbox(
  "id", // identifier - same as that of theorem
  "Title", // head
  inset: (x: 1.2em, top: 1em, bottom: 1em),
  fill: rgb("#87c1c8"),
).with(numbering:none)

// quite red box with custom title
#let alert-box = thmbox(
  "id", // identifier - same as that of theorem
  "title",
  titlefmt: title => text(fill: rgb("#4b0414"), weight: "bold")[#title],
  inset: (x: 1.2em, top: 1em, bottom: 1em),
  fill: rgb("#c88d86"),
).with(numbering:none)