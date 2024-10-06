#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#grid(
    columns: (3fr,2fr), column-gutter: 5%,
    
    [
      During the development of git, several features were developed and over time almost all of them have been added to the `git checkout` command. 
      
      Currently the git team, is working on separating these features into separate commands.

      We will find different commands that serve the same purpose. We will try to cover both versions for completeness; however, it is advisable to use the newer commands.

      To immediately give an example of this problem, let us look at the case where we want to see the current state we are in:
    ],
    figure(
        image("../img/graphical-representation-git-checkout.png"), 
        caption: [Graphical representation of the `git checkout` command]
    )
)