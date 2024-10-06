#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch
#import "../components/utils.typ": rainbow
#import "../components/thmbox.typ": custom-box, alert-box


#grid(columns:2, column-gutter:5%,

image("/slides/img/meme/merge-conflicts.png", width:90%),

[To *combine functionality implemented in 2 different branches*, there are several techniques; in this section we will only cover the classic _merge method_, as it is the most _safe_ and _simple_.

In the chapter theory, we saw the workflow we want to achieve.
]
)

---

There are several situations we can find ourselves in: if the branch we want to merge has not changed during the development of our feature, the merge will be called _fast-forward_.
#footnote([It is assumed that the branch _main_ label is always on the last commit _blue_.])

#v(10%)

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
                color:blue,
                start:(0,1),
                length:3,
            ),

            connect_nodes((3,1),(4,2),orange),
            branch( // feature branch
                name:"feature",
                color:orange,
                start:(3,2),
                length:3,
                head: 2,
            ),
        )
    ]
]


---

In such situations we are sure that *no merge conflicts will arise*, and this can be done with the commands: `git switch main`, followed by `git merge feature`. By doing so we will get a tree similar to this one:

#v(10%)

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
                color:blue,
                start:(0,1),
                length:6,
                head: 5
            ),
            branch_indicator("feature", (0,1.5), blue)
        )
    ]
]

---

What if instead there were commits on the main during the development of the feature we are interested in? (Someone implemented _feature 1_)

#v(10%)

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
                color:blue,
                start:(0,1),
                length:3,
            ),
            connect_nodes((3,1),(4,1), blue, bend:20deg),
            branch( // feature 1 branch
                name:"feature 1",
                indicator-xy: (3.5,1.5),
                color:blue,
                start:(3,1),
                length:3,
            ),
            
            connect_nodes((3,1),(4,2),teal),
            branch( // feature 2 branch
                name:"feature 2",
                color: teal,
                start: (3,2),
                length: 3,
                head: 2
            )
        )
    ]
]

#v(10%)

The graph would look like this: the _main_ branch has undergone changes and to highlight that the _feature 1_ has been integrated into the _main_ we used the same blue color but with different node linkage to highlight the start of commits belonging to the _feature 1_.

---

We can *redraw the graph* in the following way, where the *branch labels are aligned with the commit they are on*:
#footnote([This representation is similar to that of the VS-Code Git Graph plug-in that we recommend.])


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
                indicator-xy: (5.75,0),
                color:blue,
                start:(0,1),
                length:3,
            ),
            connect_nodes((3,1),(4,1), blue, bend:0deg),
            branch( // feature 1 branch
                name:"feature 1",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(3,1),
                length:3,
            ),
            
            connect_nodes((3,1),(4,2),teal),
            branch( // feature 2 branch
                name:"feature 2",
                indicator-xy: (5.75,2.5),
                color: teal,
                start: (3,2),
                length: 3,
                head: 2
            )
        )
    ]
]

#pause

In this case we cannot know a priori whether there will be merge conflicts or not.

---

To merge the two branches, as before, we can use the commands: `git switch main`, followed by `git merge feature-2`. If there are merge conflicts, we will be notified on the terminal and will have to resolve them manually.

As an example, I used a different string on the same line of the README.md file in two different branches. The result when trying to merge the second branch is as follows:

```bash
➜ git merge feature-2
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

---

Depending on the editor we use, files containing conflicts will or will not be highlighted. However each file with conflict on opening will show something similar:

#align(center)[
    #image("/slides/img/file-with-merge-conflicts.png")
]

---

- At this point all we have to do is remove the change we do not want to keep or alternatively combine both. 

- We continue by saving the file, closing it, and making sure it is in the staging area with the command: `git add ...`. 

- Now we can run the `git commit` command (which will assign the default message: _“Merge branch feature-2”_). 

Our commit history will be:

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
                commits:("", "", "", "", "", "", "Merge branch feature-2"),
                angle: 0deg,
                alignment: bottom
            ),
            branch_indicator("feature 1", (5.75,0.5), blue),
            
            connect_nodes((3,1),(4,2),teal),
            branch( // feature 2 branch
                name:"feature 2",
                indicator-xy: (5.75,2.5),
                color: teal,
                start: (3,2),
                length: 3,
            ),

            //merge edge
            connect_nodes((6,2),(7,1),teal),
        )
    ]
]


---

#custom-box(title:"Note")[
  
The _feature-2_ branch has not been deleted and is still on its last commit.

The _feature-1_ branch is also still on its last commit.

For both _feature_ branches this is a “merge _fast-forward_”: in fact if we move to either one and give the command `git merge main` we will have no conflicts whatsoever.
]

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // main branch
                name:"main",
                indicator-xy: (6.75,0.55),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
                commits:("", "", "", "", "", "", "Merge branch feature-2"),
                angle:0deg,
                alignment: bottom
            ),
            branch_indicator("feature 1", (7,0.15), blue),
            branch_indicator("feature 2", (6.5,0.15), blue),        

            //other branch stuff
            connect_nodes((3,1),(4,2),teal),
            branch( // old branch
                name:"",
                color: teal,
                start: (3,2),
                length: 3,
            ),
            connect_nodes((6,2),(7,1),teal),
        )
    ]
]
