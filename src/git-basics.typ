#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes

#let branch_indicator(name, start, end, color) = {
    edge(start, end,"->", label: name, label-pos: 0.25, stroke: 2pt+color)
}

#let double_node(position, color, out_radius, inner_radius) = {
    node(position, "", radius: out_radius, stroke: color,extrude: 0, outset: 0.099em)
    node(position, "", radius: inner_radius, fill: color, stroke: none)
}

#let branch(name,color,start,nodes_number,nodes_out_radius,nodes_inner_radius) = {
    branch_indicator(name, start, (start.at(0) + 1,start.at(1)), color)

    let x = start.at(0) + 1 // x node coordinate
    let i = 0
    while i < nodes_number {
        double_node((x,start.at(1)),color,nodes_out_radius,nodes_inner_radius)

        if i < nodes_number - 1 {
            edge((x,start.at(1)), (x+1,start.at(1)), stroke: 2pt+color)
        }

        i = i + 1
        x = x + 1
    }
}

#let connect_nodes(start, end, color) = {
    edge(start, end, stroke: 2pt+color, bend: -20deg)   
}


= Git basics
== Introduzione

Git è il sistema di versionamento distribuito più utilizzato al mondo. Serve a gestire e tracciare modifiche al codice sorgente nei progetti di sviluppo software. 
È uno strumento fondamentale per coordinare il lavoro tra più sviluppatori, mantenendo uno storico delle modifiche effettuate. In questo modo evitiamo di avere sparse diverse versioni del nostro progetto: _"finale" "finale-finale" "ultima-versione-finale"_ ecc...

Per ottenere questi risultati, Git utilizza diversi concetti e tecnologie: repository, commit, branch, merge, pull, push, moduli, sotto-moduli, tag, ed altri. In questo documento vedremo i concetti base per iniziare ad utilizzare Git.

In generale possiamo vedere il versionamento come un albero, dove ogni branch, come si evince dal nome, è un ramo di questo albero. A sua volta ogni branch è composto da commit, nodi che rappresentano uno step (o stato) del progetto. 

== Commit

Un commit è un'istantanea del codice in un determinato momento, generalmente ha questi attributi: 
- hash identificativo univoco
- messaggio che descrive le modifiche apportate
- autore (e-mail e nome), co-autori
- data e ora del commit

Ogni #link("https://git-scm.com/docs/git-commit")[commit] è collegato al precedente, e differisce da esso per le modifiche apportate. Questo ciclo di modifiche e commit è alla base di Git.

Sulla nostra macchina, git, per versionare correttamente i nostri file utilizza concettualmente diversi stati.#footnote([Per approfondimenti visitare https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository])

#align(center,image("img/local-repo.png", width: 90%))

Esaminiamo gli stati:

- *Untracked*: Il file esiste nella directory di lavoro, ma Git non lo sta ancora monitorando, potrebbe essere attivamente ignorato.

- *Tracked*: Tutti gli altri file, che questi siano *Unmodified*, *Modified* o *Staged*

- *Unmodified*: Il file è stato modificato rispetto all'ultima versione committata.

- *Modified*: Viceversa il file è stato modificato dall'ultima versione committata (anche un file appena creato con del testo in una nuovo repository). Alcuni editor elencano i files in questo stato sotto il nome di _changes_.

- *Staged*: Il file, o meglio una sua versione, è portata nell'area di staging. L'area di staging è un'area intermedia che precede un commit. La collezione di files in questo stato è anche detta _staged changes_.

Esaminiamo le azioni:

#grid(columns: (1fr,1fr),
    [
    - *Commit*: Un commit rappresenta uno step, nel quale tutti i file sono ad una certa versione. Supponiamo per esempio di dover correggere un libro: potrebbe essere una buona strategia raggruppare tutte le correzioni di un capitolo all'intero di un commit: ovvero ad ogni step del completamento della task.  È possibile ovviamente manipolare (parzialmente) questi commit e viaggiare tra loro, successivamente vedremo come.

    ], 
    [
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 5em,
            edge-corner-radius: 0pt,
            edge-stroke: 2pt+blue,

            branch_indicator("main", (0,0), (1,0),blue),

            double_node((1,0),blue,1.5em, 1em),

            edge((1,0), (2,0)),
            edge((1,0),(2,0),"-->",bend: 50deg, stroke: 1pt + black,label:"changes"), //CHANGES

            double_node((2,0),blue,1.5em, 1em),

            edge((2,0), (3,0)),

            double_node((3,0),blue,1.5em, 1em)
        )
    ] 
)

- *Edit the file*: Ad ogni commit tutti i file inclusi verrano letti da git come *Unmodified* e ricomincerà questo "ciclo". Editare un file, o crearlo significa portarlo allo stato *Modified*.

- *Stage the file*: La versione *attuale* del file su cui si effettua questa azione viene portata allo stato *staged*, ulteriori modifiche sul medesimo file appariranno porterrano la nuova versione del file nello stato *modified*. Per questo generalmente si effettua questa operazione e subito dopo un commit.

- *Add/Remove the file*: È ovviamente possibile aggiungere o rimuovere file dalla working directory, per far si che un nuovo file sia versionato da git si utilizza lo stesso comando che si utilizza per portarlo da *modified* a *staged*, ovvero `git add <file_name>`. Quando invece si rimuove un file precedentemente versionato, git automaticamente sarà in grado di notarlo e gestirlo.

== Branch

I branch sono utilizzati per lavorare su funzionalità diverse o bugfix separati dal ramo principale (`main` o `master`). Attraverso L'uso dei branch oltre che mantenere una corretta organizzazione del progetto, ci permette di lavorare in parallelo su più funzionalità senza interferire con il lavoro degli altri membri del team.

