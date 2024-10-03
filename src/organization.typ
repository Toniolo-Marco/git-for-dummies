#let wgc = "Working group coordinator"
#let gl = "Group leader"
#let gm = "GitHub maintainer"

= Organization

L'organizzazione è un'account condiviso@gh-orgs da più utenti dove è possibile collaborare su uno o più progetti, definendo ruoli e funzioni.
Utilizzando le organizzazioni è possibile creare una suddivisione che rispecchia quella in classe, dove il *Working group coordinator* ha tutti i permessi 
i *Git Maintainer* possono creare, modificare, accettare, rifiutare le pull request e scrivere ed eseguire delle Actions (di cui parleremo più avanti) e tutti gli altri possono aprire issue, fare fork e creare delle pull request.

== Creare un'organizzazione

Per creare un'organizzazione recatevi sulla homepage di GitHub dopo aver fatto il login col vostro account, cliccate sul vostro nome utente (vicino alla foto) nell'angolo in alto a sinistra, e poi su crea organizzazione. Vi si aprirà la pagina coi piani, selezionate quello gratuito, poi compilate il form con i dettagli prestando attenzione a selezionare che l'organizzazione appartiene al vostro account personale e non ad un'azienda.

== Creare i team

GitHub per gestire i permessi nelle organizzazioni fa uso dei team, un team è un insieme di utenti, ad ogni team sono associati dei permessi, gli utenti di un team ereditano i permessi.
Per creare i gruppi@gh-groups, cambiate dal vostro account a quello dell'organizzazione, se non lo avete già fatto, cliccando sempre sul vostro nome e selezionando quello dell'organizzazione, poi spostatevi su *Teams*, e create i seguenti team:

- Organization Owners
- Members
- Tutors

=== Organization Owners

Composto dal Working group coordinator e dai Git Maintainers, questo team *deve avere tutti i permessi*, i membri di questo team devono essere manualmente 
impostati come Owners dell'organizzazione andando su *people*, cliccando sui *tre pallini* e poi su *change role* e in fine *owner*. In questo modo, avranno pieni poteri su tutta l'organizzazione.

=== Members

Questo team, deve poter forkare, creare issue e pull request sul repository del common crate, il ruolo da associarvi è *Triage* ma solo sul singolo repository 
dopo vi spiegheremo come fare, per ora create il team e non aggiungete membri, visto che sarete in \~100/150 persone è impensabile che qualcuno aggiunaga manualmente tutti i partecipanti, per questo si userà l'inviter, come spiegato successivamente.

=== Tutors

Questo team avrà acesso in lettura al repository, conterra i tutors i quali andranno aggiunti manualmente in base al loro interesse, alcuni vi chiederanno di entrare e altri invece no, anche qui, il i permessi del team vanno impostati sul singolo repository.

== Il repository

Create adesso il repository contenente il codice del Common Crate, come visibilità mettete private (il professore vi spiegherà che è per evitare che i futuri studenti trovino tutto pronto), le altre opzioni sceglietele in base 
alle vostre preferenze. Una volta creato andate in *settings*, poi *collaborators e teams* e cliccate *add teams*, cercate *Organization Owners* e come ruolo assegnategli *Admin*. Ripetete per i *Members* e come ruolo 
scegliete *Triage*, per ultimo il team *Tutors* ai quali va il ruolo di *Read*.

== Workflow consigliato

Lo scorso anno, abbiamo provato a mimare l'approccio utilizzato dai grandi progetti open source per la gestione dei repository, questo cosisteva nelle seguenti fasi@git-contribution
+ Fork del repository
+ Apertura di una issue e implentazione
+ Votazione (se si tratta di una feature proposta)
+ Merge nel main
+ Pubblicazione della nuova versione

=== Apertura di una issue e implentazione

