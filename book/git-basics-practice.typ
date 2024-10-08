#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

= Pratica

== Configurare Git
Prima di iniziare a utilizzare Git, è importante configurare il proprio nome utente e l'indirizzo email, poiché questi saranno associati ai tuoi commit.

```bash
➜  git config --global user.name "name"
➜  git config --global user.email "your@email"
```

== Configurare gh

`gh` è il tool che utilizzeremo per interagire da CLI con GitHub, per configurare il nostro account utilizziamo:

```bash
➜  gh auth login
    ? What account do you want to log into? GitHub.com
    ? What is your preferred protocol for Git operations on this host? SSH
    ? Generate a new SSH key to add to your GitHub account? Yes
    ? Enter a passphrase for your new SSH key (Optional): 
    ? Title for your SSH key: GitHub CLI
    ? How would you like to authenticate GitHub CLI? Login with a web browser
    
    ! First copy your one-time code: A111-B222
    Press Enter to open github.com in your browser... 
    ✓ Authentication complete.
    - gh config set -h github.com git_protocol ssh
    ✓ Configured git protocol
    ✓ Uploaded the SSH key to your GitHub account: /home/path/to/.ssh/key.pub
    ✓ Logged in as GitHub-Username
```

== Inizializzare un nuovo repository <init-repo>

Per creare un nuovo progetto con Git, spostati nella directory del tuo progetto e inizializza un repository con il comando 
#footnote("Ignoriamo per ora l'output che verrà analizzato in seguito"): `git init`

Abbiamo crato così il repository locale, sul nostro computer. Come abbiamo visto nel capitolo precedente: @remote[Remote Repository], Git si basa sui concetti di *local* e *remote*. Dunque le modifiche effettuate in locale *non influiscono automaticamente* sul remote. 

Solitamente, per i progetti più piccoli, come quelli individuali o quello affrontato nel corso di Advanced Programming, il remote repository è uno solo e sarà hostato su *GitHub*.

Questo passaggio richiede l'aver già creato l'organizzazione alla quale apparterrà il repository. In alternativa è possibile crearla come personale e poi passare l'ownership.

1. Aprite la pagina: _“https://github.com/orgs/organization/repositories”_

2. Premete sul pulsante: #box(fill: rgb("#29903B"),inset: 7pt, baseline: 25%, radius: 4pt)[#text(stroke: white, font: "Noto Sans", size: 7pt, weight: "light",tracking: 0.5pt)[New Repository]]

3. Da qui in poi compilate i campi, scegliendo il nome, la visibilità e la descrizione della repo. Il file README.md si può aggiungere anche in seguito.

4. La pagina della repo ora ci consiglia gli step da seguire direttamente su CLI: "_… create a new repository on the command line_"

    ```bash
    echo "# title" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/orgs/organization/repository.git
    git push -u origin main
    ```
    

    Il primo comando crea un file chiamato README.md, se non esiste già e aggiunge la stringa "\# title" al suo contenuto. (Il simbolo "\#" in Markdown indica un titolo). Gli altri comandi verranno sviscerati nei prossimi capitoli, comunque, per una descrizione concisa:

    - `git init` lo abbiamo appena visto, inizializza un progetto di git in locale
    - `git add README.md` aggiunge il file `README.md` alla staging area
    - `git commit -m "first commit"` effettua il commit
    - `git branch -M main` imposta _main_ come branch principale
    - `git remote add origin ...` imposta la repository appena creata su GitHub come remote della nostra repository locale
    - `git push -u origin main` "pubblica" sul remote repository il commit che abbiamo appena effettuato.#footnote([Nota: `-u` è l'equivalente di `--set-upstream`, sostanzialmente imposta a quale remote il branch in locale dovrebbe pushare])
    
== Clonare un repository

Nel caso il progetto esista già è sufficiente: spostarci nella cartella e clonare il repository: `git clone <url-repository>`. In questo modo avremmo una copia del repository remoto sulla nostra macchina.

