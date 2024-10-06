#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

#show ref: it => emph(text(blue)[#it])

= Git Advanced

== Git Clean

Il comando `git clean` è un comando distruttivo che, di norma, viene utilizzato per rimuovere i *file untracked*. I file eliminati dopo il suo utilizzo non saranno recuperabili tramite git; per questo necessita dell'opzione `-f` per essere eseguito.

Con questo comando è possibile combinare molteplici opzioni al fine di ottenere il risultato desiderato; di seguito al lista:

```bash
➜ git clean                 # Alone will always produce this output
    fatal: clean.requireForce is true and -f not given: refusing to clean
➜ git clean -n              # To preview files that will be deleted
➜ git clean --dry-run       # Same as -n
➜ git clean -d              # Remove untracked directories in addition to untracked files
➜ git clean -e  <expr>      # Exclude files matching the given pattern from being removed.
➜ git clean -X              # Remove only files ignored by Git.
➜ git clean -x              # Deletes all untracked files, including those ignored by Git.
➜ git clean -i              # Interactive Mode
➜ git clean -f              # Actually execute git clean
➜ git clean -ff             # Execute git clean recursively in sub-directories
➜ git clean -q              # Suppress the output
```

== Git Revert

Sempre rimanendo in tema di annullamenti, il comando `git revert` risulta particolarmente utile. Sostanzialmente ciò che fa questo comando è il contrario di `git diff`: ovvero, passato un commit come riferimento, le differenze apportate da questo verrano applicate all'inverso. Inoltre automaticamente verrà fatto un nuovo commit.

Uno dei vantaggi di `git revert` è il non riscrivere la storia, oltre al fatto di essere _safe_: è sempre possibile tornare al commit precedente e riprendere da lì, eliminando il commit di revert se inutile.

Come esempio prendiamo direttamente quello fornito da Atlassian sulla pagina dedicata a #link("https://www.atlassian.com/git/tutorials/undoing-changes/git-revert")[questo comando].
Riporto di seguito il codice per semplicità:

```bash
➜ git init .
Initialized empty Git repository in /git_revert_test/.git/
➜ touch demo_file
➜ git add demo_file
➜ git commit -am "initial commit"
[main (root-commit) 299b15f] initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 demo_file
➜ echo "initial content" >> demo_file
➜ git commit -am "add new content to demo file"
[main 3602d88] add new content to demo file
n 1 file changed, 1 insertion(+)
➜ echo "prepended line content" >> demo_file
➜ git commit -am "prepend content to demo file"
[main 86bb32e] prepend content to demo file
 1 file changed, 1 insertion(+)
```

Questa serie di comandi non dovrebbe sorprenderci; lo stato si presenta così:
\
\
\
#figure(
    align(center)[
        #scale(85%)[
            #set text(10pt)
            #diagram(
                node-stroke: .1em,
                node-fill: none,
                spacing: 4em,
                mark-scale: 50%,
                
                // main branch
                branch(
                    name:"main",
                    color:blue,
                    start:(0,0),
                    length: 3,
                    head:2,
                    commits: ("initial commit",
                              "add new content",
                              "prepend content")
                ),
            )
        ]
    ],
)<git-to-revert>

Proseguendo con i comandi suggeriti troviamo:

```bash
➜ git revert HEAD
[main b9cd081] Revert "prepend content to demo file" 1 file changed, 1 deletion(-)
```

Lanciando il comando probabilmente si aprirà l'editor che ci permette di modificare il messaggio di commit o lasciare quello di default. Il risultato comunque sarà:

\
\
\
#figure(
    align(center)[
        #scale(85%)[
            #set text(10pt)
            #diagram(
                node-stroke: .1em,
                node-fill: none,
                spacing: 4em,
                mark-scale: 50%,
                
                // main branch
                branch(
                    name:"main",
                    color:blue,
                    start:(0,0),
                    length: 4,
                    head:3,
                    commits: ("initial commit",
                              "add new content",
                              "prepend content",
                              "Revert \"prepend ...\"")
                ),
            )
        ]
    ],
)<git-reverted>

Il contenuto di demo_file è quindi:

```bash
➜ cat demo_file 
initial content
```

Le dirette conseguenze dei vantaggi elencati prima rendono questo metodo il migliore quando si lavora in team in quanto non si rende neccessario un `git push --force`.

== Git Reset

