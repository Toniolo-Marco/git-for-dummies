= GitHub Actions

Le *GitHub Actions* sono una potente piattaforma di automazione integrata in GitHub che consente agli sviluppatori di automatizzare workflow direttamente nei repository di codice. Può essere utilizzata per un'ampia varietà di scopi, come la continua integrazione (CI), la distribuzione continua (CD), la gestione delle versioni, l'esecuzione di script personalizzati e altro ancora.

== Caratteristiche principali di GitHub Actions:
+ *Workflow personalizzabili*: Consente di creare flussi di lavoro per automatizzare qualsiasi processo, dal testing all'aggiornamento della documentazione.
+ *Event-driven*: Le azioni possono essere attivate da eventi, come commit, apertura di pull request o push nel repository.
+ *Supporto multi-linguaggio*: GitHub Actions supporta qualsiasi linguaggio di programmazione, tra cui JavaScript, Python, Rust, Go e molti altri.
+ *Scalabilità*: È possibile eseguir=e workflow su macchine virtuali ospitate da GitHub (i cosiddetti "runner") o su macchine self-hosted.
+ *Marketplace*: Esiste un marketplace che contiene migliaia di GitHub Actions pronte all'uso create dalla community, riducendo il tempo di setup.

== Esempio di workflow: Test di una libreria Rust

Immagina di avere un progetto Rust e di voler automatizzare i test con GitHub Actions ogni volta che viene fatto un commit o una pull request. Creiamo un workflow che esegua i test su tre sistemi operativi: Ubuntu, macOS e Windows.

=== Passaggi per configurare il workflow:

+ *Crea la directory e il file per il workflow*:
   All'interno del tuo repository, crea una directory `.github/workflows/` e un file YAML al suo interno (es. `rust.yml`).

+ *Configura il workflow*:
   Nel file `rust.yml` si definirà il workflow che esegue i test per la libreria.

Ecco un esempio di file di configurazione:

```yaml
name: Test Rust Library

= Il workflow viene eseguito ogni volta che si fa un push o una pull request sul branch main
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

= Definizione dei job (compiti) da eseguire
jobs:
  build:
    = Esegui il job su ubuntu (hostato da GitHub)
    runs-on: ubuntu-latest

    steps:
      = Step 1: Checkout del repository
      - name: Checkout code
        uses: actions/checkout@v3

      = Step 2: Imposta la versione di Rust desiderata
      - name: Install Rust
        uses: actions-rs/toolchain@v1
        with:
          toolchain: ${{ matrix.rust }}
          override: true

      = Step 3: Esegui i test
      - name: Run tests
        run: cargo test --verbose
```

== Spiegazione del workflow:
- *on*: Definisce gli eventi che attivano il workflow. In questo caso, viene attivato su ogni `push` e `pull_request` nel branch `main`.
- *jobs*: Definisce i job da eseguire. In questo caso, c'è un solo job chiamato `build`.
- *strategy*: Usa una strategia matrix per eseguire il workflow su ubuntu, ultima versione usando Rust stable.
- *steps*: Elenca i singoli step del workflow:
  + *Checkout code*: Usa l'azione `actions/checkout` per scaricare il codice del repository.
  + *Install Rust*: Usa l'azione `actions-rs/toolchain` per installare la versione di Rust specificata nel matrix.
  + *Run tests*: Esegue i test del progetto con `cargo test`.


come detto in precedenza le GitHub Actions sono uno strumento potente e flessibile per automatizzare flussi di lavoro legati allo sviluppo, dalla CI/CD ai controlli di sicurezza, all'aggiornamento della documentazione. I runner consentono l'esecuzione dei job su macchine virtuali fornite da GitHub o su macchine fisiche configurate dall'utente, offrendo sia convenienza che flessibilità. Il workflow di esempio per Rust mostra come eseguire automaticamente i test inclusi nel vostro progetto di Rust. Come detto prima, questo workflow viene eseguito su un runner hostato da GitHub, il quale offre solo un tot di ore gratutite ogni mese per eseguire le action, per questo più avanti spiegheremo come hostare i propri runner per avere esecuzioni illimitate e maggior controllo sull'ambiente.

== Runners

Il concetto di *runner* è fondamentale per capire come funzionano le GitHub Actions. Un runner è un ambiente dove è in esecuzione il #link("https://github.com/actions/runner")[Runner] (software) il quale è collegato a GitHub ed è in ascolto per eseguire le actions. "L'ambiente" può essere una macchina fisica, virtuale o ancora meglio un container.

=== Tipi di runner:
+ *GitHub-hosted runners*: Sono macchine virtuali fornite da GitHub su cui vengono eseguite le azioni del workflow. GitHub offre runner con tre principali sistemi operativi:
    - Ubuntu (il più comune)
    - Windows
    - macOS
   Questi runner vengono automaticamente avviati, eseguono il workflow e vengono distrutti una volta completato.
   
   Vantaggi:
   - *Convenienza*: Non è necessario configurare nulla, sono pronti all'uso.
   - *Aggiornamenti*: Sono mantenuti da GitHub e sempre aggiornati con le ultime versioni degli strumenti più utilizzati (come Node.js, Python, Rust, ecc.).
   
   Svantaggi:
   - *Limiti di esecuzione*: Sono imposti limiti di tempo e di risorse, specialmente per i repository gratuiti.
   - *Inefficenti*: Ogni esecuzione il runner deve scaricare tutto il necessario, per esempio installare rust.
   
+ *Self-hosted runners*: Sono macchine fisiche o virtuali configurate dall'utente e connesse al repository GitHub. Questi runner sono completamente personalizzabili e permettono di avere più controllo sulle risorse hardware e software disponibili.
   
   Vantaggi:
   - *Maggiore controllo*: Puoi configurare il sistema operativo, le dipendenze e le risorse hardware secondo le tue esigenze.
   - *Nessun limite di esecuzione*: Non sono soggetti alle restrizioni dei GitHub-hosted runners.
   
   Svantaggi:
   - *Manutenzione*: L'utente è responsabile della manutenzione, aggiornamento e sicurezza del runner.
   
In definitiva noi vi sconsigliamo di appoggiarvi a GitHub per eseguire le vostre actions, durante il picco, circa una settimana prima della software fair vi ritroverete ad accettare decine di pull request, questo vuol dire che le action verranno eseguite molte volte e nonostante il caching sarà facile terminare le ore gratuite.