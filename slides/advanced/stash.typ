#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "/src/components/gh-button.typ": gh_button
#import "/src/components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch
#import "/src/components/utils.typ": rainbow
#import "/src/components/thmbox.typ": custom-box, alert-box