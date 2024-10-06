#import "@preview/touying:0.5.2": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#import "../components/gh-button.typ": gh_button
#import "../components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#let stroke_color = "#9198A1"
#let fill_color = "#262C36"
#let text_color = "#B0B7BE"

#let fork_svg = read("../img/fork.svg")
#let white_fork = fork_svg.replace("#323232", stroke_color)

#let pr_svg = read("../img/pr.svg")
#let white_pr = pr_svg.replace("#000000", stroke_color)

As some of you may have noticed in the *example image* of the _pull request_, *the repository of the pull request differs from the one in which we want to merge*. This is because the repository from which the pr comes is a _fork_ of the original repository.

A fork is a copy of a remote repository, usually on GitHub, that can be modified independently of the original repository. Forks are used to contribute to open source projects or to work on a copy of a project without affecting the original repository.
#footnote([
  On GitHub, repositories inherit the visibility of the original repository, but not the issues, pull requests. Also, if the original repository is deleted, the fork remains, with no link to the original repo.
])

---

Forking a repo is easy! In the #link("https://github.com/trending")[trending] section of GitHub, we can see the most popular projects of the moment. 

Take for example the project #link("https://github.com/rustdesk/rustdesk")[RustDesk]: _“An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer”_. To fork the project, just press the _Fork_ button in the upper right corner. 
#gh_button(white_fork, "Fork", fill_color, text_color, stroke_color, true)

The repository will be copied to your GitHub account. Similarly, you can propose changes made on one of your branches by clicking on the _Contribute_ button and then _Open pull request_ (find both on the main page of your fork). 
#gh_button(white_pr, "Contribute", fill_color, text_color, stroke_color, false)