`Git Reset` è un comando alquanto articolato, come i precedenti riguarda l'annullamento dei cambiamenti e si basa sul concetto dei _three trees_ (working directory, staging index e commit history). 
Quello che fa', in generale è spostare l'HEAD al commit passato come argomento:

#figure(
    align(center)[
        #scale(85%)[
          #stack(
            dir:ltr,
            spacing:15%,
            [
              #set text(10pt)
              #diagram(
                  node-stroke: .1em,
                  node-fill: none,
                  spacing: 4em,
                  mark-scale: 50%,
                  
                  // main branch
                  branch(
                      name:"main",
                      color:blue,
                      start:(0,0),
                      length: 3,
                      head:2,
                      commits: ("","","")
                  ),
              )
            ],
            [
              #set text(10pt)
              #diagram(
                  node-stroke: .1em,
                  node-fill: none,
                  spacing: 4em,
                  mark-scale: 50%,
                  
                  // main branch
                  branch(
                      name:"main",
                      color:blue,
                      start:(0,0),
                      length: 3,
                      head:0,
                      commits: ("","","")
                  ),
              )
            ]
          )
        ]
    ],
)

Si presenta con tre principali opzioni differenti: `--soft`, `--mixed` (default) e `--hard`. Queste determinano il suo comportamento con i commit successivi a quello a cui abbiamo spostato l'HEAD.

- `git reset --soft <commit-hash>` metterà tutti i cambiamenti presenti nei commit successivi nello staged index. Questa opzione è molto utile per combinare in un solo commit tutti i cambiamenti degli ultimi n commit che non sono ancora stati pushati.

- `git reset --mixed <commit-hash>` salverà tutti quei cambiamenti come unstaged

- `git reset --hard <commit-hash>` scarterà tutti i cambiamenti apportati.#footnote([Il comando `git reset --hard`, senza argomenti eliminerà tutti i cambiamenti (sia staged che unstaged) attuali])

== Git RefLog

Lo strumento `git reflog` restituisce tutti i movimenti dell'HEAD nella repo locale, dunque in qualche modo rappresenta l'ultima possibilità di recuperare delle modifiche che abbiamo perso.

Se analizziamo la situazione dopo il revert: 

\
\
\
#figure(
    align(center)[
        #scale(85%)[
            #set text(10pt)
            #diagram(
                node-stroke: .1em,
                node-fill: none,
                spacing: 4em,
                mark-scale: 50%,
                
                // main branch
                branch(
                    name:"main",
                    color:blue,
                    start:(0,0),
                    length: 4,
                    head:3,
                    commits: ("initial commit",
                              "add new content",
                              "prepend content",
                              "Revert \"prepend ...\"")
                ),
            )
        ]
    ],
)

e qui supponiamo di sbagliarci e dare il comando: `git reset --hard HEAD~2` (invece che `HEAD~1`); possiamo cercare nell'output di `git reflog` il commit con messaggio: _"prepend content ..."_

#grid(
  columns:(2fr,5fr),
  column-gutter: 15%,
  [#scale(85%)[
    \
    \
    \
    #set text(10pt)
    #diagram(
        node-stroke: .1em,
        node-fill: none,
        spacing: 4em,
        mark-scale: 50%,
        
        // main branch
        branch(
            name:"main",
            color:blue,
            start:(0,0),
            length: 2,
            head:1,
            commits: ("initial commit",
                    "add new content",)
        ),
    )]
  ],
  [
    ```bash
    f0eb5e3 (HEAD -> main) HEAD@{0}: reset: moving to HEAD~2
    42fcfa5 HEAD@{1}: revert: Revert "prepend content to demo file"
    558d9f6 HEAD@{2}: commit: prepend content to demo file
    f0eb5e3 (HEAD -> main) HEAD@{3}: commit: add new content to demo file
    fd3f7bd HEAD@{4}: commit (initial): initial commit
    ```
  ]
)

Con un pizzico di fortuna, possiamo ottenere quindi l'hash del commit, che nel nostro caso è `558d9f6`.#footnote([Se si effettua un checkout su un commit non direttamente successivo rispetto al quello su cui si trova l'HEAD attualmente, si recuperano comunque i commit intermedi.])

== Interactive Staging

