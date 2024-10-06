#import "@preview/touying:0.5.2": *
#import themes.university: *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#import "@preview/ctheorems:1.1.2": *
#import "@preview/numbly:0.1.0": numbly

#import "/src/components/code-blocks.typ": code-block, window-titlebar
#import "/src/components/utils.typ": n_pagebreak
#import "/src/components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#slide(repeat:6, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  #only("1")[

    Let's see a complete example:
    
    #align(center)[
        #scale(100%)[
            #set text(11pt)
            #fletcher-diagram(
                node-stroke: .1em,
                node-fill: none,
                spacing: 4em,
                mark-scale: 50%,
    
                branch_indicator("my-fork/main", (4.5,1.5), blue),
                branch_indicator("origin/main", (0.75,0.5), blue),
    
                branch( // main branch
                    name:"main",
                    indicator-xy: (5.75,0.5),
                    color:blue,
                    start:(0,1),
                    length:6,
                    head: 5,
                    commits:("","","",none,"","",)
                ),
    
                //feature-2 branch
                connect_nodes((3.5,0),(3,1),orange),
                branch(
                  name: "feature-2",
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

  We developed two different features, merged the _feature-2_ locally and pushed it on the fork. Next we completed _feature-1_ and merged it.
  
  ]

  #only("2")[
  
  At this point we apply everything we have seen in this chapter: moving to the _main_ branch we push to our fork with the command: `git push my-fork`. 

  #align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch_indicator("origin/main", (0.75,0.5), blue),
            branch( // main branch
                name:"main ",
                remote:"my-fork ",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(0,1),
                length:6,
                head: 5,
                commits:("","","",none,"","",)
            ),

            //feature-2 branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "feature-2",
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

    Now we can proceed with our PR, choosing as is common to stay on our _main_ branch when we run the `gh pr create` command; that way the PR will come from that one.
#footnote([You cannot have multiple open PRs coming from the same branch of the same fork.])
  ]

  #only("3")[

Once the request is accepted, we can run the `git fetch origin` command to find out the most recent changes on the remote origin and we will be in this state:

#align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"origin/main",
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-1),
                length:7,
                commits:("",none,none,none,none,none,"merge pr"),
                angle: 0deg
            ),

            connect_nodes((1,-1),(2,1),blue),
            branch( // main branch
                name:"main" ,
                remote:"my-fork ",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(1,1),
                length:5,
                head: 4,
                commits:("","",none,"","")
            ),
            connect_nodes((6,1),(7,-1),blue,bend:-25deg),

            //feature-2 branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "feature-2",
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



  ]

  #only("4")[
    This kind of graph is pretty normal, if we analyze it, we notice that _origin/main_ has as its first commit the last commit in common and as its last commit the merge commit. Fortunately for us, the project maintainers had already performed this merge. All that remains *now* is to *synchronize our fork and our local repository*.

    Both the web interface and the gh tool allow us to synchronize a branch of our fork with the most recent version of the original remote. The command to do this is: `gh repo sync owner/cli-fork -b BRANCH-NAME`@gh-sync. In our case the `BRANCH-NAME` will obviously be _main_. 


  ]

  #only("5")[

    To continue the example one step at a time and make sure that everything went as we expected, we can run `git fetch` again:

    #align(center)[
    #scale(100%)[
        #set text(11pt)
        #fletcher-diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch_indicator("my-fork/main", (6,-0.75), lime),
            branch( // remote origin
                name:"origin/main",
                indicator-xy: (6,-0.45),
                color:lime,
                start:(0,-1),
                length:7,
                commits:("",none,none,none,none,none,"merge pr"),
                angle: 0deg
            ),

            connect_nodes((1,-1),(2,1),blue),
            branch( // main branch
                name:"main",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(1,1),
                length:5,
                head: 4,
                commits:("","",none,"","")
            ),
            connect_nodes((6,1),(7,-1),blue,bend:-25deg),

            //feature-2 branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "feature-2",
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

  ]

  #only("6")[
    If everything went as we expect the last thing left to do is to update the _main_ branch locally with `git pull` if we are on it, otherwise specifying branch and remote.

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
  ]
])