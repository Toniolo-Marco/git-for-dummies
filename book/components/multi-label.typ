#import "@preview/fletcher:0.4.4" as fletcher: diagram, node, edge, draw
#import "utils.typ" : calc_width

#let cell(..texts, stroke) = {
  let texts = texts.pos()
  let columns = texts.map(((_, len)) => len)
  let texts = texts.map(((text, _))  => text)
  let anchor_pos = {
    let anchor_pos = ()
    let width = 0pt
    for i in range(0, texts.len()) {
      let text = texts.at(i)
      if text == none {
        anchor_pos.push(width + columns.at(i) / 2)
      }
      width += columns.at(i)
    }
    anchor_pos = anchor_pos.map((x) => x - width / 2)
    anchor_pos
  }
  let n = columns.len()
  let tbl = table(
    columns: columns,
    stroke: (x, y) => if x != 0 and x != n - 1 { (x: stroke) },
    ..texts,
  )

  (node: tbl, anchors: anchor_pos)
}

#let multi_label(array, stroke) = {
  let separator = ("", 0mm);

  // Transform each element of the array into a tuple with length.
  let items = array.map((x) => (x, calc_width(x)));

  // Interleave items and separators.
  let output = range(0, items.len() * 2 - 1).map(i => {
    if calc.rem(i,2) == 0 {
      items.at(calc.quo(i,2))
    } else {
      separator
    }
  });
  cell(..output, stroke)
}