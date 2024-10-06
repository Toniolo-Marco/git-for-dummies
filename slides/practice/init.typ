#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

To create a new project with Git, move to your project directory and initialize a repository with the command 
#footnote("Let's ignore for now the output that will be parsed later."): `git init`

We have thus created the local repository, on our computer. Git is also based on the concepts of *local* and *remote*. So changes made locally *do not automatically* affect the remote. 

Usually, for smaller projects, the remote repository is just one and will be hosted on *GitHub*.

This step requires having already created the organization to which the repository will belong. Alternatively, you can create it as your own and then pass ownership.


---

1. Open the page: _“https://github.com/orgs/organization/repositories”_

2. Press on the button: #box(fill: rgb("#29903B"),inset: 7pt, baseline: 25%, radius: 4pt)[#text(stroke: white, font: "Noto Sans", size: 7pt, weight: "light",tracking: 0.5pt)[New Repository]]

3. From here on fill in the fields, choosing the name, visibility and description of the repo. The README.md file can also be added later.

4. The repo page now advises us of the steps to follow directly on CLI: “_... create a new repository on the command line_”

    ```bash
    echo "# title" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/orgs/organization/repository.git
    git push -u origin main
    ```

    
---

The first command creates a file called README.md, if it does not already exist, and adds the string “\# title” to its contents. #footnote([The “\#” symbol in Markdown indicates a title.]) The other commands will be covered in the next chapters, however, for a concise description:

    - `git init` we have just seen, initializes a git project locally
    - `git add README.md` adds the file `README.md` to the staging area
    - `git commit -m “first commit”` performs the commit
    - `git branch -M main` sets _main_ as the main branch
    - `git remote add origin ...` sets the newly created repository on GitHub as remote of our local repository
    - `git push -u origin main` “publishes” on the remote repository the commit we just made.#footnote([Note: `-u` is the equivalent of `--set-upstream`, basically sets to which remote the branch in local should push to])