Le issue sono una feature delle piattaforme come GitHub per tracciare e gestire attività, bug, richieste di funzionalità o discussioni generali relative a un progetto. Serve ai membri del team, ai collaboratori e agli utenti per comunicare su specifici lavori o problemi all'interno di un repository.
Ogni issue ha un *titolo* che deve fornire una sintesi chiara, una *descrizione* dove si descrive nel dettaglio la issue, il testo è in markdown, quindi è possibile integrare codice (opportunamente formattato), immagini e molto altro. Ad ogni issue può essere associata a una pull request, questo è fondamentale per associare un fix o una implentazione all'effettivo codice che andrà inserito nel common crate e in fine, una issue può avere 0 o più labels e vi consigliamo vivamente di usarle, perchè fornisco una rapida descrizione del tipo di issue e permettono di filtrarle facilmente. Per esempio l'anno scorso avevamo le seguenti labels:

- *approved* (la issue è stata approvata con una votazione)
- *bug* (la issue solleva la presenza di un bug e o propone un fix)
- *check* required (la issue non è chiara e richiede un approfondimento)
- *CIRITICAL* (la issue è fondamentale e va completata il prima possibile)
- *discussion needed* (la issue presenta l'implentazione di una nuova feature e va discussa alla prossima riunione)
- *documentation* (la issue aggiunge documentazione al codice o alle specifiche)
- *in progress* (la issue è in fase di elaborazione da parte di qualcuno, non è stata ne chiusa ne approvata)
- *proposal* (la issue propone l'implentazione di qualcosa di nuovo e va votata)
- *question* (la issue è una domanda riguardante il common crate)
- *rejected* (la issue non è stata approvata durante la riunione)
- *test* (la issue aggiunge o modifica uno o più test)
- *TODO code* (la issue presenta un'idea ma manca il codice)
- *vote required* (la issue richiede una votazione, indipendentemente dal tipo)

Solitamente chi apre la issue imposta il se stesso come *Assignees*, assegna le label appropriate e linka la pull request col codice. I #gm controllano le issue, richiedono di approfondire aggiungendo del testo o un esempio (se necessario) e in fine aggiungono le label che ritengono necessarie.

=== Votazione

Se la issue richiede una votazione, allora alla prima riuone dei #gl chi ha aperto la issue espone la propria idea e implentazione, poi i #gl votano se accettarla o meno, a questo punto un #gm imposta la label appropriata (approved o rejected), accetta la pull request (solo se approvata) e poi chiude la issue. È quindi necessario che almeno un #gm sia presente durante le riunioni.

== Merge nel main

Dopo che un #gm ha approvato la PR (pull request), il codice proposto viene mergiato nel main, prima di accettare una PR è fondamentale che un #gm cloni il conentuno della PR localmente, la testi e poi in caso sia necessario richieda modifiche, rispondendo alla issue. Tutto questo è automatizzabile tramite le action, ma ne parleremo più avanti.

=== Pubblicazione della nuova versione

Dopo aver accettato una PR, è consigliabile incrementare la versione del common crate modificando il cargo.toml e successivamente pubblicando la nuova versione.

= Software fair e archiviazione del repository

Il professore ad certo punto in accordo col Working group coordinator, fisserà la data della software fair, lo svolgimento dell'evento verrà ampiamente spiegato a lezione, quello che è importante ai fini di questa guida è che il repository, il giorno prima di quella data deve essere *archiviato* e messo in readonly per prevenire ulteriori modifiche. L'ideale sarebbe che tutte le pr approvate vengano mergiate prima di tale date, il codice testato, le specifiche ultimate e che venga creata la release finale, è fondamentale anche a costo di tagliare qualche feature, che la release sia il più stabile e funzionante possibile perchè dopo tale data anche in caso emergano bug *non si potrà modificare*.

== Come archiviare il repository

Per prima cosa andate sulla pagina principale del repository, poi cliccate su *Settings*, *General*, scorrete *a fine pagina* e in fine *Archive this repository*, vi verrà richiesta la conferma e in fine il repository sarà in sola lettura, questo include@git-archive:
- Pull request
- Contenuto
- Actions
- Issue
