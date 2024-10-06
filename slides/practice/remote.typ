#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "/slides/components/gh-button.typ": gh_button
#import "/slides/components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch
#import "/slides/components/utils.typ": rainbow
#import "/slides/components/thmbox.typ": custom-box, alert-box


#grid(columns: 2, column-gutter: 5%,
[So far* we have worked only on the local repository*, addressing scenarios without considering the remote repository. In this chapter we will make up for this shortcoming.],

image("/slides/img/meme/git-remote-add.png")

)

---

=== Analysis.


To get information about the remote we can make use of several commands:

#align(center,

```bash
➜ git remote show              #show the name of all remotes
    origin
➜ git remote show origin       #show info about one remote
    * remote origin
    Fetch URL: https://github.com/nome-organizzazione/nome-repo.git
    Push  URL: https://github.com/nome-organizzazione/nome-repo.git
    HEAD branch: (unknown)
➜ git remote -v                #show info about all remotes
    origin	https://github.com/nome-organizzazione/nome-repo.git (fetch)
    origin	https://github.com/nome-organizzazione/nome-repo.git (push)
```
)

As you can guess the command suggested by GitHub: `git remote add origin URL`, (seen previously) will add the URL as a remote repository, with the name *origin*. 

---

=== Fetch

The `git fetch` command *downloads new commits, branches and tags from the remote repositories* and thus allows us to compare the information received with our local repo. *All this is performed without applying the changes to our branches locally.*

In particular, the command has this syntax: `git fetch <remote> <refspec>`. If launched without arguments it may not update all the remotes (or the one we are interested in). To know which remote involves the fetch operation, try:

#align(center,
```bash
➜  git fetch -v
    POST git-upload-pack (186 bytes)
    From https://github.com/Owner/repo
     = [up to date]      main         -> origin/main
     = [up to date]      feature-1    -> origin/feature-1
     = [up to date]      feature-2    -> origin/feature-2
```
)

---

=== Fetch

By default, git uses _origin_ as the remote, so for example if we had a remote, like the one depicted here; *the command would not work*:

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // origin main branch
                name:"main ",
                remote: "my-fork ",
                indicator-xy: (4.75,0.5),
                color:blue,
                start:(0,1),
                length:5,
                head: 4,
            ),
        )
    ]
]

#pause

There are several solutions we could adopt:

- Obviously use the specific command `git fetch my-fork`.
- Apply fetch to all remotes: `git fetch --all`.
- Set the remote we are interested in as the default. This can be done either by editing the file in `.git/config`, or with the command.


---

=== Push and Pull Operations

The push and pull operations are needed to keep *local and remote repositories synchronized*. 

As the name of the command itself suggests, `git push` *sends local changes to the remote repository*, while `git pull` *downloads and applies changes* from the remote repository.

To identify the membership of a branch to a remote repository in the branch label we will use the notation _remote/branch_:

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // main branch
                name:"main",
                indicator-xy: (6.75,0.5),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
            ),

            // origin/main indicator
            branch_indicator("origin/main", (3.75,0.5), blue),

        )
    ]
]

---

=== Push

In the case just presented, the _main_ branch in the local repository is “ahead” of the branch in the remote repository. To synchronize the two branches, therefore, we will have to do a _push_.

Once we run the `git push origin main` command, if all goes well, the result will be:

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // main branch
                name:"main ",
                remote: "orgin ",
                indicator-xy: (6.75,0.5),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
            ),
        )
    ]
]

As you can see we use this special label to indicate that the branch locally is aligned with the remote branc

---

=== Pull

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch_indicator("main", (3.75,0.5), blue),

            branch( // main branch
                name:"main/origin",
                indicator-xy: (6.8,0.5),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
            ),

            //other branch stuff
            connect_nodes((3,1),(4,2),teal),
            branch( // old branch
                name:"feature",
                indicator-xy: (6,2.5),
                color: teal,
                start: (3,2),
                length: 3,
            ),
        )
    ]
]

In a similar case, however, it is useful to move to the main branch and perform a _pull_: we are developing our feature and someone has pushed to the main branch in remote.


---

=== Options

#alert-box(title:"Warning")[
There are many other options applicable to the `git push` and `git pull` commands, in addition to `-u` which we have seen in the previous chapters; such as: `--force` and `--force-with-lease` we advise you to read the official documentation@git-docs before using them.
]
#align(center,
image("/slides/img/meme/git-help.png", width: 40%)
)
---

=== Pull Request

#custom-box(title:"Pull Requests")[
PR are the tools through we apply *changes in repositories* on which *we do not have permissions*. They are widely used by the community and supported by GitHub, Git Lab (Merge Request) and BitBucket.
]

PR allows developed features to be submitted to the maintainers of the original project, these will be visible to the entire organization (if private, or alternatively to everyone). Subsequently it can be accepted, rejected, or subject to adjustment.
#footnote([On GitHub, PRs cannot be removed except by contacting GitHub support itself.])
In the same way as a merge, PRs can also have conflicts, which must be resolved in order to integrate the desired features.
#footnote([If not done yet, you will need to log in via `gh` and set the default repo with the interactive command `gh repo set-default` before proceeding.])


---


#include "../animations/pr.typ"

#include "../animations/remote-example.typ"

=== Remove Remote Branches

Going back to the previous example, in order to *clean everything up*, we would like to delete the feature branches that we used previously. Suppose we have pushed _feature-2_ previously
#footnote([If, on the other hand, a branch, created by others, so we don't have a copy of it locally, is deleted directly in the remote, just run `git fetch --all --prune`.])

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"main",
                remote:("origin ","my-fork "),
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-0.75),
                length:7,
                head:6,
                commits:("",none,none,none,none,none,"merge pr"),
                angle: 0deg
            ),

            connect_nodes((1,-0.75),(2,1),blue),
            branch( // main branch
                name:"",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(1,1),
                length:5,
                commits:("","",none,"","")
            ),
            connect_nodes((6,1),(7,-0.75),blue,bend:-25deg),

            //feature-2 branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "feature-2",
              remote:("my-fork"),
              indicator-xy: (5,0),
              color: orange,
              start: (2.5,0),
              length:2
            ),
            connect_nodes((5,1),(4.5,0),orange),
            
            //feature-1 branch
            connect_nodes((2,1),(3,2),teal),
            branch(
                name:"feature-1",
                indicator-xy: (6,1.5),
                color: teal,
                start: (2,2),
                length: 3,
            ),
            connect_nodes((5,2),(6,1),teal),
        )
    ]
]

---

First we move to a local branch different from the ones we want to delete.

To delete the branch remotely we give the command `git push my-fork -d feature-2` and immediately after that to delete it locally we can give `git branch -d feature-1 feature-2`. 

Then we can run the command `git fetch --all`.


#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"main",
                remote:("origin ","my-fork "),
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-0.75),
                length:7,
                head: 6,
                commits:("",none,none,none,none,none,"merge pr")
            ),

            connect_nodes((1,-0.75),(2,1),blue),
            branch( // main branch
                name:"",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(1,1),
                length:5,
                commits:("","",none,"","")
            ),
            connect_nodes((6,1),(7,-0.75),blue,bend:-25deg),

            //orange branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "",
              indicator-xy: (5,0),
              color: orange,
              start: (2.5,0),
              length:2
            ),
            connect_nodes((5,1),(4.5,0),orange),
            
            //teal branch
            connect_nodes((2,1),(3,2),teal),
            branch(
                name:"",
                indicator-xy: (6,1.5),
                color: teal,
                start: (2,2),
                length: 3,
            ),
            connect_nodes((5,2),(6,1),teal),
        )
    ]
]