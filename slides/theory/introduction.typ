#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)



#grid(columns: 2, column-gutter: 10%,

[Git is the *most widely used distributed versioning system*. It is used to manage and track changes to source code in software development projects. 

It is an *essential* tool *for coordinating work between several developers*, keeping a *history* of the changes made. In this way, we avoid having several scattered versions of our project: _‘final’ ‘final-final’ ‘last-final-version’_ etc...

You will no longer have to spam ctrl+Z to go back to previous versions.],

grid.cell(align: center,
image("/slides/img/meme/whats-git.jpg", width: 70%),
)
)


#pagebreak()

#grid(columns: (1fr,1fr), column-gutter: (5%),
[
  Git is based on a mechanism called Git's _"three trees"_:  #footnote(["Trees" may be a misnomer, as they are not strictly traditional tree data-structures and most commits have only one successor.])
  
  
  - *Working Directory*: This tree is in sync with the local filesystem and is representative of the immediate changes made to content in files.
  
  - *Staging index*: This tree is tracking Working Directory changes, that have been promoted (*staged*), it is a caching mechanism.
  
  - *Commit history*: It's a tree, with one root, where each branch is composed of commits: nodes that represent a _permanent_ snapshot in the project.
],[
   #fletcher-diagram(
    node-stroke: .1em,
    node-fill: gradient.linear(rgb("#448C95").lighten(20%), rgb("#176B87").lighten(20%), rgb("#04364A").lighten(20%)),
    spacing: 4em,
    node-shape: rect,
    
    node((0,0), "working \n directory", width: auto ),
    edge((0,0), (0,0), label:[
      #set text(style: "italic")
      local changes], "--|>", bend: 130deg),
    edge((0,0), (1,0), `git add`, "-|>", bend: -40deg),
    node((1,0), "staging \n index",  width: auto),
    edge((1,0), (2,0), `git commit`, "-|>", bend: -40deg),
    node((2,0), "commit \n history",  width: auto,),
  )
]
)



