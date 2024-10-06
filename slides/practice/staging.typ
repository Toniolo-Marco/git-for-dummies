#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

To bring modified files from the working directory to the staging area, we use the `git add` command. 

#grid(columns: 2, column-gutter: 10%,

[

Generally we use the command `git add -A` or `git add .` to add all modified files to the staging area. However, you can add files one at a time with `git add <filename>`. 

Similarly, we can add all files respecting a Regex with `git add <regex>`; for example: `git add Documentation/\*.txt`, will add all `.txt` files in the `Documentation` folder.
],

image("/slides/img/meme/git-add.png",width: 70%)

)