I branch possono essere creati, rinominati, spostati, uniti (_merge_) e cancellati. Il merge come si può intuire è un'operazione chiave, che permette di unire le funzionalità sviluppate in due branch diversi in uno solo, o di portare le modifiche di un branch nel branch principale.

Il flusso di lavoro più comune è il seguente:

#set text(10pt)
#diagram(
    node-stroke: .1em,
    node-fill: none,
    spacing: 4em,
    
    branch("main",blue,(0,0),7,1.5em, 1em),
    edge((7,0),(8,0),"--",stroke:2pt+blue),
    //... other commits
    

    // develop branch
    connect_nodes((1,0),(2,1),orange),
    branch("develop",orange,(1,1),5,1.5em, 1em),
    connect_nodes((6,1),(7,0),orange),

    // feature branch
    connect_nodes((3,1),(4,2),yellow),
    branch("feature",yellow,(3,2),1,1.5em, 1em),
    connect_nodes((4,2), (5,1),yellow),

    
    // 2nd feature branch
    connect_nodes((2,1),(3,3),teal),
    branch("2nd feature",teal,(2,3),3,1.5em, 1em),
    connect_nodes((5,3), (6,1),teal),

)



== Pratica

=== Configurare Git
Prima di iniziare a utilizzare Git, è importante configurare il proprio nome utente e l'indirizzo email, poiché questi saranno associati ai tuoi commit.

```bash
git config --global user.name "name"
git config --global user.email "your@email"
```

== Inizializzare un nuovo repository
Per creare un nuovo progetto con Git, spostati nella directory del tuo progetto e inizializza un repository con il comando 
#footnote("Ignoriamo per ora l'output che verrà analizzato in seguito"):

```bash
git init
```

Così avrai il repository solo in locale, sul tuo computer: non molto utile per collaborare con altri. Git si basa sui concetti di *local* e *remote*. In locale fai commit, crei branch e tutte le operazioni che vedremo successivamente. Le modifiche effettuate in locale *non influiscono automaticamente* sul remote. Solitamente, per i progetti più piccoli, come quelli individuali o quello affrontato nel corso di Advanced Programming, il remote repository è uno solo e sarà hostato su *GitHub*.

Questo passaggio richiede l'aver già creato l'organizzazione alla quale apparterrà il repository. In alternativa è possibile crearla come personale e poi passare l'ownership.

1. Aprite la pagina: _"https://github.com/orgs/nome-organizzazione/repositories"_

2. Premete sul pulsante: #box(fill: rgb("#29903B"),inset: 7pt, baseline: 25%, radius: 4pt)[#text(stroke: white, font: "Segoe UI Variable Static Display", size: 7pt, weight: "thin",tracking: 0.5pt)[New Repository]]

3. Da qui in poi compilate i campi, scegliendo il nome, la visibilità e la descrizione della repo. Il file README.md si può aggiungere anche in seguito.

4. La pagina della repo ora ci consiglia gli step da seguire direttamente su CLI: "_… create a new repository on the command line_"

    ```bash
    echo "# titolo" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/Advanced-Programming-2023/test.git
    git push -u origin main
    ```

    Il primo comando crea un file chiamato README.md, se non esiste già e aggiunge la stringa "\# titolo" al suo contenuto. (Il simbolo "\#" in Markdown indica un titolo). Gli altri comandi verranno spiegati nei prossimi capitoli.

== Staging Area

Per portare i file modificati dalla directory di lavoro all'area di staging, usiamo il comando `git add`. Generalmente si usa il comando `git add -A` o `git add .` per aggiungere tutti i file modificati all'area di staging. Tuttavia è possibile aggiungere i file uno alla volta con `git add <nomefile>`. 

=== View Changes

Per visualizzare la lista dei file nella staging area e altre informazioni generiche, possiamo usare il comando:

```
➜ git status       
On branch main

No commits yet

Changes to be committed:
(use "git rm --cached <file>..." to unstage)
    new file:   README.md
```

In alternativa per scendere nel dettaglio possiamo utilizzare git diff --cached (o il suo alias --staged)


== Gestione dei Remote Repository

Come si può intuire il primo comando suggerito aggiungerà l'URL come repository remote, con il nome *origin*. Per avere informazioni sui remote possiamo servirci di diversi comandi:

    ```
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

6. Il secondo comando suggerito (`git branch -M main`) è opzionale, git nomina il branch di default come _master_ invece che come _main_; sta a voi scegliere se lanciare questo comando rinominandolo. 

7. Il terzo comando suggerito 


== Clonare un repository
Se vuoi lavorare su un progetto esistente, per prima cosa devi clonare il repository:

```bash
git clone <url-repository>
```

Questo comando copia il repository in locale.

Questo crea una nuova cartella `.git`, che contiene tutte le informazioni di Git.

4. Controllare lo stato del repository
Per vedere lo stato attuale del repository, quali file sono stati modificati, aggiunti o rimossi, usa:

```bash
git status
```

5. Aggiungere file all'area di staging
Prima di confermare le modifiche, è necessario aggiungere i file all'area di staging. Puoi aggiungere un singolo file:

```bash
git add <nomefile>
```

Oppure aggiungere tutti i file modificati:

```bash
git add .
```

6. Effettuare un commit
Una volta che hai aggiunto i file all'area di staging, puoi effettuare un commit. Un commit è un'istantanea del codice nel tempo.

```bash
git commit -m "Messaggio descrittivo delle modifiche"
```

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