== Staging Area <stagin-area><git-add>

Per portare i file modificati dalla directory di lavoro all'area di staging, usiamo il comando `git add`. Generalmente si usa il comando `git add -A` o `git add .` per aggiungere tutti i file modificati all'area di staging. Tuttavia è possibile aggiungere i file uno alla volta con `git add <nomefile>`. Similmente possiamo aggiungre tutti i file che rispettano una Regex con `git add <regex>`; ad esempio: `git add Documentation/\*.txt`, aggiungerà tutti i file `.txt` presenti nella cartella `Documentation`.

== Difetti di Git

#grid(
    columns: (3fr,2fr), 
    
    [
        Durante lo sviluppo di git, sono state sviluppate diverse funzionalità molto utili e nel tempo sono state aggiunte quasi tutte al comando `git checkout`. Attualmente il team di Git, sta lavorando per separare queste funzionalità in comandi distinti.

        Allo stesso anche in altri casi troveremo comandi diversi che hanno lo stesso scopo. In questo documento vedremo entrambe le versioni per completezza; tuttavia è consigliabile utilizzare i comandi più recenti.

        Per dare subito un esempio di questo problema, analizziamo il caso in cui vogliamo vedere l'attuale stato in cui ci troviamo.
    ],
    figure(
        image("img/graphical-representation-git-checkout.png"), 
        caption: [Rappresentazione grafica del comando `git checkout`]
    )
)

== Analisi

Per visualizzare la lista dei file nella staging area e altre informazioni generiche, possiamo usare il comando:

```bash
➜ git status       
On branch main                                  # Current branch
No commits yet

Changes to be committed:                        # File in stage
(use "git rm --cached <file>..." to unstage)
    new file:   README.md                       # File added to stage (new file)
```

Questo è il caso in cui abbiamo appena creato il repository e aggiunto il file README.md.

Se invece abbiamo delle modifiche in stage ed altre che non lo sono, otterremo un output simile a questo:

```bash
➜ git status
On branch git-basics                                # The current branch
Your branch is up to date with 'origin/git-basics'. # Last commit is the same as the remote

Changes to be committed:                            # List of staged files
  (use "git restore --staged <file>..." to unstage)
        modified:   book/git-basics-theory.typ

Changes not staged for commit:                      # List of not staged files
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   book/git-basics-practice.typ

Untracked files:                                    # List of Untracked files
  (use "git add <file>..." to include in what will be committed)
        book/untracked-file.ops
```

In modo simile con `git checkout` possiamo avere un riassunto grossolano; in output vedremo solo i file modificati, senza ulteriori dettagli e non verranno mostrati i file *untracked*.

```bash
➜ git checkout
M       book/git-basics-practice.typ                 # Show only modified files
M       book/git-basics-theory.typ                   #
Your branch is up to date with 'origin/git-basics'. #
```

== Analisi delle Modifiche

Oltre allo stato per esaminare tutte le differenze tra i file dell'ultimo commit e gli attuali possiamo utilizzare il comando `git status -vv`, abbreviazione di `git status -v -v`. 
Alternativamente possiamo utilizzare `git diff @` dalla versione 1.8.5, o `git diff HEAD` per versioni precedenti.
#footnote([Nessuno dei due mostra il contenuto dei file *untracked*; `git stastus -vv` mostra solo che esistono])

Con `HEAD` si fa riferimento all'ultimo commit in cui ci troviamo.

Se abbiamo apportato modifiche a più file, risulterebbe molto utile avere un controllo granulare sulle differenze che vogliamo visualizzare:
  - Per visualizzare le modifiche apportate sul singolo file possiamo utilizzare il comando `git diff <nomefile>`.

  - Per visualizzare tutte le modifiche dei file in stage possiamo utilizzare `git diff --cached` (o il suo alias `--staged`). Altrimenti possiamo utilizzare `git status -v`.

  - Per visulizzare invece le modifiche le modifiche dei file che non sono in stage possiamo utilizzare `git diff`. #footnote([l'argomento `--no-index` è necessario se non siamo in un repository git])

