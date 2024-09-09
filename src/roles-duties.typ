= Ruoli e mansioni

Una divisione tipica dei ruoli è:

- Working group coordinator
- Group Leader
- Git Maintainer
- Tester
- Reporter
- Member

== Working group coordinator
È il responsabile di tutta la parte comune del progetto, è lui che ha l'ultima parola su come interpretare le specifiche fornite dal prof, gestire le riunioni, 
accettare o rifiutare le proposte (anche se è comune indirre delle votazioni), fissare le scadenze e scrivere report sullo stato del progetto dopo ogni riunione... 
in pratica è il Linus Torvalds del progetto (aspettatevi la stessa gentilezza nelle risposte alle domande banali e al cattivo codice). È eletto a maggioranza dai membri presenti
durante una delle prime lezioni, il docente di solito avvisa quando è la data dell'elezione.

Il primo compito del WGL è quello di scegliere i suoi collaboratori, in primis i *Git Maintainer* (solitamente 2), i *Tester* (solitamente 2/3) e i *Reporter* (solitamente 2), fatto questo il assieme ai GM, deve creare l'organizzazione e dare ad essi tutti i permessi, questo gli permetterà di delegare una buona mole di lavoro.

== Group Leader
Ogni gruppo ha un responsabile, questo va scelto tra i membri e comunicato al docente entro la data stabilita assieme al nome del gruppo e all'elenco dei 
partecipanti. Il suo compito è quello di partecipare alle riunione generali con WGL e di rappresentare gli interessi del gruppo, votando le varie questioni.

== Git Maintainer
Si consiglia di scegliere qualcuno che ha dimestichezza con git e GitHub. Si occuperà di gestire il repository, l'organizzazione su GitHub, setuppare l'inviter (o in alternativa aggiungere a mano tutte le persone), creare le action e cosa più importante gestire le issue, milestones e pull requests che verranno create, lavorerà in stretto contatto con i principali sviluppatori del *Common Crate* e coi testers. È compito suo accertarsi che una pr non rompa tutto il codice già presente o in caso contrario, che ci sia un valido motivo, deve controllare che il codice rispetti gli standard decisi e che sia ben documentato.

== Tester
Solitamente 2/3 persone, si occupano di scrivere i test che il Common Crate deve superare quando si implementa una nuova feature, oltre a scrivere i test che le applicazioni dei gruppi devono superare per verificare che stiano usando il Common Crate nel modo corretto, forzando gli standard decisi dalle specifiche.
L'idea è che ad ogni pull request vengano eseguiti i test e in base all'esito di essi si procede con la revisione manuale.

== Reporter
Sono coloro che partecipano ad ogni riunione col compito di stilare un resoconto degli eventi, utile per tracciare i progressi e la direzione del progetto, basandosi su esso il WGL, stilerà il suo report da inviare al docente. Hanno inoltre il compito di scrivere le specifiche man mano che vengono corrette e definite.

== Member
Sono tutti i membri dei vari gruppi, il loro compito è partecipare all'implementazione del Common Crate, proporre feature e aprire pull requests con i cambiamenti proposti.