Git ci permette di fare uno staging interattivo @git-interactive-staging con il comando `git add -i` o `git add --interactive`. L'output che avremo sarà molto dettagliato riguardo i singoli files e il loro stato. Inoltre, sotto, avremo un menù con molteplici comandi:

```bash
➜ git add -i
           staged     unstaged path
  1:    unchanged        +0/-1 TODO
  2:    unchanged        +1/-1 index.html
  3:    unchanged        +5/-1 lib/simplegit.rb

*** Commands ***
  1: [s]tatus     2: [u]pdate      3: [r]evert     4: [a]dd untracked
  5: [p]atch      6: [d]iff        7: [q]uit       8: [h]elp
What now>
```

Da questo momento in poi avremo una shell interattiva, analizziamo quindi le opzioni:

- `status`: restituisce lo stato dei file, mostrando quante righe sono state aggiunte o rimosse.
- `update`: permette di portare i file nella staging area.
- `revert`: rimuove i file dalla staging area.
- `add untracked`: aggiunge i file non tracciati.
- `patch`: permette di fare uno staging parziale, lavorando su singole parti di un file.
- `diff`: mostra le differenze tra l'index e l'HEAD.

Ognuno di questi comandi può essere eseguito digitando il numero corrispondente del file. Per selezionare più file utilizzando una virgola o uno spazio come separatore. I file selezionati saranno preceduti da un asterisco nell'output successivo. Per confermare le modifiche ci basterà premere invio, tornando così al menù principale.

In alternativa possiamo utilizzare un asterisco ("\*") per selezionare tutti i file, ed in automatico verranno applicate le modifiche a tutti i file.

- `quit`: esce dalla shell interattiva.
- `help`: mostra i comandi disponibili e la descrizione.

== Avoid useless commits with Git Stash

Se avete mai scritto del codice con o senza git, vi sarete resi conto che spesso vorremmo sperimentare nuove idee o fare delle modifiche senza dover creare un commit per ogni singola modifica. Oppure in molti casi non abbiamo ancora abbastanza materiale per creare un commit, ma vogliamo comunque salvare il lavoro fatto finora. Per quello che abbiamo imparato, dovremmo fare un commit e poi utilizzare l'opzione `--amend` per editarlo con le nuove modifiche. In questi casi possiamo usare `git stash`. @git-stash-tutorial

L'operazione di stash seleziona *tutte le modifiche dei file tracciati ed i file nella staging area* e le salva su uno stack temporaneo. Questo ci farà tornare ad una working directory pulita, sincronizzata con l'HEAD e ci permette di ri-applicare le modifiche in un secondo momento. 

Come comando possiamo utilizzare `git stash push` (equivalente di `git stash` senza argomenti). Il 

== Squash

Spesso potremmo  aver fatto commit non necessari, o vorremmo avere un solo commit per la feature che stiamo sviluppando; in modo da avere una storia più pulita e comprensibile e delle PR che non contengono commit inutili. L'idea è di trasformare il flusso di lavoro visto in @workflow[Figura], in un flusso di lavoro simile:

#figure(
    align(center)[
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
                    commits:("",none,none,"","")),
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
    ], caption: [Workflow Diagram with squashed commits]
)<squashed-commits-workflow>

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

A questo punto salviamo e *chiudiamo la scheda*, ora il procedimento interattivo ci proporrà opzioni differenti in base alle scelte appena fatte. In questo caso apre il file il file `COMMIT_EDITMSG` ci chiede di scrivere il messaggio del commit che conterrà i 3 commit combinati. Si presenterà un file in una scheda di questo tipo:

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
L'ultima scheda che ci viene presentata è un riassunto del rebase interattivo che abbiamo appena compiuto, procediamo chiudendo anche quella.#footnote("Se non si vogliono i messaggi degli altri commit è sufficiente commentarli con `#`.")
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
                angle: 45deg,
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
                angle: 45deg,
                commits:(
                    "added multiple \n\"A\"",)
            ),
        )
    ]
]\
\

Fin'ora però abbiamo sempre lavorato su branch locali, come possiamo fare per i branch remoti?

- Se il branch non esiste nel remote repository su cui vogliamo pusharlo ed abbiamo i permessi basterà: `git push --set-upstream origin branch-name`.

- In modo simile, se il branch esiste ma non abbiamo pushato nessuno dei commit che vogliamo _squashare_ possiamo fare un `git push`.