== Commit

Una volta che aggiunti i file all'area di staging, possiamo creare un commit con il comando:

```bash
➜ git commit -m "Message describing changes made"
```

Il messaggio di commit dovrebbe essere chiaro e descrivere cosa hai fatto.

Se si vogliono aggiungere tutti i *file modificati* alla staging area e creare un commit in un solo comando, si può usare:

```bash
➜ git commit -am "Message describing changes made"
```

Se si vogliono aggiungere tutti i file, anche quelli untracked, non è possibile farlo in un solo comando. Si dovrà prima aggiungere i file all'area di staging con `git add -A` e poi creare il commit, seguendo l'iter classico.

=== Alias 

Spesso si utilizzano alias per abbreviare i comandi più lunghi, o combinare più comandi in uno solo. Per esempio, per creare un alias per aggiungere tutti i file in stage e quindi commitare anche i file untracked:

```bash
➜ git config --global alias.commit-all '!git add -A && git commit'

➜ git commit-all -m "MMessage describing changes made"
```

Per approfondire l'argomento degli alias, consigliamo di consultare la #link("https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases")[documentazione ufficiale di Git].

=== Amend

Attraverso il comando `git commit --amend` possiamo modificare l'ultimo commit che abbiamo effettuato. Questo ci permette sia di modificare il messaggio del commit, sia di aggiungere file che attualmente sono in stage al commit precedente; anziché creare un nuovo commit.

L'idea è quindi di trasformare una situazione come questa:

#align(center)[
    #scale(90%)[

        #v(5%)

        #set text(10pt)
        #diagram(
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

            edge((3,1),(4,1),"--",stroke:2pt+blue,label-pos:1,`some staged files`),
        )

        #v(5%)


    ]
]

In questa:


#align(center)[
    #scale(90%)[

        #v(5%)

        #diagram(
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
        )

        #v(5%)
    ]
]

Per _aggiungere_ file in stage al commit precedente, è sufficiente lanciare il comando `git add <file>` (se non abbiamo già i file interessati in staging area) e successivamente `git commit --amend`. A questo punto si presenterà il file di modifica del commit nel nostro editor predefinito, qui possiamo modificare il messaggio del commit, leggere i cambiamenti apportati. Una volta salvato il file e chiuso, il commit verrà modificato.

Se invece necessitiamo solo di _rinominare_ il commit, è sufficiente il comando `git commit --amend -m "changed message"` senza alcun file in staging area.

Ovviamente questo comando non è sfruttabile per _correggere_ commit già pushati su un repository remoto, vedremo come superare anche questo ostacolo nei successivi capitoli.

=== Co-author in commit

#grid(columns: 2, column-gutter: 1em, [Alcune piattaforme, come GitHub, permettono di aggiungere co-autori ai commit. Per farlo basta che il messaggio del commit sia formattato nel seguente modo:
],image("img/co-authored-commit.png"))

```bash
➜ git commit -m "Commit message
>
>
Co-authored-by: NAME <NAME@EXAMPLE.COM>
Co-authored-by: ANOTHER-NAME <ANOTHER-NAME@EXAMPLE.COM>"
```

Per ulteriori informazionei consultare la #link("https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors")[documentazione ufficiale di GitHub].

=== Visualizzare i commit

Per visualizzare la cronologia dei commit, si utilizza: `git log`. Questo mostrerà i commit con il loro hash, l'autore, la data e il messaggio. Puoi anche usare opzioni come `--oneline` per una visualizzazione più compatta.

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

== Branch

Le opzioni e operazioni sui branch sono moltissime, di seguito elenchiamo le più utili.

=== Creare un Nuovo Branch

