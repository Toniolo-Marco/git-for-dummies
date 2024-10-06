#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#slide(repeat: 5, self => [
  #let (uncover, only) = utils.methods(self)


  #align(center)[
  Here we have an example of this state #uncover("3-5")[in  #text(fill: red)[red]]
  ]

  #align(center)[#scale(100%)[
    #set text(11pt)
    #fletcher-diagram(
      node-stroke: .1em,
      node-fill: none,
      spacing: 4em,
      mark-scale: 50%,

      only("1", {        
        branch( // main branch
          name:"main",
          color:blue,
          start:(0,1),
          length:5,
          head: 4
        )
      }),

      only("2", {        
        branch( // main branch
          name:"main",
          color:blue,
          start:(0,1),
          length:5,
          head: 1
        )
      }),

      only("3-5",{      
        branch( // main branch
          name:"main",
          color:blue,
          start:(0,1),
          length:5,
        )
        connect_nodes((3,0),(2,1),red)
      }),
      
      only("3", {  
        branch(// detached HEAD commits
          color: red, 
          start:(2,0),
          length:1,
          head:0
        )
      }),

      only("4",{
        branch(// detached HEAD commits
          color: red, 
          start:(2,0),
          length:2,
          head:1
        )
      }),

      only("5",{
        branch(// detached HEAD commits
          color: red, 
          start:(2,0),
          length:3,
          head:2
        )
      }),

      connect_nodes((3,1),(4,2),orange),
      
      branch( // develop branch
        name:"develop",
        color:orange,
        start:(3,2),
        length:5,
      ), 
      
    )
  ]]
])