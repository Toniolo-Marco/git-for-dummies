// Definisci una funzione per creare i bottoni della finestra
#let window-button(color) = circle(
  fill: color,
  radius: 4pt,
)

// Definisci la barra del titolo con i tre bottoni
#let window-titlebar = box.with(
    // fill: rgb("#1d2433"),
    width: auto,
    height: 16pt,
    radius: 5pt,
    inset: 4pt,
  )(
    stack(
      dir: rtl,
      spacing: 8pt,
      window-button(rgb("#27c93f")), // Verde (massimizza)
      window-button(rgb("#ffbd2e")), // Giallo (minimizza)
      window-button(rgb("#ff5f56")), // Rosso (chiudi)
    )
)


// Definisci il blocco di codice con la barra del titolo
#let code-block = block.with(
  fill: rgb("#1d2433"),
  inset: 0pt,
  radius: 5pt,
  breakable: false,
)