Per creare un nuovo branch, possiamo usare il comando: `git switch -c <new-branch> [<start-point>]`.
#footnote([Con `[start-point]` s'intente l'hash commit da cui partire; le parentesi quadre indicano che è opzionale.])
Questo comando crea un nuovo branch e ci sposta su di esso. Alternativamente possiamo usare i comandi: `git checkout -b <new_branch> [<start_point>]` o `git branch <new_branch> [<start_point>]`.
#footnote([L'ultima opzione non ci sposterà automaticamente sul nuovo branch])

=== Rinominare un Branch

Riprendendo subito il suggerimento ricevuto da GitHub nella @init-repo[Sezione] il comando: `git branch -M main` è opzionale, semplicemenete rinomina il branch principale come _main_ che lasciarlo a _master_; sta a voi scegliere se lanciare questo comando rinominandolo. Lo stesso comando può essere usato per rinominare un branch qualsiasi.

=== Eliminare un Branch in Locale

Per eliminare un branch, possiamo usare il comando: `git branch -d <branch-name>`.
#footnote([Per forzare l'eliminazione di un branch, utilizzare l'opzione `-D` al posto di `-d`. Questa opzione elimina il branch a prescindere dallo stato.])

=== Spostarsi tra Branch

Per spostarsi su un branch diverso, è sufficiente usare il comando: `git switch <branch-name>` o `git checkout <branch-name>`. 

Prima di proseguire con la spiegazione, è importante capire meglio concetto di HEAD. L'_HEAD_ è un *puntatore* che punta al commit attuale e consecutivamente il contenuto della working directory.
Nei grafici che seguono, l'HEAD è rappresentata dal commit con il cerchio completamente riempito.

Dunque, ciò che otteniamo è che l'HEAD si sposterà sul commit relativo al branch selezionato; per esempio ci troviamo sul branch _main_ e volessimo spostarci sul branch _develop_, il comando sarebbe: `git switch develop` o `git checkout develop`.

Visivamente il cambiamento sarebbe questo:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length:5,
                head:4
                ),
            // edge((5,0),(6,0),"--",stroke:2pt+blue),
            // //... other commits
            
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                indicator-xy:(7,1),
                color:orange,
                start:(1,1),
                length:5,
            )            
        )

        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch(
                name:"main",
                color:blue,
                start:(0,0),
                length:5
            ),
            // develop branch
            connect_nodes((1,0),(2,1),orange),
            branch(
                name:"develop",
                indicator-xy:(7,1),
                color:orange,
                start:(1,1),
                length:5,
                head:4
            )            
        )
    ]
]

=== Spostarsi tra Commit

In modo analogo, possiamo spostarci su un commit specifico con il comando: `git switch <commit-hash>` o `git checkout <commit-hash>`. Questo comando ci permette di spostare l'HEAD su un commit specifico, tuttavia ci troveremo in uno stato chiamato _detached HEAD_.

Il detached HEAD è uno stato in cui l'HEAD non punta a nessun branch, ma direttamente ad un commit. Questo significa che se creiamo un nuovo commit in questo stato, non verrà aggiunto a nessun branch e potrebbe essere perso.
#footnote([Ogni repository ha la sua HEAD, anche i remote. Il commit a cui punta la HEAD nei remote è l'ultimo commit del branch principale (generalmente _main_); ed è anche quello che si vede nella pagina web della repository])

Una rappresentazione visiva di questo stato è la seguente:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch( // main branch
                name:"main",
                color:blue,
                start:(0,1),
                length:5,
            ),

            connect_nodes((3,1),(4,2),orange),
            branch( // develop branch
                name:"develop",
                color:orange,
                start:(3,2),
                length:5,
            ),

            connect_nodes((3,0),(2,1),red),
            branch(// detached HEAD commits
                color: red, 
                start:(2,0),
                length:3,
                head:2,
            )
        )
    ]
]

