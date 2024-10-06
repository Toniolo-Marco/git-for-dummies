#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch


Everything we have seen so far is about the *local repository*, that is, the *repository present on our machine*.  To collaborate with other developers, it is necessary to have a remote repository, generally it is hosted on services such as GitHub, GitLab or self-hosted.

#grid(columns: (4fr,5fr),[
 The *remote repository* is a repository that *the whole team can access*; its branches can be *synchronized*, through pull and push operations, with local repositories. In this way, team members can *work on a common project* while maintaining a history of changes and versions.
],[
#align(center)[#scale(100%)[
  #set text(13pt)
  #fletcher-diagram(
      node-stroke: 1pt,
      edge-stroke: 1pt,
      spacing: 10em,

      node((1,0), [Remote Repository\ on GitHub], corner-radius: 2pt, label:"origin"),
      edge((1,0),(0.25,1),"-|>",bend: 10deg),
      edge((0.25,1),(1,0),"-|>",label:"git push", bend: 25deg),
      node((0.25,1), align(center)[Developer 1 \ Machine], shape: rect),
      edge((1,0),(1,1),"-|>", bend: 10deg),
      edge((1,1),(1,0),"-|>", bend: 10deg),
      node((1,1), [Developer 2 \ Machine], shape: rect),
      edge((1,0),(1.75,1),"-|>",label:"git pull", bend: 10deg),
      edge((1.75,1),(1,0),"-|>", bend: 25deg),
      node((1.75,1), [Developer 3 \ Machine], shape: rect),
  )
]]
]
)

The *remote repository* is generally called _origin_. For more complex projects, multiple _remote_ can be added.