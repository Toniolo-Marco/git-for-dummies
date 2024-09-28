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
Per approfondire e imparare a scrivere Actions specifiche il posto da cui iniziare è la documentazione ufficiale, che potete trovare #link("https://docs.github.com/en/actions")[qui], se invece volete una quick start guide vi consigliamo il tutorial del sito dev.to intitolato #link("https://dev.to/kanani_nirav/getting-started-with-github-actions-a-beginners-guide-og7")[Getting Started with GitHub Actions: A Beginner’s Guide] #footnote([Stranamente ChatGPT si dimostra molto utile nella stesura delle Actions, spesso riesce a dare la struttura generale del workflow e risparmiandovi un pò di tempo.])
e di controllare il #link("https://github.com/marketplace")[Marketplace], dove probabilmente troverete tutti i pezzi necessari per comporre il vostro workflow.
Un consiglio che ci sentiamo di darvi è di creare un repo separato in cui testare le Actions prima di metterle in quello principale.

== Actions secrets and variables

Alcune Actions avranno bisogno di accedere a dati sensibili come password, api key o token di GitHub per compiere azioni specifiche, per evitare che questi dati siano visibili pubblicamente si utilizzano i secrets,
in pratica, vengono memorizzati in modo sicuro nei repository GitHub, e sono accessibili solo all'interno delle Actions, esse infatti vengono anche nascoste dai log die esecuzione e una volta salvate non sono più leggibili nemmeno dalla ui.
Ad esempio, se la action deve usare una chiave API, è sufficente aggiungerla ai secrets del repository e poi richiamarla nella workflow in questo modo:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Example step
      env:
        API_KEY: ${{ secrets.MY_API_KEY }}
      run: echo "Using API key in this step"
```

In questo esempio, `secrets.MY_API_KEY` fa riferimento a un secret chiamato `MY_API_KEY` presente nel repository.

per aggiungere un nuovo secret andate nella pagina del repository, poi *Settings*, nel menù di sinistra cliccate su *Secrets and variables*, poi su *Actions* e in fine cliccando sul tasto verde *New repository secret*, compilate il form scegliendo il nome (seguite la convenzione SNAKE_CASE), inserite il secret e poi cliccate su *Add secret*.

== Runners

Il concetto di *runner* è fondamentale per capire come funzionano le GitHub Actions. Un runner è un ambiente dove è in esecuzione il #link("https://github.com/actions/runner")[Runner] (software) il quale è collegato a GitHub ed è in ascolto per eseguire le Actions. "L'ambiente" può essere una macchina fisica, virtuale o ancora meglio un container.

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
   
Per farla beve, noi vi sconsigliamo di appoggiarvi a GitHub per eseguire le vostre Actions, durante il picco, circa una settimana prima della software fair vi ritroverete ad accettare decine di pull request, questo vuol dire che le action verranno eseguite molte volte e nonostante il caching sarà facile terminare le ore gratuite.

=== Hostare un runner (bare metal)

Per hostare un runner ci sono due strade principali, la prima e più semplice consiste nell'installare il runner direttamente sul sistema come software, il runner può essere eseguito su ogni piattaforma (Linux, Windows e macOS e cpu amd64, arm64 e arm32), ma vi consigliamo di usare Linux su amd64 o arm64 per la maggior compatibilità dei software e facilità di setup. Per iniziare recatevi nella *homepage dell'organizzazione*, *Settings*, nel menù di sinistra cliccate su *Actions*, poi su *Runners* e sul tasto verde *New runner*, ora non vi resta che seguire le istruzioni, ma attenzione, se ora chiudete il terminale il runner smetterà di funzionare se invece volete installarlo come servizio e far si che parta automaticamente all'avvio dovete seguire #link("https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service")[questa guida], prestando attenzione a scegliere il sistema opertivo corretto in alto. Il runner appena creato dovrebbe essere presente nell'elenco della vostra organizzazione e sarà automaticamente utilizzabile su tutte le actions in ogni repository e avrà accesso ad ogni software presente nel sistema host, perciò se dovete compilare e testare un progetto Rust allora dovrete aver installato la toolchain e cargo.

=== Hostare un runner (container Docker)

L'alternativa a installare il runner direttamente sul sistema host è quello di isolarlo mettendolo in un container, questo complica un pò la fase di setup ma vi garantisce maggiore sicurezza a livello di esecuzione, in quanto tutto sarà eseguito in un ambiente isolato e protteto che potrete ricreare in qualsiasi momento e soprattuto in caso si corrompa. Questo pezzo della guida presuppone che siate su un sistema Linux sui cui è presente Docker e che abbiate un pò di dimestichezza con i Dockerfile, per iniziare *create una cartella* ed *entrateci con un terminale*, *create un file* chiamato esattamente `Dockerfile` senza estensione e incollateci dentro:
```dockerfile
FROM debian:stable-slim
ADD ./runner runner
WORKDIR /runner
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["bash", "-c"]
# Add the software to be installed here (before ' \')
RUN ./bin/installdependencies.sh && apt-get install -y jq curl git \ 
    && apt-get autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD --chmod=754 ./start.sh start.sh