=== Spostare un Branch ad un commit specifico

Fin'ora abbiamo sempre immaginato un branch come un come un'intera linea di commit, in realtà un branch non è altro che una label associata ad un commit specifico. Proprio per questo possiamo spostare un branch ad un altro commit con il comando `git branch --force <branch-name> [<new-tip-commit>]`.

Per questo motivo alcuni grafici o alcuni plugin rappresentano, non solo ogni branch con colore diverso, ma anche la label del branch vicino al commit stesso. Per esempio, il grafico che abbiamo appena visto potrebbe essere rappresentato come:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
            branch( // main branch
                name:"main",
                indicator-xy:(5.5,1),
                color:blue,
                start:(0,1),
                length:5,
            ),

            connect_nodes((3,1),(4,2),orange),
            branch( // develop branch
                name:"develop",
                indicator-xy:(7.75,1.5),
                color:orange,
                start:(3,2),
                length:5,
            ),

            connect_nodes((3,0),(2,1),red),
            branch(// detached HEAD commits
                color: red, 
                start:(2,0),
                length:3,
                head:2,
            )
        )
    ]
]

== Merge

Per combinare le funzionalità implementate in 2 branch diversi, esistono diverse tecniche; in questa sezione copriremo solo il metodo di merge, in quanto è il più _sicuro_ e _semplice_.

Nel capitolo riguardante la teoria, abbiamo visto il workflow (@workflow[Figure]) che vogliamo ottenere. Ci sono diverse situazioni in cui ci possiamo trovare: se il branch che vogliamo unire non ha subito modifiche durante lo sviluppo della nostra feature, il merge sarà detto _fast-forward_.
#footnote([Si presuppone che l'etichetta del branch `main` sia sempre sull'ultimo commit _blu_. Ogni plug-in o rappresentazione grafica rappresenta i branch in maniera leggermente differente])

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

In situazioni simili siamo sicuri che non si presenteranno conflitti di merge, e questo potrà avvenire con i comandi: `git switch main`, seguito da `git merge feature`. Così facendo otterremo un albero simile a questo:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

Cosa accadrebbe se invece ci fossero stati dei commit sul main durante lo sviluppo della feature a cui siamo interessati?

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

Il grafico si presenterebbe in questo modo: il branch _main_ ha subito delle modifiche e per evidenziare che la _feature 1_ è stata integrata nel _main_ abbiamo utilizzato lo stesso colore blu ma con il collegamento dei nodi diverso per evidenziare l'inizio dei commit appartenenti alla _feature 1_.

Per capire meglio la situazione, possiamo anche ridisegnare il grafico nel seguente modo, dove le etichette dei branch sono allineate con il commit su cui si trovano:
#footnote([Questa rappresentazione è simile a quella del plug-in per VS-Code Git Graph che raccomandiamo])

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

In questo caso non possiamo sapere a priori se ci saranno o meno conflitti di merge.

Per unire i due branch, come prima, possiamo usare i comandi: `git switch main`, seguito da `git merge feature-2`. In questo caso, se ci sono conflitti di merge, ci verranno notificati sul terminale e dovremo risolverli manualmente.

Come esempio, ho utilizzato una stringa diversa sulla stessa linea del file README.md in due branch diversi. Il risultato quando si tenta di fare il merge del secondo branch è il seguente:

