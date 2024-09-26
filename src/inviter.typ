= Inviter

Come detto in precedenza è impensabile aggiungere manualmente tutti all'organizzazione, per questo abbiamo crato una piccola web app che utilizzando le api di GitHub consente di invitare autameticamente le persone, è distribuita sotto forma di container, quindi potete eseguirla su un server con Linux e Docker oppure, se avete un altro sistema operativo potete usare una delle release. Per iniziare recatevi alla pagina #link("https://github.com/FrostWalk/GitHub-Inviter")[GitHub] dell'inviter, qui troverete, oltre al codice e al `docker-compose.yml` da usare per hostare l'applicazione tutte le istruzioni e parametri per adattarlo alla vostra organizzazione. Vi consiglio vivamente di usare il docker-compose.yml per hostarlo, se invece volete usare uno degli eseguibili dovrete inittare manualmente le variabili d'ambiente coi config.
D'ora in avanti assumeremo che avete scelto di usare Docker, aprite quindi il file `docker-compose.yml` e procedete a modificarlo come segue.

== Creare il token

La prima cosa da fare è procurarsi il token da usare per l'inviter, per farlo andate su una pagina qualunque di GitHub, poi cliccate sulla vostra *foto profilo* in alto a destra e poi su *settings*, scorrete ora in basso fino a che non trovate *developer settings* e cliccateci sopra, dal menù laterale selezionate *Personal access tokens* e poi *Fine-grained tokens* e in fine *Generate new token*. Assegnategli il nome che preferite, per esempio: `Inviter`, impostate un'expire date di almeno 90 giorni (ci saranno sempre dei ritardatari), la cosa importante è *impostare come Resource owner l'organizzazione* e non il vostro account, come repository access lasciate pure Public Repositories (read-only), infatti questo token non avrà bisogno di accedere a nessun repository. Scorrete ora nella sezione *Oragnization permissions* e cliccateci sopra e tra i vari permessi e come access di *Members* selezionate *Read and write* e in fine cliccate su *Generate token* in fondo alla pagina. Copiate ora il token ottenuto, che avrà un formato simile a questo `github_pat_11AMMG6ZI0xOGq83w37...` e incollatelo dopo l'uguale nel docker-compose.yml nel campo `GITHUB_TOKEN`.

== Nome dell'organizzazione e del gruppo

La vostra organizzazione probabilmente si chiamera qualcosa come `Advanced programming 20..` e il gruppo qualcosa come `Members` per trovare il nome corretto da utilzzare con l'applicazione è sufficente recarsi nella pagina dell'organizzazione, e poi in Teams e in fine cliccare sul gruppo in cui finiranno i membri invitati, se adesso guardate l'url e dopo la parte `https://github.com/orgs/` troverete entrambi i parametri. Ad esempio se l'organizzazione si chiama `Advanced-Programming-2023` e il gruppo si chiama `Group Members`, otterrete che l'ulr contiente `Advanced-Programming-2023/teams/group-members` i parametri sono quindi `Advanced-Programming-2023` per `GITHUB_ORG_NAME` e `group-members` per `GITHUB_GROUP_NAME`.

== Invite code

Questo è l'ultimo parametro necessario, si tratta di una stringa a vostra scelta, da condividere con la classe e da inserire assieme al propio username, questo codice univoco per tutti, è una misura di sicurezza per evitare che persone a caso o bot si invitino nell'organizzazione, l'unico vincolo è che la stringa *non contenga spazi*.


#block(breakable: false,
[
== Compose e parametri opzionali

A questo punto in vostro `docker-compose.yml` assomiglierà a qualcosa tipo:
```yaml
services:
  github-inviter:
    container_name: github-inviter
    image: ghcr.io/frostwalk/github-inviter:latest
    environment:
      - GITHUB_TOKEN=github_pat_11AMMG6ZI0xOGq83w37...
      - GITHUB_ORG_NAME=Advanced-Programming-2023
      - GITHUB_GROUP_NAME=group-members
      - INVITE_CODE=super-secret-string
    ports:
      - "80:80"
```
non vi resta che aprire un terminale nella stessa cartella e dare i seguenti comandi:

```bash
docker compose up -d
```
e poi per verificare che tutto funzioni
```bash
docker compose logs
```
il risultato dovrebbe essere:
```
Server is running on http://127.0.0.1:80
```
L'ideale ora sarebbe esporre l'inviter dietro ad un reverse proxy il quale dovrebbe occuparsi di https, se invece volete esporlo direttamente vi consigliamo caldamene configurare tls tramite gli appositi parametri, seguite il README.md sulla pagina GitHub per tutte le informazioni.])