ENV RUNNER_MANAGER_TOKEN=""
ENV GITHUB_ORG=""
ENV RUNNER_NAME=""
ENV ACTIONS_RUNNER_INPUT_REPLACE=true
ENV RUNNER_ALLOW_RUNASROOT=true
ENTRYPOINT ["bash", "-c", "./start.sh"]
```
questo è il file che dovete modificare per poter aggiungere i software necessari all'esecuzione delle vostre Actions.

Successivamente *create un'altro file* chiamato `start.sh` con il seguente contenuto:
```bash
#!/bin/bash
set -eux
reg_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/${GITHUB_ORG}/actions/runners/registration-token | jq -r .token)
/bin/bash config.sh --unattended --url https://github.com/${GITHUB_ORG} --name ${RUNNER_NAME} --work _work --token ${reg_token} --labels latex,x64,linux
remove () {
  local rem_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/${GITHUB_ORG}/actions/runners/remove-token | jq -r .token)

  ./config.sh remove --token $rem_token
}
trap remove EXIT
./bin/runsvc.sh
```
questo script si occupa, all'avvio del container di recuperare il token necessario per autenticare il runner quando si collega a GitHub #footnote([il token non va confuso con quello che andrà fornito come variabile d'ambiente al container, è un token univoco e generato da GitHub partendo da quello fornito]), aggiunge il runner, cattura l'uscita (spegnimento del container o riavvio) aggiungendo una funzione che cancella il runner dal GitHub. In fine viene eseguito il software del runner.

in fine *create un file* chiamato `build.sh` e come contenuto inserite il seguente:
```bash
#!/bin/bash
IMAGE_NAME="github-runner"
echo "retrieving latest version number from release page"
LATEST=`curl -s -i https://github.com/actions/runner/releases/latest | grep location:`
LATEST=`echo $LATEST | sed 's#.*tag/v##'`
LATEST=`echo $LATEST | sed 's/\r//'`
echo "downloading latest GitHub runner (${LATEST})"
curl --progress-bar -L "https://github.com/actions/runner/releases/download/v${LATEST}/actions-runner-linux-${ARCH}-${LATEST}.tar.gz" -o runner.tgz
mkdir -p runner
echo "unpacking runner.tgz"
tar -zxf runner.tgz -C runner
docker build -t ${IMAGE_NAME} .
echo "cleaning"
rm -rf runner runner.tgz
```
quello che fa questo script è scaricare l'ultima versione del runner per Linux amd64 dal repository ufficiale di GitHub, estrarlo e effettuare la build del Dockerfile presente nella stessa cartella generando l'immagine chiamata `github-runner:latest`, se avete letto il Dockerfile, noterete che vengono definite 5 variabili d'ambiente, quelle che interessano a voi sono: `RUNNER_MANAGER_TOKEN`, `GITHUB_ORG` e `RUNNER_NAME` per eseguire l'immagine appena creata, vi abbiamo preparato un `docker-compose.yml`:
```compose
services:
  github-runner:
    container_name: github-runner
    image: github-runner
    labels:
      - "com.centurylinklabs.watchtower.enable=false"
    restart: "no"
    volumes:
      - /etc/localtime:/etc/localtime:ro
    environment:
      - RUNNER_MANAGER_TOKEN=
      - RUNNER_NAME=
      - GITHUB_ORG=
```
non vi resta che configurarlo coi parametri richiesti e poi dare `docker compose up -d`

==== RUNNER_MANAGER_TOKEN

Questo token è come quello dell'inviter, per poter aggiungere e riumovere i runner è necessario che il token abbia lettura e scrittura su *Self-hosted runners*, vi consigliamo caldamente di creare un token univoco per i runner.