```bash
➜ git merge feature-2
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

A seconda dell'editor che utilizziamo i file contenenti i conflitti saranno o meno evidenziati. Comunque ogni file con conflitto all'apertura mostrerà qualcosa di simile:

#align(center)[
    #image("/book/img/file-with-merge-conflicts.png")
]

A questo punto non ci rimane che rimuovere il cambiamento che non vogliamo mantenere o in alternativa combinare entrambi. Proseguiamo salvando il file, chiudendolo e assicurandoci che sia nella staging area con il comando: `git add ...`. Ora possiamo lanciare il comando `git commit` (che assegnerà il messaggio di default: _"Merge branch feature-2"_). Ora il nostro albero sarà:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

È importante notare diverse cose:

- Il branch _feature-2_ non è stato eliminato ed è ancora al suo ultimo commit.
- Anche il branch _feature-1_ è ancora al suo ultimo commit.
- Per entrambi i branch _feature_ si tratta di un "merge _fast-forward_": infatti se ci spostiamo su uno dei due e diamo il comando `git merge main` non avremo conflitti di alcun tipo. Se lo facciamo per entrambi otterremo:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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
                alignment: bottom
            ),
            branch_indicator("feature 1", (6.75,0), blue),
            branch_indicator("feature 2", (6.75,-0.5), blue),        

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

== Gestione dei Remote Repository

Finora abbiamo lavorato solo sul repository locale, affrontando gli scenari senza considerare il remote repository. In questo capitolo sopperiremo a questa mancanza.

=== Analisi

Per avere informazioni sui remote possiamo servirci di diversi comandi:

```bash
➜ git remote show              #show the name of all remotes
    origin
➜ git remote show origin       #show info about one remote
    * remote origin
    Fetch URL: https://github.com/nome-organizzazione/nome-repo.git
    Push  URL: https://github.com/nome-organizzazione/nome-repo.git
    HEAD branch: (unknown)
➜ git remote -v                #show info about all remotes
    origin	https://github.com/nome-organizzazione/nome-repo.git (fetch)
    origin	https://github.com/nome-organizzazione/nome-repo.git (push)
```


Come si può intuire il comando suggerito da GitHub: `git remote add origin URL`, (visto nella @init-repo[Sezione]) aggiungerà l'URL come repository remote, con il nome *origin*. 

=== Aggiornamento con git fetch

Il comando `git fetch` scarica nuovi commit, branches e tags dai remote repository e ci permette così di confrontare le informazioni ricevute con la nostra repo locale. Tutto questo viene performato senza applicare le modifiche ai nostri branch in locale.

In particolare il comando ha questa sintassi: `git fetch <remote> <refspec>`. Se lanciato senza argomenti potrebbe non aggiornare tutti i remote (o quello che ci interessa). Per sapere quali remote coinvolge l'operazione di fetch è sufficiente il comando:

```bash
➜  git fetch -v
    POST git-upload-pack (186 bytes)
    From https://github.com/Owner/repo
     = [up to date]      main         -> origin/main
     = [up to date]      feature-1    -> origin/feature-1
     = [up to date]      feature-2    -> origin/feature-2
