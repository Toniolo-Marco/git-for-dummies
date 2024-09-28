# git-for-dummies

Una piccola guida su come organizzare e gestire il repository per il corso di Advanced Programming, su come usare git, Github e le GitHub Actions.

# Typst per VS Code (Linux)

La guida è scritta in [Typst](https://typst.app/docs/),

Per compilare automaticamente il file `main.typ`, con i file dei capitoli aggiornati, è presente una task che controlla i file `.typ` modificati e ricompila solo il main. Questa task viene eseguita all'apertura della cartella del progetto. È necessario avere installato `cargo` e `watchexec-cli`; rispettivamente con:

    curl https://sh.rustup.rs -sSf | sh

    cargo install watchexec-cli

Per avere una preview del file `main.typ` è utile utilizzare l'estensione [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) di VS Code.

Un'altra estensione consigliata per visualizzare i PDF all'interno di VS Code è [VS Code PDF](https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf).
