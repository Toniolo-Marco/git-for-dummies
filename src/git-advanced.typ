#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, double_node, connect_nodes, branch

== Combinare i commit
Talvolta potremmo accorgerci di aver fatto commit non necessari, o di voler avere un solo commit per la feature che stiamo sviluppando; in modo da avere una storia più pulita e comprensibile e delle PR che non contengono commit inutili.


#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            // master branch
            branch("main",blue,(0,0),7,1.5em, 1em, ..(0,6)),
            edge((7,0),(8,0),"--",stroke:2pt+blue),
            //... other commits
            
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch("develop",orange,(1,1),5,1.5em, 1em,..(0,3,4,5)),
            connect_nodes((6,1),(7,0),orange),

            // feature branch
            connect_nodes((2,1),(4,2),yellow),
            branch("feature",yellow,(3,2),1,1.5em, 1em),
            connect_nodes((4,2), (5,1),yellow),

            // 2nd feature branch
            connect_nodes((2,1),(4,3),teal),
            branch("2nd feature",teal,(3,3),1,1.5em, 1em),
            connect_nodes((4,3), (6,1),teal),
        )
    ]
]


In questi casi possiamo usare il comando `git rebase -i HEAD~n` dove `n` è il numero di commit che vogliamo combinare.