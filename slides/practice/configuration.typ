#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)
#import fletcher: shapes

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#align(center,
grid(rows:2,

[
```bash
➜  git config --global user.name "name"
➜  git config --global user.email "your@email"
```
],[

#scale(95%)[
  #set text(11pt)
  
    // Inline Code Rule
  #show raw.where(block: false): it => box(
      fill: none,
      inset: 0pt,
      baseline: 0%,
      radius:2pt,
      it
  )
  #fletcher-diagram(
  node([#grid(rows:3,columns:2, column-gutter: 30pt, row-gutter: 10pt, align: horizon,
    grid.cell( colspan: 2, align: center,
    text(weight: "bold", size: 15pt)[System Level]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[Base]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[View]
    ),
    
    grid.cell( align: center,
    [`git config --system`]
    ),
    
    grid.cell( align: center,
    [`git config --system --list`]
    )
  )], stroke: 1pt+teal, fill: teal, shape: shapes.trapezium.with(dir:bottom), width: 125mm, height: 30mm),

  edge("..>"),
  node((1,0), [Operating System]),
  
  node((0,0.8),[#grid(rows:3,columns:2, column-gutter: 30pt, row-gutter: 10pt, align: horizon,
    grid.cell( colspan: 2, align: center,
    text(weight: "bold", size: 15pt)[Global Level]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[Base]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[View]
    ),
    
    grid.cell( align: center,
    [`git config --global`]
    ),
    
    grid.cell( align: center,
    [`git config --global --list`]
    )
  
  )], stroke: 1pt+yellow, fill:yellow, shape: shapes.trapezium.with(dir:bottom), width: 112mm, height: 30mm),

  edge("..>"),
  node((1,0.8), [User Specific]),
  
  node((0,1.71), [#grid(rows:5,columns:2, column-gutter: 15pt, row-gutter: 12pt, align: horizon,
    grid.cell( colspan: 2, align: center,
    text(weight: "bold", size: 15pt)[Local Level]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[Base]
    ),
    
    grid.cell( align: center,
    text(weight: "bold")[View]
    ),
    
    grid.cell( align: center,
    [`git config --local`]
    ),
    
    grid.cell( align: center,
    [`git config --local --list`]
    ),

    grid.cell( colspan: 2, align: center,
    text(weight: "bold")[Stored]
    ),

    grid.cell( colspan: 2, align: center,
    [`.git/config`]
    )
    
  )], shape: shapes.trapezium.with(dir:bottom), stroke: 1pt+orange, fill:orange,width: 98mm, height: 40mm),

  edge("..>"),
  node((1,1.71), [Repository Specific]),
)

]

])
)
---

#set align(center)

`gh` is the tool we will use to interact from CLI with GitHub, to configure our account we use:

```bash
➜  gh auth login
    ? What account do you want to log into? GitHub.com
    ? What is your preferred protocol for Git operations on this host? SSH
    ? Generate a new SSH key to add to your GitHub account? Yes
    ? Enter a passphrase for your new SSH key (Optional): 
    ? Title for your SSH key: GitHub CLI
    ? How would you like to authenticate GitHub CLI? Login with a web browser
    
    ! First copy your one-time code: A111-B222
    Press Enter to open github.com in your browser... 
    ✓ Authentication complete.
    - gh config set -h github.com git_protocol ssh
    ✓ Configured git protocol
    ✓ Uploaded the SSH key to your GitHub account: /home/path/to/.ssh/key.pub
    ✓ Logged in as GitHub-Username
```