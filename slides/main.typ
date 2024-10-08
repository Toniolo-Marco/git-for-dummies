#import "@preview/touying:0.5.2": *
#import themes.university: *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly

#import "/slides/components/code-blocks.typ": code-block, window-titlebar
#import "/slides/components/utils.typ": n_pagebreak

// Code-blocks Rule
#show raw.where(block: true): it => code-block(
  grid(rows:2,row-gutter: 0pt,
    // always keep the dots on the left!
    grid.cell(align: left)[
      #window-titlebar
    ],
    
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

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // config-common(handout: true),
  config-info(    
    title: [Git for Dummies],
    subtitle: [Slides],
    author: [Toniolo Marco],
    date: datetime.today(),
    institution: [Università degli Studi di Trento],
    // logo: emoji.crab,
  ),
)
#set text(size: 18pt)
#set heading(numbering: numbly("{1}.", default: "1.1"))

// align sub titles near to main slide title
#show heading.where(level: 3): it =>[
  #set align(top+left)
  #it
]

#set align(horizon) //align vertically each slide content

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 0em))


= Theory

== Introduction

#include "./theory/introduction.typ"

== Commit

#include "./theory/commit.typ"

== Branch

#include "./theory/branch.typ"

== Remote Repository

#include "./theory/remote-repo.typ"

== Pull Request

#include "./theory/pull-request.typ"

== Fork

#include "./theory/fork.typ"

= Practice

== Configuration<config>

#include "./practice/configuration.typ"

== Init<init>

#include "./practice/init.typ"

== Clone

#include "./practice/clone.typ"

== Staging

#include "./practice/staging.typ"

== Checkout

#include "./practice/checkout.typ"

== Analysis

#include "./practice/status-analysis.typ"

== Commit

#include "./practice/commit.typ"

== Branch

#include "./practice/branch.typ"

== Merge

#include "./practice/merge.typ"

== Remote

#include "./practice/remote.typ"

= Advanced


#slide[
#bibliography("refs.yaml", style: "institute-of-electrical-and-electronics-engineers", title: "References")
]