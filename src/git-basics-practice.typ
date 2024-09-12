= Pratica

== Configurare Git
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