```

Di default, git utilizza _origin_ come remote, quindi per esempio se avvessimo un remote, come quello rappresentato qui; il comando non funzionerebbe:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // origin main branch
                name:"main",
                remote: "my-fork",
                indicator-xy: (4.75,0.5),
                color:blue,
                start:(0,1),
                length:5,
                head: 4,
            ),
        )
    ]
]

Ci sono diverse soluzioni che potremmo adottare:

- Ovviamente usare il comando specifico: `git fetch my-fork`
- Applicare il fetch a tutti i remote: `git fetch --all`
- Impostare il remote che ci interessa come default. Questo è possibile farlo sia modificando il file in `.git/config`, sia con il comando

=== Operazioni di Push e Pull

Le operazioni di push e pull sono fondamentali per mantenere sincronizzati i repository locali e remoti. Come si evince dal nome stesso del comando, `git push` invia le modifiche locali al repository remoto, mentre `git pull` scarica le modifiche dal repository remoto.

Per identificare l'appartenenza di un branch ad un repository remoto nella label del branch useremo la notazione _remote/branch_:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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
            ),

            // origin/main indicator
            branch_indicator("origin/main", (3.75,0.5), blue),

        )
    ]
]

Nel caso appena presentato, il branch _main_ nella repository locale è "più avanti" rispetto a quello della repository remota. Per sincronizzare i due branch, dunque, dovremo fare un _push_.

Una volta lanciato il comando `git push origin main`, se tutto va a buon fine, il risultato sarà:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // main branch
                name:"main",
                remote: "orgin",
                indicator-xy: (6.75,0.5),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
            ),
        )
    ]
]

Come potete osservare usiamo questa label speciale per indicare che il branch in locale è allineato con quello remoto.

In un caso simile, invece, è utile spostarsi sul branch main ed effettuare un _pull_: stiamo sviluppando la nostra feature e qualcuno ha pushato sul branch main in remoto.

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch_indicator("main", (3.75,0.5), blue),

            branch( // main branch
                name:"main/origin",
                indicator-xy: (6.8,0.5),
                color:blue,
                start:(0,1),
                length:7,
                head: 6,
            ),

            //other branch stuff
            connect_nodes((3,1),(4,2),teal),
            branch( // old branch
                name:"feature",
                indicator-xy: (6,2.5),
                color: teal,
                start: (3,2),
                length: 3,
            ),
        )
    ]
]

Ci sono molte altre opzioni applicabili ai comandi `git push` e `git pull`, oltre a `-u` che abbiamo visto nei capitoli precedenti; come: `--force` e `--force-with-lease` vi consigliamo a leggere la documentazione ufficiale@git-docs prima di utilizzarle.

=== Pull Request

Le Pull Request (PR) sono lo strumento con cui applichiamo modifiche in repository su cui non abbiamo permessi. Sono largamente utilizzate da parte della community e supportate da GitHub, Git Lab (Merge Request) e BitBucket.

Le PR permettono di sottoporre le features sviluppate ai maintainers del progetto originale, queste saranno visibili a tutta l'organizzazione (se privata, o in alternativa a tutti). Successivamente può essere accettata, rifiutata o soggetta ad aggiustamenti.
#footnote([Su GitHub le PR non possono essere eliminate se non contattando l'assistenza di GitHub stesso.])
Alla stregua di un merge anche le PR possono avere dei conflitti, che devono essere risolti al fine di integrare le features desiderate.

È possibile creare le Pull Requests sia attraverso l'interfaccia web (per ogni repo di GitHub abbiamo la sezione in alto dedicata), sia via CLI. Di seguito un esempio di PR via CLI con il comando gh:
#footnote([Se ancora non è stato fatto, prima di procedere è necessario il login tramite `gh` e l'impostazione del repo di default con il comando interattivo `gh repo set-default`])

```bash
➜ gh pr create                                                                               
? Where should we push the 'feature-1' branch?  [Use arrows to move, type to filter]
> Username/project
  Skip pushing the branch
  Cancel
