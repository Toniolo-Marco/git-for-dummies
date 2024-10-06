#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "/src/components/gh-button.typ": gh_button
#import "/src/components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch
#import "/src/components/utils.typ": rainbow
#import "/src/components/thmbox.typ": custom-box, alert-box

Still on the subject of undoes, the `git revert` command is particularly useful. Essentially what this command does is the opposite of `git diff`: that is, passed a commit as a reference, the differences made by it will be applied in reverse. Also automatically a new commit will be made.

One of the advantages of `git revert` is the fact that it does not rewrite history, as well as the fact that it is _safe_: it is always possible to go back to the previous commit and resume from there, deleting the revert commit if unnecessary.

As an example we take directly the one provided by Atlassian on the page dedicated to #link("https://www.atlassian.com/git/tutorials/undoing-changes/git-revert")[this command].

I quote the code below for simplicity:

```bash
➜ git init .
Initialized empty Git repository in /git_revert_test/.git/
➜ touch demo_file
➜ git add demo_file
➜ git commit -am "initial commit"
[main (root-commit) 299b15f] initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 demo_file
➜ echo "initial content" >> demo_file
➜ git commit -am "add new content to demo file"
[main 3602d88] add new content to demo file
n 1 file changed, 1 insertion(+)
➜ echo "prepended line content" >> demo_file
➜ git commit -am "prepend content to demo file"
[main 86bb32e] prepend content to demo file
 1 file changed, 1 insertion(+)
```

---

This set of commands should not surprise us;

#align(center)[
  #scale(85%)[
      #set text(10pt)
      #fletcher-diagram(
          node-stroke: .1em,
          node-fill: none,
          spacing: 4em,
          mark-scale: 50%,
          
          // main branch
          branch(
              name:"main",
              color:blue,
              start:(0,0),
              length: 3,
              head:2,
              commits: ("initial commit",
                        "add new content",
                        "prepend content")
          ),
      )
  ]
],


---


Continuing with the suggested commands we have:

```bash
➜ git revert HEAD
[main b9cd081] Revert "prepend content to demo file" 1 file changed, 1 deletion(-)
```

Running the command will probably open the editor that allows us to change the commit message or leave the default one.

#align(center)[
  #scale(85%)[
      #set text(10pt)
      #fletcher-diagram(
          node-stroke: .1em,
          node-fill: none,
          spacing: 4em,
          mark-scale: 50%,
          
          // main branch
          branch(
              name:"main",
              color:blue,
              start:(0,0),
              length: 4,
              head:3,
              commits: ("initial commit",
                        "add new content",
                        "prepend content",
                        "Revert \"prepend ...\"")
          ),
      )
  ]
],

```bash
➜ cat demo_file 
initial content
``` 


---


The direct consequences of the advantages listed earlier make this method the best when working in teams since there is no need for a `git push --force`.
