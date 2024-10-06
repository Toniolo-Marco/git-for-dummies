#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#block(breakable:false, [
A commit is a snapshot of the code at a given time, generally having these attributes:

- hash unique identifier
- message describing the changes made
- author (email and name), co-authors
- date and time of the commit

Each #link("https://git-scm.com/docs/git-commit")[commit] is linked to the previous one, and differs from it in the changes made. This cycle of changes and commits is the basis of Git.

#align(center)[
   #fletcher-diagram(
    node-stroke: .1em,
    node-fill: gradient.linear(rgb("#448C95").lighten(20%), rgb("#176B87").lighten(20%), rgb("#04364A").lighten(20%)),
    spacing: 4em,
    node-shape: rect,
    
    node((0,0), "working \n directory", width: auto ),
    edge((0,0), (0,0), label:[
      #set text(style: "italic")
      #h(25pt)
      local changes],label-anchor:"north-west", "--|>", bend: 130deg),
    edge((0,0), (1,0), `git add`, "-|>", bend: -40deg),
    node((1,0), "staging \n index",  width: auto),
    edge((1,0), (2,0), `git commit`, "-|>", bend: -40deg),
    node((2,0), "commit \n history",  width: auto,),
    edge((2,0),(2,1), (0,1), (0,0), label-side:left, label:[
      #set text(style: "italic")
      back to working directory without changes], "--|>", bend: 50deg)
  )
]
]
)

---

Inside our machine git conceptually uses several states to correctly version our files. @git-changes

#align(center,image("../img/local-repo.png", width: 90%))

---

States:

- *Untracked*: The file exists in the working directory, but Git is not yet monitoring it, it may be actively ignored.

- *Tracked*: All other files, whether they are *Unmodified*, *Modified* or *Staged*.

- *Unmodified*: The file has been modified since the last version was committed.

- *Modified*: Conversely, the file has been modified since the last committed version (even a newly created file with text in a new repository). Some editors list files in this state under the name _changes_.

- *Staged*: The file, or rather a version of it, is brought into the staging area. The staging area is an intermediate area preceding a commit. The collection of files in this state is also called _staged changes_.

---

Actions:

- *Commit*: As we said commit represents a step, in which all files are at a certain version. Suppose, for example, that we need to correct a book: it might be a good strategy to group all the corrections of a chapter within a commit: i.e. at each step of task completion.  It is of course possible to manipulate (partially) these commits and travel between them, we will see how later.

- *Edit the file*: At each commit all included files will be read by git as *Unmodified* and this "cycle" will start again. Editing a file, or creating it, means bringing it into the *Modified* state.

- *Stage the file*: The *current* version of the file on which this action is performed is brought to the *staged* state, further changes on the same file will bring a *new version* of the file into the *modified* state. This is why we generally perform this operation and a *commit immediately afterwards*.

- *Add/Remove the file*: It is of course possible to add or remove files from the working directory, to get a new file versioned by git you use the same command you use to get it from *modified* to *staged*, i.e. `git add <file_name>`. However, when you remove a previously versioned file, git will automatically notice and handle it.
