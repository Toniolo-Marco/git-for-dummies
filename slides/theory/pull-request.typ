#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch


By now it should be clear the importance of the _main_ branch; if multiple developers are working on a project, someone needs to be in charge of checking the *quality of the code in production* and *resolving merge conflicts* in the main.

#grid(columns: (1fr,3fr),rows: 2,column-gutter: 7%,row-gutter: 5%,
  grid.cell(
    rowspan: 2,
    [
      This is accomplished through _pull requests_ (PR), which are requests to *merge one branch into another* (usually in the main). _Pull requests_ allow for discussion of changes made, code review, and resolution of merge conflicts before merging the branches.
  ]),
  image("../img/pr-example.png"),
  [A PR consist of: title, description, id#footnote([It increases along with the issue number]), associated commits, status, labels...]
)


---

Unfortunately, to date, GitHub's free plan does not allow you to protect the _main_ branch from direct push:

#align(center)[#image("../img/gh-rules.png", width: 90%)]

One way around this problem, within organizations, is:
- create a team
- assign _triage_ permissions to this team
- add team members

This way, only the owners of the organization will be able to approve pull requests.