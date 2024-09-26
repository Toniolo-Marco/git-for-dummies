#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, commit_node, connect_nodes, branch

= Pratica

== Configurare Git
Prima di iniziare a utilizzare Git, è importante configurare il proprio nome utente e l'indirizzo email, poiché questi saranno associati ai tuoi commit.

```bash
git config --global user.name "name"
git config --global user.email "your@email"
```

== Inizializzare un nuovo repository <init-repo>

Per creare un nuovo progetto con Git, spostati nella directory del tuo progetto e inizializza un repository con il comando 
#footnote("Ignoriamo per ora l'output che verrà analizzato in seguito"):

```bash
git init
```

Abbiamo crato così il repository locale, sul nostro computer. Come abbiamo visto nel capitolo precedente: @remote[Remote Repository], Git si basa sui concetti di *local* e *remote*. Dunque le modifiche effettuate in locale *non influiscono automaticamente* sul remote. 

Solitamente, per i progetti più piccoli, come quelli individuali o quello affrontato nel corso di Advanced Programming, il remote repository è uno solo e sarà hostato su *GitHub*.

Questo passaggio richiede l'aver già creato l'organizzazione alla quale apparterrà il repository. In alternativa è possibile crearla come personale e poi passare l'ownership.

1. Aprite la pagina: _"https://github.com/orgs/nome-organizzazione/repositories"_

2. Premete sul pulsante: #box(fill: rgb("#29903B"),inset: 7pt, baseline: 25%, radius: 4pt)[#text(stroke: white, font: "Segoe UI Variable Static Display", size: 7pt, weight: "thin",tracking: 0.5pt)[New Repository]]

3. Da qui in poi compilate i campi, scegliendo il nome, la visibilità e la descrizione della repo. Il file README.md si può aggiungere anche in seguito.

4. La pagina della repo ora ci consiglia gli step da seguire direttamente su CLI: "_… create a new repository on the command line_"

    ```bash
    echo "# title" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/Advanced-Programming-2023/test.git
    git push -u origin main
    ```
    

    Il primo comando crea un file chiamato README.md, se non esiste già e aggiunge la stringa "\# title" al suo contenuto. (Il simbolo "\#" in Markdown indica un titolo). Gli altri comandi verranno spiegati nei prossimi capitoli.

== Clonare un repository

Nel caso il progetto esista già è sufficiente: spostarci nella cartella e clonare il repository: `git clone <url-repository>`. In questo modo avremmo una copia del repository remoto sulla nostra macchina.

== Staging Area <stagin-area><git-add>

Per portare i file modificati dalla directory di lavoro all'area di staging, usiamo il comando `git add`. Generalmente si usa il comando `git add -A` o `git add .` per aggiungere tutti i file modificati all'area di staging. Tuttavia è possibile aggiungere i file uno alla volta con `git add <nomefile>`. Similmente possiamo aggiungre tutti i file che rispettano una Regex con `git add <regex>`; ad esempio: `git add Documentation/\*.txt`, aggiungerà tutti i file `.txt` presenti nella cartella `Documentation`.

== Difetti di Git