```

Una Pull Request è generalmente composta da: titolo, body (descrizione dettagliata), lista di commits. Di seguito il comando che abbiamo dato chi chiede appunto le prime due informazioni: 

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

Ad una PR sono inoltre associate delle etichette, personalizzate a seconda della repo,  i reviewers richiesti, i quali possono essere modificati, ed i commenti della community.


Vediamo ora un caso completo:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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

In questa situazione abbiamo sviluppato due features differenti, mergiato la _feature-2_ in locale e pushato sul fork. Successivamente abbiamo completato la _feature-1_ e la abbiamo mergiata.

A questo punto applichiamo tutto quello che abbiamo visto in questo capitolo: spostandoci sul branch _main_ effettuiamo un push verso il nostro fork con il comando: `git push my-fork`. 

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch_indicator("origin/main", (0.75,0.5), blue),
            branch( // main branch
                name:"main",
                remote:"my-fork",
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

A questo punto possiamo procedere con la nostra PR, scegliendo com'è comune di rimanere sul nostro branch _main_ quando lanciamo il comando `gh pr create`; in questo modo la PR verrà proprio da quello.
#footnote([Non è possibile avere più PR aperte provenienti dallo stesso branch dello stesso fork.])

Una volta che la richiesta verrà accettata, possiamo lanciare il comando `git fetch origin` per conoscere le modifiche più recenti sul remote origin e ci troveremo in questo stato:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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
                commits:("",none,none,none,none,none,"merge pr")
            ),

            connect_nodes((1,-1),(2,1),blue),
            branch( // main branch
                name:"main",
                remote:"my-fork",
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

Questo tipo di grafico è normalissimo, se lo analizziamo, notiamo che _origin/main_ ha come primo commit l'ultimo commit in comune e come ultimo commit quello di merge. Fortunatamente per noi i maintainer del progetto per accettare la PR hanno dovuto performare questo merge. Ora non ci rimane che sincronizzare il nostro fork e la nostra repository locale.

Sia l'interfaccia web che il tool gh permettono di sincronizzare un branch del nostro fork con la versione più recente del remote originale. Il comando per farlo è: `gh repo sync owner/cli-fork -b BRANCH-NAME`@gh-sync. Nel nostro caso il `BRANCH-NAME` sarà ovviamente _main_. 

Per proseguire l'esempio un passo alla volta ed accertarci che tutto sia andato come ci aspettavamo, possiamo lanciare nuovamente `git fetch`:

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
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
                commits:("",none,none,none,none,none,"merge pr")
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

Se tutto è andato come ci aspettiamo l'ultima cosa rimasta da fare è aggiornare il branch _main_ in locale con `git pull` se ci siamo sopra, altrimenti specificando branch e remote.

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"main",
                remote:("origin","my-fork"),
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-0.75),
                length:7,
                head: 6,
                commits:("",none,none,none,none,none,"merge pr")
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

=== Rimuovere i branch remoti

Riprendendo l'esempio precedente, per pulire tutto, vorremmo elimnare i branch delle features che abbiamo utilizzato in precedenza. Supponiamo di aver pushato _feature-2_ in precedenza; la situazione che si presenta è questa:
#footnote([Se invece un branch, creato da altri, quindi di cui non abbiamo la copia in locale, viene eliminato direttamente nel remote, basterà eseguire `git fetch --all --prune`])

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"main",
                remote:("origin","my-fork"),
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-0.75),
                length:7,
                head:6,
                commits:("",none,none,none,none,none,"merge pr")
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
              remote:("my-fork"),
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

Per prima cosa ci spostiamo su un branch locale diverso da quelli che vogliamo eliminare. Per eliminare il branch in remoto diamo il comando `git push my-fork -d feature-2 ` e subito dopo per elimnarlo in locale possiamo dare `git branch -d feature-1 feature-2`. Per concludere possiamo lanciare il comando `git fetch --all`.

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,

            branch( // remote origin
                name:"main",
                remote:("origin","my-fork"),
                indicator-xy: (6,-0.5),
                color:lime,
                start:(0,-0.75),
                length:7,
                commits:("",none,none,none,none,none,"merge pr")
            ),

            connect_nodes((1,-0.75),(2,1),blue),
            branch( // main branch
                name:"",
                indicator-xy: (5.75,0.5),
                color:blue,
                start:(1,1),
                length:5,
                head: 4,
                commits:("","",none,"","")
            ),
            connect_nodes((6,1),(7,-0.75),blue,bend:-25deg),

            //orange branch
            connect_nodes((3.5,0),(3,1),orange),
            branch(
              name: "",
              indicator-xy: (5,0),
              color: orange,
              start: (2.5,0),
              length:2
            ),
            connect_nodes((5,1),(4.5,0),orange),
            
            //teal branch
            connect_nodes((2,1),(3,2),teal),
            branch(
                name:"",
                indicator-xy: (6,1.5),
                color: teal,
                start: (2,2),
                length: 3,
            ),
            connect_nodes((5,2),(6,1),teal),
        )
    ]
]