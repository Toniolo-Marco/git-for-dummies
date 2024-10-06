#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#grid(columns: 2, column-gutter: 10%,

image("/src/img/meme/git-clone.png"),

[In case the project already exists simply: move to the folder and clone the repository: `git clone <url-repository>`. This way we would have a copy of the remote repository on our machine.]

)

