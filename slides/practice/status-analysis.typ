#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

To view the list of files in the staging area and other general information, we can use the command:

```bash
➜ git status       
On branch main                                  # Current branch
No commits yet

Changes to be committed:                        # File in stage
(use "git rm --cached <file>..." to unstage)
    new file:   README.md                       # File added to stage (new file)
```

This is the case where we just created the repository and added the README.md file.

---

If, on the other hand, we have modifications in stage and others that are not, we will get:

```bash
➜ git status
On branch git-basics                                # The current branch
Your branch is up to date with 'origin/git-basics'. # Last commit is the same as the remote

Changes to be committed:                            # List of staged files
  (use "git restore --staged <file>..." to unstage)
        modified:   src/git-basics-theory.typ

Changes not staged for commit:                      # List of not staged files
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   src/git-basics-practice.typ

Untracked files:                                    # List of Untracked files
  (use "git add <file>..." to include in what will be committed)
        src/untracked-file.ops
```

---

Similarly with `git checkout` we can have a coarse summary; in the output we will see only the changed files, without further details and no *untracked* files will be shown.

#v(10%)

```bash
➜ git checkout
M       src/git-basics-practice.typ                 # Show only modified files
M       src/git-basics-theory.typ                   #
Your branch is up to date with 'origin/git-basics'. #
```

---

In addition to status to examine all differences between the last commit and current files we can use the command `git status -vv`, short for `git status -v -v`. 

Alternatively we can use `git diff @` from version 1.8.5, or `git diff HEAD` for earlier versions.
#footnote([Neither shows the contents of *untracked* files; `git stastus -vv` just shows that they exist.])

For now, with `HEAD` we refer to the last commit we are in, later we will provide a full description.


---

If we have made *changes* to *multiple files*, it would be very useful to have a *fine-grained control* over the *differences* we want to display:

  - To view the changes made on the individual file we can use the `git diff <filename>` command.

  - To view all the changes to staged files we can use `git diff --cached` (or its alias `--staged`). Otherwise we can use `git status -v`.

  - To instead visulize changes the changes of files that are not in stage we can use `git diff`. #footnote([the `--no-index` argument is needed if we are not in a git repository.])