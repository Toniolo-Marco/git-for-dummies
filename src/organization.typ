= Organization
L'organizzazione è un'account condiviso da più utenti dove è possibile collaborare su uno o più progetti, definendo ruoli e funzioni.
Utilizzando le organizzazioni è possibile creare una suddivisione che rispecchia quella in classe, dove il *Working group coordinator* ha tutti i permessi 
i *Git Maintainer* possono creare, modificare, accettare, rifiutare le pull request e scrivere ed eseguire delle Actions (di cui parleremo più avanti) e tutti gli altri possono aprire issue, fare fork e creare delle pull request.

== Creare un'organizzazione
Per creare un'organizzazione recatevi sulla homepage di GitHub dopo aver fatto il login col vostro account, cliccate sul vostro nome utente (vicino alla foto) nell'angolo in alto a sinistra, e poi su crea organizzazione. Vi si aprirà la pagina coi piani, selezionate quello gratuito, poi compilate il form con i dettagli prestando attenzione a selezionare che l'organizzazione appartiene al vostro account personale e non ad un'azienda.

== Creare i gruppi
GitHub per gestire i permessi nelle organizzazioni fa uso dei gruppi, un gruppo è un insieme di utenti, ad ogni gruppo sono associati dei permessi, gli utenti di un gruppo ereditano i permessi.
Per creare i gtuppi, cambiate dal vostro account a quello dell'organizzazione, se non lo avete già fatto, cliccando sempre sul vostro nome e selezionando quello dell'organizzazione, poi spostatevi su *Teams*, e create i seguenti gruppi:

- Organization Owners
- Members
- Tutors

=== Organization Owners
Composto dal Working group coordinator e dai Git Maintainers, questo gruppo *deve avere tutti i permessi*, i membri di questo gruppo devono essere manualmente 
impostati come Owners dell'organizzazione andando su *people*, cliccando sui *tre pallini* e poi su *cambia ruolo* e in fine *owner*. In questo modo, avranno pieni poteri su tutta l'organizzazione.

=== Members
Questo gruppo, deve poter forkare, creare issue e pull request sul repository del common crate, il ruolo da associarvi è Triage ma solo sul singolo repository 
dopo vi spiegheremo come fare, per ora create il gruppo e non aggiungete membri, visto che sarete in \~100/150 persone è impensabile che qualcuno aggiunaga manualmente tutti i partecipanti, per questo si userà l'inviter, come spiegato successivamente.

=== Tutors
Questo gruppo avrà acesso in lettura al repository, conterra i tutors i quali andranno aggiunti manualmente in base al loro interesse, alcuni vi chiederanno di entrare e altri invece no, anche qui, il i permessi del gruppo vanno impostati sul singolo repository.

== Il repository
Create adesso il repository contenente il codice del Common Crate, come visibilità mettete private (il professore vi spiegherà che è per evitare che i futuri studenti trovino tutto pronto), le altre opzioni sceglietele in base 
alle vostre preferenze. Una volta creato andate in *impostazioni*, poi *collaboratori e teams* e cliccate *aggiungi teams*, cercate *Organization Owners* e come ruolo assegnategli *Admin*. Ripetete per i *Members* e come ruolo 
scegliete *Triage*, per ultimo il gruppo *Tutors* ai quali va il ruolo di *Read*.

== Workflow consigliato
Lo scorso anno, abbiamo provato a mimare l'approccio utilizzato dai grandi progetti open source per la gestione dei repository, questo cosisteva nelle seguenti fasi
+ Fork del repository
+ Apertura di una issue e implentazione
+ Votazione (se si tratta di una feature proposta)
+ Merge nel main
+ Pubblicazione della nuova versione

=== Apertura di una issue e implentazione
Le issue sono una feature delle piattaforme come GitHub per tracciare e gestire attività, bug, richieste di funzionalità o discussioni generali relative a un progetto. Serve ai membri del team, ai collaboratori e agli utenti per comunicare su specifici lavori o problemi all'interno di un repository.
Ogni issue ha un *titolo* che deve fornire una sintesi chiara, una *descrizione* dove si descrive nel dettaglio la issue, il testo è in markdown, quindi è possibile integrare codice (opportunamente formattato), immagini e molto altro. Ad ogni issue può essere associata a una pull request, questo è fondamentale per associare un fix o una implentazione all'effettivo codice che andrà inserito nel common crate e in fine, una issue può avere 0 o più labels e vi consigliamo vivamente di usarle, perchè fornisco una rapida descrizione del tipo di issue e permettono di filtrarle facilmente. Per esempio l'anno scorso avevamo le seguenti labels:

- approved (la issue è stata approvata con una votazione)
- bug (la issue solleva la presenza di un bug e o propone un fix)
- check required (la issue non è chiara e richiede un approfondimento)
- CIRITICAL (la issue è fondamentale e va completata il prima possibile)
- discussion needed (la issue presenta l'implentazione di una nuova feature e va discussa alla prossima riunione)
- documentation (la issue aggiunge documentazione al codice o alle specifiche)
- in progress (la issue è in fase di elaborazione da parte di qualcuno, non è stata ne chiusa ne approvata)
- proposal (la issue propone l'implentazione di qualcosa di nuovo e va votata)
- question (la issue è una domanda riguardante il common crate)
- rejected (la issue non è stata approvata durante la riunione)
- test (la issue aggiunge o modifica uno o più test)
- TODO code (la issue presenta un'idea ma manca il codice)
- vote required (la issue richiede una votazione, indipendentemente dal tipo)

Solitamente chi apre la issue imposta il se stesso come *Assignees*, assegna le label appropriate e linka la pull request col codice. I GM controllano le issue, richiedono di approfondire aggiungendo testo o esempio e aggiungono le label che ritengono necessarie.

=== Votazione
Se la issue richiede una votazione, allora alla prima riuone dei WG chi ha aperto la issue espone la propria idea e implentazione, poi i WG votano se accettarla o meno, a questo punto un GM imposta la label appropriata (approved o rejected), accetta la pull request (solo se approvata) e poi chiude la issue. È quindi necessario che almeno un GM sia presente durante le riunioni.

== Merge nel main
Dopo che un GM ha approvato la PR (pull request), il codice proposto viene mergiato nel main, prima di accettare una PR è fondamentale che un GH cloni il conentuno della PR, la testi e poi in caso sia necessario richieda modifiche, rispondendo alla issue. Tutto questo è automatizzabile tramite le action, ma ne parleremo più avanti.

=== Pubblicazione della nuova versione
Dopo aver accettato una PR, è consigliabile incrementare la versione del common crate modificando il cargo.toml e successivamente pubblicando la nuova versione.