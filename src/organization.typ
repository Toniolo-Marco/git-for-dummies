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
+ Apertura di una issue
+ Votazione (se si tratta di una feature proposta)
+ Fork del repository
+ implentazione
+ Apertura di una pull request associata alla issue
+ Revisione
+ Merge nel main
+ Pubblicazione della nuova versione

