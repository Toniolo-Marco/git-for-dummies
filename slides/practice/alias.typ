#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

Aliases@git-alias are often *used to shorten longer commands*, or *combine* several *commands into one*. For example, to create an alias to add all files in stage and then also commit untracked files:

```bash
➜ git config --global alias.commit-all '!git add -A && git commit'

➜ git commit-all -m "Message describing changes made"
```
