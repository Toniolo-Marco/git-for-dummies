// 🌈
#let rainbow(content) = {
  set text(fill: gradient.linear(..color.map.rainbow))
  box(content)
}

// Double Page break
#let n_pagebreak(n: 1) = {
  for i in range(0,n) {
    pagebreak()
  }
}

// translate from alignment to relative coordinates
#let alignment_to_coordinates(alignment) = {
    if alignment == bottom {
        (0, 1)
    } else if alignment == top {
        (0, -1)
    } else if alignment == left {
        (-1, 0)
    } else if alignment == right {
        (1, 0)
    } else {
        (0, 0)
    }   
}

// generate the label element for inner commit nodes
#let generate_label(branch:"",commit-number:0) = {
    return label(branch + "_" + str(commit-number))
}

// calculate the needed width for the brach label, given a word
#let calc_width(word) ={
  if type(word) == content{ 
    return 2mm + ((word.text).len() * 2mm)
  }else {
    return 2mm + word.len() *2mm
  }
}