#grid(
    columns: (3fr,2fr), 
    
    [
        Durante lo sviluppo di git, sono sviluppate diverse funzionalità molto utili e nel tempo sono state aggiunte quasi tutte al comando `git checkout`. Attualmente il team di Git, sta lavorando per separare queste funzionalità in comandi distinti.

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
        modified:   src/git-basics-theory.typ

Changes not staged for commit:                      # List of not staged files
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   src/git-basics-practice.typ

Untracked files:                                    # List of Untracked files
  (use "git add <file>..." to include in what will be committed)
        src/untracked-file.ops
```

In modo simile con `git checkout` possiamo avere un riassunto grossolano; in output vedremo solo i file modificati, senza ulteriori dettagli e non verranno mostrati i file *untracked*.

```bash
➜ git checkout
M       src/git-basics-practice.typ                 # Show only modified files
M       src/git-basics-theory.typ                   #
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
git commit -m "Messaggio descrittivo delle modifiche"
```

Se si vogliono aggiungere tutti i file modificati alla staging area e creare un commit in un solo comando, si può usare:

```bash
git commit -am "Messaggio descrittivo delle modifiche"
```

Se si vogliono aggiungere tutti i file, anche quelli untracked, non è possibile farlo in un solo comando. Si dovrà prima aggiungere i file all'area di staging con `git add -A` e poi creare il commit, seguendo l'iter classico.

=== Alias 

Spesso si utilizzano alias per abbreviare i comandi più lunghi, o combinare più comandi in uno solo. Per esempio, per creare un alias per aggiungere tutti i file in stage e quindi commitare anche i file untracked:

```bash
git config --global alias.commit-all '!git add -A && git commit'

git commit-all -m "Messaggio descrittivo delle modifiche"
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
git commit -m "Commit message
>
>
Co-authored-by: NAME <NAME@EXAMPLE.COM>
Co-authored-by: ANOTHER-NAME <ANOTHER-NAME@EXAMPLE.COM>"
```

Per ulteriori informazionei consultare la #link("https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors")[documentazione ufficiale di GitHub].

== Branch

Le opzioni e operazioni sui branch sono moltissime, di seguito elenchiamo le più utili.

=== Creare un Nuovo Branch

Per creare un nuovo branch, possiamo usare il comando: `git switch -c <new-branch> [<start-point>]`.
#footnote([Con `[start-point]` s'intente l'hash commit da cui partire; le parentesi quadre indicano che è opzionale.])
Questo comando crea un nuovo branch e ci sposta su di esso. Alternativamente possiamo usare i comandi: `git checkout -b <new_branch> [<start_point>]` o `git branch <new_branch> [<start_point>]`.
#footnote([L'ultima opzione non ci sposterà automaticamente sul nuovo branch])

=== Rinominare un Branch

Riprendendo subito il suggerimento ricevuto da GitHub nella @init-repo[Sezione] il comando: `git branch -M main` è opzionale, semplicemenete rinomina il branch principale come _main_ che lasciarlo a _master_; sta a voi scegliere se lanciare questo comando rinominandolo. Lo stesso comando può essere usato per rinominare un branch qualsiasi.

=== Eliminare un Branch

Per eliminare un branch, possiamo usare il comando: `git branch -d <branch-name>`.
#footnote([Per forzare l'eliminazione di un branch, utilizzare l'opzione `-D` al posto di `-d`])

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
                length:5),

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
            )
        )
    ]
]

== Unire due branch

In questa sezione copriremo solo il metodo di merge, in quanto è il più sicuro e veloce.


== Gestione dei Remote Repository

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








Il messaggio di commit dovrebbe essere chiaro e descrivere cosa hai fatto.

7. Visualizzare la cronologia dei commit
Per visualizzare la cronologia dei commit, utilizza:

```bash
git log
```

Questo mostrerà i commit con il loro hash, l'autore, la data e il messaggio. Puoi anche usare opzioni come `--oneline` per una visualizzazione più compatta:

```bash
git log --oneline
```

== Creare un branch

Dopo aver dato il comando:

```bash
git init
```
All'incirca questo è l'output che dovresti ottenere: qui git suggerisce di impostare, il nome di default del branch iniziale. Come leggiamo i nomi più comuni sono _main_ e _master_

```bash
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint: 	git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint: 	git branch -m <name>
```


I branch sono utilizzati per lavorare su funzionalità diverse o bugfix separati dal ramo principale (`main` o `master`).

```bash
git branch <nome-branch>
```



9. Spostarsi su un branch
Per passare a un branch diverso, usa il comando:

```bash
git checkout <nome-branch>
```

10. Creare e passare a un nuovo branch
Se vuoi creare un nuovo branch e passare immediatamente a esso:

```bash
git checkout -b <nome-branch>
```

11. Unire un branch
Dopo aver completato il lavoro su un branch, puoi unire le modifiche nel branch principale (ad es. `main` o `master`):

1. Prima, assicurati di essere sul branch principale:
   
    ```bash
    git checkout main
    ```

2. Poi, unisci le modifiche dal branch secondario:

    ```bash
    git merge <nome-branch>
    ```

12. Rimuovere un branch
Dopo aver unito un branch, puoi rimuoverlo:

```bash
git branch -d <nome-branch>
```

13. Aggiornare il repository locale (pull)
Per scaricare le modifiche da un repository remoto (ad esempio, su GitHub):

```bash
git pull
```

Questo comando recupera e unisce le modifiche dal repository remoto a quello locale.

14. Inviare modifiche al repository remoto (push)
Per inviare le tue modifiche al repository remoto:

```bash
git push origin <nome-branch>
```

Assicurati di aver prima configurato un repository remoto con:

```bash
git remote add origin <url-repository>
```

15. Gestire i conflitti di merge
Se ci sono conflitti durante l'unione di due branch, Git ti avviserà. Dovrai risolvere manualmente i conflitti nei file interessati, quindi eseguire:

```bash
git add <file-risolto>
git commit
```

16. Annullare modifiche
1. Annullare modifiche non aggiunte all'area di staging:

    ```bash
    git checkout -- <nomefile>
    ```

2. Rimuovere un file dall'area di staging senza perdere le modifiche:

    ```bash
    git reset <nomefile>
    ```

3. Annullare un commit precedente (lasciando le modifiche nel working directory):

    ```bash
    git reset --soft HEAD^
    ```

4. Ripristinare un commit (attenzione, può essere distruttivo):

    ```bash
    git reset --hard <hash-commit>
    ```

17. Controllare differenze (diff)
Per vedere le differenze tra le modifiche non ancora messe in staging:

```bash
git diff
```

Se vuoi vedere le differenze tra il tuo branch attuale e un altro branch:

```bash
git diff <altro-branch>
```

18. Taggare un commit
Per creare un tag su un commit specifico, ad esempio per versionare una release:

```bash
git tag -a v1.0 -m "Versione 1.0"
git push origin --tags
```

19. Cancellare un commit dalla cronologia (reflog)
Se hai bisogno di recuperare un commit cancellato o navigare nella cronologia delle operazioni, puoi usare:

```bash
git reflog
```