- Se non abbiamo i permessi di pushare dovremmo fare una PR o forkare il repository e fare una PR dal nostro fork.

- Se abbiamo già pushato i commit che vogliamo _squashare_, dopo il rebase, ci troveremo con una situazione simile a questa:

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
            connect_nodes((1,0),(5,1),orange),
            branch(
                name:"add-letters",
                // remote:"origin",
                color:orange,
                start:(4,1),
                indicator-xy: (4.75,0.5),
                length: 1,
                head:0,
                alignment: bottom,
                commits:("added multiple \n\"B\"",)
            ),

            // remote add-letters branch
            connect_nodes((1,0),(2,2),green),
            branch(
                name:"my-fork/add-letters",
                color:green,
                start:(1,2),
                length: 3,
                alignment: bottom,
                commits: (
                    "added multiple \n\"A\"",
                    "removed all \n\"A\"",
                    "added multiple \n\"B\"")
            ),
        )
    ]
]\
\

Notiamo che il branch in remoto non si aggiorna in automaticamente. Se tentiamo di effettuare un `git push my-fork`, otterremo una cosa simile:

```bash
➜ git push my-fork    
To https://github.com/account/repo.git
 ! [rejected]        add-letters -> add-letters (non-fast-forward)
error: failed to push some refs to 'https://github.com/account/repo.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. If you want to integrate the remote changes,
hint: use 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Seguire i suggerimenti in questo caso non ci porterà da nessuna parte: per lo stesso motivo per cui il `push` non ha funzionato, non funzionerà nemmeno il comando: `git pull myfork add-letters`. Mostriamo comunque di seguito il procedimento suggerito da git:

```bash
➜ git pull my-fork add-lettersers             
From https://github.com/account/repo
 * branch            add-letters -> FETCH_HEAD
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint:
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
```

Se diamo i tre comandi consigliati e ritentiamo il pull, otterremo:

```bash
➜ git pull my-fork add-letters
From https://github.com/account/repo
 * branch            add-letters -> FETCH_HEAD
hint: Diverging branches can't be fast-forwarded, you need to either:
hint:
hint:   git merge --no-ff
hint:
hint: or:
hint:
hint:   git rebase
hint:
hint: Disable this message with "git config advice.diverging false"
fatal: Not possible to fast-forward, aborting.
```

Come abbiamo già visto in precedenza il merge produrrebbe un commit di merge, mentre il rebase aggiungerebbe uno dei due branch sopra all'altro; nessuna di queste soluzioni è quella che stiamo cercando.

In questo caso la soluzione più semplice e *rischiosa* è _riscrivere la storia_; ovvero utilizzare l'opzione `--force` di `git push`. Questo riscriverà completamente la storia della remote Repository e porterà il corrispondente branch remoto allo stesso commit di quello locale, ottenendo:  

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
            connect_nodes((1,0),(3,1),orange),
            branch(
                name:"add-letters",
                remote:"my-fork",
                color:orange,
                start:(2,1),
                indicator-xy: (4,1),
                length: 1,
                head:0,
                alignment: bottom,
                commits:("added multiple \n\"B\"",)
            ),

        )
    ]
]\
\

È importante notare che se altre persone stanno utilizzando quel branch remoto non potranno più pushare su quello stesso branch, se non forzando a loro volta e così via. Una soluzione più "sicura" sarebbe creare un branch locale e spostarsi su quello prima di effettuare il rebase. In questo modo, dopo il rebase, avremo:

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

            // local branch
            connect_nodes((1,0),(5,1),orange),
            branch(
                name:"local-branch",
                // remote:"origin",
                color:orange,
                start:(4,1),
                indicator-xy: (4.75,0.5),
                length: 1,
                head:0,
                alignment: bottom,
                commits:("added multiple \n\"B\"",)
            ),

            // remote add-letters branch
            connect_nodes((1,0),(2,2),green),
            branch(
                name:"add-letters",
                remote:"my-fork",
                color:green,
                start:(1,2),
                length: 3,
                alignment: bottom,
                commits: (
                    "added multiple \n\"A\"",
                    "removed all \n\"A\"",
                    "added multiple \n\"B\"")
            ),
        )
    ]
]\
\

Questo inoltre ci permette di mantenere i commit intermedi in caso di necessita: elimineremo il branch una volta che non ci serviranno più.


//TODO: Other merging strategies


//TODO: Cherry-pick
