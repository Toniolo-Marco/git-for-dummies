#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch
#import "../components/utils.typ": rainbow
#import "../components/thmbox.typ": custom-box, alert-box

=== Creating a New Branch

To create a new branch, we can use the command: `git switch -c <new-branch> [<start-point>]`.
#footnote([By `[start-point]` we mean the commit hash to start from; square brackets indicate that it is optional.])

This command creates a new branch and moves us to it. 

Alternatively we can use the commands: `git checkout -b <new_branch> [<start_point>]` or `git branch <new_branch> [<start_point>]`.
#footnote([The last option will not automatically move us to the new branch.])

=== Deleting a Branch in Local

To delete a branch, we can use the command: `git branch -d <branch-name>`.
#footnote([To force the deletion of a branch, use the `-D` option instead of `-d`. This option will delete the branch regardless of state.])

---


=== Renaming a Branch

Picking up right away on the suggestion received from GitHub in the @init[Slide] the command: 

`git branch -M main` is optional, it simply *renames* the default branch as _main_ instead of _master_; *it is up to you to choose* whether to run this command by renaming it. The same command can be used to rename any branch.

Github has switched their default branch name to _main_, to make sure the world knew they were a #rainbow[slave free organization.]


---

=== Moving between Branches


To move to a different branch, simply use the command: `git switch <branch-name>` or `git checkout <branch-name>`. 

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length:5,
                head:4
                ),
            // edge((5,0),(6,0),"--",stroke:2pt+blue),
            // //... other commits
            
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                indicator-xy:(7,1),
                color:orange,
                start:(1,1),
                length:5,
            )            
        )
    ]
]


#pause


#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length:5
            ),
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                indicator-xy:(7,1),
                color:orange,
                start:(1,1),
                length:5,
                head:4
            ),
            edge((5,0),(6,1),label:[HEAD],"-->",mark-scale:500%,bend:40deg)
        )
      ]
  ]

  
---


=== HEAD

Before continuing with the explanation, it is important to better understand concept of HEAD.#footnote([In the previous graph, the HEAD is represented by the commit with the circle completely filled.])


#custom-box(title:"HEAD")[
  The _HEAD_ is a *pointer* that *points to the current commit* and consecutively the contents of the working directory.
]

So, what we get is that the HEAD will move to the commit related to the selected branch. For example we are on the _main_ branch and we wanted to move to the _develop_ branch, the command would be: `git switch develop` or `git checkout develop`.


---


=== Move between commits

We can *move to a specific commit* too, with the command: `git switch <commit-hash>` or `git checkout <commit-hash>`. This command will cause a state called _detached HEAD_.
#footnote([Every repository has its own HEAD, including remotes. The commit that the HEAD points to in the remotes is the last commit of the main branch (usually _main_); and it is also what you see on the repository web page.])

#grid(columns:2, rows:2, column-gutter: 10%,

custom-box(title:"Detached Head")[
  The detached HEAD is a state in which the HEAD does not point to any branch, but directly to a commit. 
],

grid.cell(rowspan: 2,
image("/slides/img/meme/detached-head.png", width: 70%)),

alert-box(title:"Warning")[
    This means that if we create a new commit in this state, it will not be added to any branch and may be lost.
]
)

#include "../animations/detached-head.typ"

=== Move Branch to a Commit

So far we have always imagined a branch as a like an entire commit line, *in reality* a *branch is* nothing more than *a label associated with a specific commit*. 

This is why we can move a branch to another commit with the command `git branch --force <branch-name> [<new-tip-commit>]`.

This is why some graphs or some plugins represent, not only each branch with different color, but also the label of the branch next to the commit itself:


#align(center)[
    #scale(95%)[
        #set text(10pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch( // main branch
                name:"main",
                indicator-xy:(5.5,1),
                color:blue,
                start:(0,1),
                length:5,
            ),

            connect_nodes((3,1),(4,2),orange),
            branch( // develop branch
                name:"develop",
                indicator-xy:(7.75,1.5),
                color:orange,
                start:(3,2),
                length:5,
            ),

            connect_nodes((3,0),(2,1),red),
            branch(// detached HEAD commits
                color: red, 
                start:(2,0),
                length:3,
                head:2,
            )
        )
    ]
]
