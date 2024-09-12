#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond
#import "components/gh-button.typ": gh_button
#import "components/git-graph.typ": branch_indicator, double_node, connect_nodes, branch

= Git Basics Theory
== Introduzione

Git è il sistema di versionamento distribuito più utilizzato al mondo. Serve a gestire e tracciare modifiche al codice sorgente nei progetti di sviluppo software. 
È uno strumento fondamentale per coordinare il lavoro tra più sviluppatori, mantenendo uno storico delle modifiche effettuate. In questo modo evitiamo di avere sparse diverse versioni del nostro progetto: _"finale" "finale-finale" "ultima-versione-finale"_ ecc...

Per ottenere questi risultati, Git utilizza diversi concetti e tecniche: repository, commit, branch, merge, pull, push, fork, moduli, sotto-moduli, tag, ed altri. In questo documento vedremo i concetti base per iniziare ad utilizzare Git.

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
            mark-scale: 50%,

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

#align(center)[
    #scale(90%)[
        #set text(10pt)
        #diagram(
            node-stroke: .1em,
            node-fill: none,
            spacing: 4em,
            mark-scale: 50%,
            
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
    ]
]

Al branch develop vengono mergiate tutte le funzionalità sviluppate, successivamente quando si è sicuri che il codice sia stabile e pronto per la produzione, si può fare il merge di develop in main.

== Remote Repository

Tutto quello che abbiamo visto finora riguarda il repository locale, ovvero il repository presente sulla nostra macchina.  Per collaborare con altri sviluppatori è necessario avere un repository remoto, generalmente è hostato su servizi come GitHub, GitLab o self-hosted.

#grid(columns: (4fr,5fr),[

    Il repository remoto è una repository a cui tutto il team può accedere, i suoi branch possono essere sincronizzati, attraverso operazioni di pull e push, con un repository locale. In questo modo, i membri del team possono lavorare su un progetto comune, mantenendo uno storico delle modifiche e delle versioni.

    Per configurare un repository remoto, è necessario aggiungere un _remote_ al repository locale. Un _remote_ è un riferimento a un repository remoto, generalmente chiamato _origin_. Per i progetti più complessi, è possibile aggiungere più _remote_.

    ],[

    #align(center)[#scale(75%)[
        #set text(10pt)
        #diagram(
            node-stroke: 1pt,
            edge-stroke: 1pt,
            spacing: 10em,

            node((1,0), [Remote Repository\ on GitHub], corner-radius: 2pt, label:"origin"),
            edge((1,0),(0.25,1),"-|>",bend: 10deg),
            edge((0.25,1),(1,0),"-|>",label:"git push", bend: 25deg),
            node((0.25,1), align(center)[Developer 1 \ Machine], shape: rect),
            edge((1,0),(1,1),"-|>", bend: 10deg),
            edge((1,1),(1,0),"-|>", bend: 10deg),
            node((1,1), [Developer 2 \ Machine], shape: rect),
            edge((1,0),(1.75,1),"-|>",label:"git pull", bend: 10deg),
            edge((1.75,1),(1,0),"-|>", bend: 25deg),
            node((1.75,1), [Developer 3 \ Machine], shape: rect),
        )
    ]]
    ]
)

Si noti come non sia necessario che i repository locali e remoti abbiano gli setessi branch, infatti è possibile avere branch locali che non esistono nel repository remoto e viceversa.

== Pull Request

A questo punto dovrebbe essere chiara l'importanza del branch _main_, se più sviluppatori lavorano su un progetto, è necessario che qualcuno abbia il compito di controllare la qualità del codice in produzione e che risolva i conflitti di merge nel main.

Per farlo si utilizzano le _pull request_ (pr), che sono delle richieste di merge di un branch in un altro (solitamente nel main). Le _pull request_ permettono di discutere le modifiche apportate, di fare code review e di risolvere i conflitti di merge prima di unire i branch.

Di seguito un'esempio di _pull request_ su GitHub:

#align(center)[#image("img/pr-example.png", width: 90%)]

La pr rappresentata è composta da:
- il titolo della pr
- la descrizione delle modifiche apportate
- numero identificativo (*per eliminare una pr è necessario contattare github*)
- commit associati (anche di diversi autori)
- stato della pr (aperta, chiusa, merge, ecc.)
- label (tag che permettono di categorizzare le pr)
- eventuali commenti

Sfortunatamente, ad oggi, il piano gratuito di GitHub non permette di proteggere il branch _main_ da push diretti:

#align(center)[#image("img/gh-rules.png", width: 90%)]

Un modo per aggirare questo problema, all'interno delle organizzazioni, è:
- creare un team
- assegnare dei permessi di _triage_ a questo team
- aggiungere dei membri del team

In questo modo, solo gli owner dell'organizzazione potranno approvare le pull request.

== Fork

Come i più attenti di voi avranno notato nell'immagine d'esempio della _pull request_, il repository da cui proviene la pr è differente da quello in cui si vuole fare il merge (l'originale). Questo perché il repository da cui proviene la pr è un _fork_ del repository originale.

Il fork è una copia di un repository remoto, generalmente su GitHub, che può essere modificata indipendentemente dal repository originale. I fork sono utilizzati per contribuire a progetti open source o per lavorare su una copia di un progetto senza influenzare il repository originale.

Su GitHub le repositories ereditano la visibilità del repository originale, ma non le issue, le pull request. Inoltre, se la repository originale viene cancellata, il fork rimane, senza link alla repo originale.

#let stroke_color = "#9198A1"
#let fill_color = "#262C36"
#let text_color = "#B0B7BE"

#let fork_svg = read("img/fork.svg")
#let white_fork = fork_svg.replace("#323232", stroke_color)

#let pr_svg = read("img/pr.svg")
#let white_pr = pr_svg.replace("#000000", stroke_color)

Forkare una repo è intuitivo. Nella sezione #link("https://github.com/trending")[trending] di GitHub, possiamo vedere i progetti più popolari del momento. Prendiamo ad esempio il progetto #link("https://github.com/rustdesk/rustdesk")[RustDesk]: _"An open-source remote desktop application designed for self-hosting, as an alternative to TeamViewer"_. Per forkare il progetto, basta premere il pulsante _Fork_ in alto a destra. 
#gh_button(white_fork, "Fork", fill_color, text_color, stroke_color, true)

La repository verrà copiata nel vostro account GitHub. Allo stesso modo potrete proporre le modifiche apportate su uno dei vostri branch, clickando sul pulsante _Contribute_ e successivamente _Open pull request_ (trovate entrambi sulla pagina principale del vostro fork). 
#gh_button(white_pr, "Contribute", fill_color, text_color, stroke_color, false)