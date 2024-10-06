#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch


Once we add the files to the staging area, we can create a commit with the command:

```bash
➜ git commit -m "Message describing changes made"
```

The commit message should be clear and describe what you have done.

If you want to add all *modified files* to the staging area and create a commit in one command, you can use it:

```bash
➜ git commit -am "Message describing changes made"
```

If you want to add all the files, even the untracked ones, you cannot do it in one command. You will first have to add the files to the staging area with `git add -A` and then create the commit, following the classic procedure.

---

=== Amend

Through the command `git commit --amend` we can edit the last commit we made if *not already pushed*. This allows us both to *change the commit message* and to *add files that are currently in stage to the previous commit*; rather than creating a new commit.
#footnote([note: actually the commit hash changes!])

#v(10%)

#grid(columns: 2,rows: 2,column-gutter: 10%, row-gutter: 15%,
[So you transform this:],
[into this:],
grid.cell(align: bottom)[
#set text(size: 10.5pt)
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
        commits:("init commit","second commit","unneeded commit",),
        head:2
    ),
    
    node((3,1.6), `a76bca`, stroke:none),

    edge((3,1),(4,1),"--",stroke:2pt+blue,label-pos:1,
      label:[
        #set text(style:"italic")
        some staged files]),
)
],
grid.cell(align: bottom)[
#set text(size: 10.5pt)
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
        commits:("init commit",
        "second commit",
        "renamed message\nall changes",),
        head:2
    ),

    node((3,1.6), `663b9d`, stroke:none),

  )
]
)


---

=== Amend

#grid(columns:2, column-gutter:5%,

[
  - If we only need to _rename_ the commit, the command: `git commit --amend -m “changed message”`.

  - Instead, to _add_ staged files to the previous commit, simply run the command `git add <file>` (if we don't already have the affected files in staging area) and then `git commit --amend`. 
  
  - At this point a file will show up in our default editor, here we can edit the commit message, read the changes made. 
    
  - Once the file is saved and closed, the commit will be edited.
],

image("/src/img/meme/git-commit-message.png")

)
  

---

=== Co-author in commit
#set align(center + horizon)

#grid(columns: 2, column-gutter: 1em,
  grid.cell(align: left)[Some platforms, such as GitHub, allow co-authors to be added to commits. This can be done by simply formatting the commit message as follows:],
  image("../img/co-authored-commit.png")
)

#v(10%)

```bash
➜ git commit -m "Commit message
>
>
Co-authored-by: NAME <NAME@EXAMPLE.COM>
Co-authored-by: ANOTHER-NAME <ANOTHER-NAME@EXAMPLE.COM>"
```

---
```bash
➜ git commit -m "Commit message
>
>
Co-authored-by: NAME <NAME@EXAMPLE.COM>
Co-authored-by: ANOTHER-NAME <ANOTHER-NAME@EXAMPLE.COM>"
```

Yeah, *no password required*, no approval required: you can add both *Linus Torvalds* and *your teacher* as Co-Authors
  
#grid(columns: 2,
  align: center,
  inset: 0pt,
  image("../img/linus-torvalds.jpg",width: 50%), 
  image("../img/marco-patrignani.png", width: 45%)
)
What a time to be alive.

---
=== Visualize commits

To view the commit history, you use: `git log`. This will show commits with their hash, author, date and message. You can also use options such as `--online` for a more compact view.

```bash
➜ git log --oneline
4f60048 (HEAD -> main, origin/main, my-fork/main, my-fork/HEAD) Merge pull request #3 from Username/main
7b6bc5a (my-fork/feature-1, feature-2, feature-1) Merge branch 'feature-2'
81a7ba6 feature 2 commit
f679048 feature 1 commit
ff2e750 renamed
0a0d983 ops
8732acf Create README.md
```