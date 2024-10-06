#import "@preview/touying:0.5.2": *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.1" as fletcher: node, edge
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#slide(repeat: 2, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  #only("1")[
  You can create Pull Requests either through the web interface (for each GitHub repo we have the dedicated section above) or via CLI:
  
  ```bash
  ➜ gh pr create                                                                               
  ? Where should we push the 'feature-1' branch?  [Use arrows to move, type to filter]
  > Username/project
    Skip pushing the branch
    Cancel
  ```
  ]

  #only("2")[
  
  As we said before, a Pull Request generally consists of: title, body (detailed description), list of commits. Below is the command we gave who precisely asks for the first two pieces of information: 
  
  
  ```bash
  Creating pull request for Username:feature-1 into main in Official-Owner/project
  
  ? Title implemented feature-1 stuff
  ? Body <Received>
  ? What's next? Submit
  remote: 
  remote: 
  To https://github.com/Username/project.git
   * [new branch]      HEAD -> feature-1
  branch 'feature-1' set up to track 'my-fork/feature-1'.
  https://github.com/Official-Owner/project/pull/1
  ```

  Also associated with a PR, there are labels, customized according to the repo, required reviewers, which can be edited, and community comments.
  
  ]
])
