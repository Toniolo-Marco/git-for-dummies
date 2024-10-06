#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch


Branches are used to work on different features or bugfixes separate from the main branch (`main` or `master`). 

Through the use of branches in addition to maintaining proper project organization, it allows us to work on multiple features in parallel without interfering with the work of other team members.

Branches can be created, renamed, moved, merged (_merge_) and deleted. 

Merge as you might guess is a key operation, which allows us to merge features developed in two different branches into one, or to bring changes from one branch into the main branch.


---

#align(center,[ 
  #stack(dir: ttb,spacing: 15%,
    [The most common workflow:],
    scale(100%)[
        #set text(10pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length:7),
            edge((7,0),(8,0),"--",stroke:2pt+blue),
            //... other commits
            
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                color:orange,
                start:(1,1),
                length:5),
            connect_nodes((6,1),(7,0),orange),

            // feature branch
            connect_nodes((3,1),(4,2),yellow),
            branch(
                name:"feature",
                color:yellow,
                start:(3,2)),
            connect_nodes((4,2), (5,1),yellow),

            // 2nd feature branch
            connect_nodes((2,1),(3,3),teal),
            branch(
                name:"2nd feature",
                color:teal,
                start:(2,3),
                length:3),
            connect_nodes((5,3), (6,1),teal),
        )
    ],

    [ All developed features are merged with _develop_, later when you are sure that the code is stable and ready for production, you can merge develop into _main_.]
  )
])