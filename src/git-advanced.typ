#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, double_node, connect_nodes, branch

#show ref: it => emph(text(blue)[#it])

== Combinare i commit

Spesso potremmo  aver fatto commit non necessari, o vorremmo avere un solo commit per la feature che stiamo sviluppando; in modo da avere una storia più pulita e comprensibile e delle PR che non contengono commit inutili. L'idea è di trasformare il flusso di lavoro visto in @workflow[Figura], in un flusso di lavoro simile:

#align(center)[
    #scale(85%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            // master branch
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length: 7,
                commits: ("",none,none,none,none,none,"")),
            edge((7,0),(8,0),"--",stroke:2pt+blue),
            //... other commits
            
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                color:orange,
                start:(1,1),
                length:5,
                commits:("",none,none,"","","")),
            connect_nodes((6,1),(7,0),orange),

            // feature branch
            connect_nodes((2,1),(4,2),yellow),
            branch(
                name:"feature",
                color:yellow,
                start:(3,2)),
            connect_nodes((4,2), (5,1),yellow),

            // 2nd feature branch
            connect_nodes((2,1),(4,3),teal),
            branch(
                name:"2nd feature",
                color:teal,
                start:(3,3)),
            connect_nodes((4,3), (6,1),teal),
        )
    ]
]

In questi casi possiamo usare il comando `git rebase -i HEAD~n` dove `n` è il numero di commit che vogliamo combinare $(1,2,3 ...)$.

Quello che otterremo diperà dall'editor di testo che abbiamo configurato come predefinito, in ogni caso i passaggi sono sempre gli stessi. In questo caso usiamo `vscode` con l'estensioni: `git-lens` e `git-graph`.

Come situazione di partenza abbiamo il seguente log:
\
\
#align(center)[
    #scale(90%,x:85%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(name:"main",color:blue,start:(0,0)),

            // add-numbers branch
            connect_nodes((1,0),(2,0),yellow),
            branch(
                name:"add-numbers",
                indicator-xy:(5,0),
                color:yellow,
                start:(1,0),
                length:3,
                head: 2,
                commits: ("added 1","added 2","added 3")
            ),

            // add-letters branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"add-letters",
                color:orange,
                start:(1,1),
                length: 5,
                alignment: bottom,
                commits:(
                    "added one \"A\"",
                    "added another \"A\"",
                    "added 3rd \"A\"", 
                    "added \"A\"",
                    "5 \"A\" in 5 commits")
            ),           
        )
    ]
]\
\

Dall'ultimo commit del main abbiamo creato 2 branch distinti. Attualmente ci troviamo sull'ultimo commit del branch `add-numbers` e vogliamo combinare i 3 commit in un unico commit. Per farlo eseguiamo il comando: `git rebase -i HEAD~3` e ci troveremo davanti a qualcosa del genere: sul nostro editor:

#image("img/rebase-git-lens-1.png")

In generale per ogni commit possiamo scegliere se:
- `pick`: mantenere il commit
- `reword`: cambiare il messaggio del commit
- `edit`: fermarsi al commit per fare delle modifiche
- `squash`: combinare il commit con il precedente
- `drop`: eliminare il commit #footnote("Nota che questa opzione potrebbe causa conflitti di merge se uno dei commit successivi nel branch dipende dai cambiamenti del commit droppato.")
- `fixup`:

In questo caso vogliamo combinare i 3 commit in un unico commit, quindi averne uno solo che descriva l'aggiunta di 3 numeri.

#image("img/rebase-git-lens-2.png")

A questo punto salviamo e *chiudiamo la scheda*, ora il procedimento interattivo ci proporrà opzioni differenti in base alle scelte appena fatte. In questo caso ci chiede di scrivere il messaggio del commit che conterrà i 3 commit combinati. Si presenterà un file in una scheda di questo tipo:

```bash
added 1

# Please enter the commit message for your changes. Lines starting
# with '\#' will be ignored, and an empty message aborts the commit.
#
# Date:      Mon Sep 16 09:39:13 2024 +0200
#
# interactive rebase in progress; onto f3c8de5
# Last command done (1 command done):
#    reword 52ddcf4 added 1
# Next commands to do (2 remaining commands):
#    squash 6438329 added 2
#    squash aa86ec5 added 3
# You are currently editing a commit while rebasing branch 'add-numbers' on 'f3c8de5'.
#
# Changes to be committed:
#	modified:   README.md
#
```

Ora basta semplicemenete scrivere il messaggio che desideriamo eliminando il testo iniziale, salvare e chiudere la scheda.
L'ultima scheda che ci viene presentata è un riassunto del rebase interattivo che abbiamo appena compiuto, procediamo chiudendo anche quella.
Così facendo avremo completato il rebase e avremo un solo commit che descrive l'aggiunta di 3 numeri:


\
#align(center)[
    #scale(90%,x:85%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0)
            ),

            // add-numbers branch
            connect_nodes((1,0),(2,0),yellow),
            branch(
                name:"add-numbers",
                color:yellow,
                start:(1,0),
                indicator-xy: (2.75,0),
                length: 1,
                head:0,
                commits: ("added some\n numbers",),
                alignment: top
            ),

            // add-letters branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"add-letters",
                color:orange,
                start:(1,1),
                length: 5,
                alignment: bottom,
                commits:(
                    "added one \"A\"",
                    "added another \"A\"",
                    "added 3rd \"A\"", 
                    "added \"A\"",
                    "5 \"A\" in 5 commits")
            ),
        )
    ]
]\
\

Potremmo applicare lo stesso procedimento per il branch `add-letters` e combinare i 5 commit in un unico commit.

Dunque utilizziamo `git switch add-letters` e poi `git rebase -i HEAD~5`... alla fine del procedimento otterremo un log di questo tipo:

\
#align(center)[
    #scale(90%,x:85%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0)
            ),

            // add-numbers branch
            connect_nodes((1,0),(2,0),yellow),
            branch(
                name:"add-numbers",
                color:yellow,
                start:(1,0),
                indicator-xy: (2.75,0),
                length: 1,
                commits: ("added some\n numbers",),
                alignment: top
            ),

            // add-letters branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"add-letters",
                color:orange,
                start:(1,1),
                indicator-xy: (2.75,1),
                length: 1,
                head:0,
                alignment: bottom,
                commits:(
                    "added multiple \n\"A\"",)
            ),
        )
    ]
]\
\