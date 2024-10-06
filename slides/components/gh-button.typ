#let dropdown_icon = "▼" 

#let gh_button = (img,btn_text, fill_color, text_color, stroke_color, separator) =>{
  box(
      fill: rgb(fill_color), 
      inset: 7pt, 
      baseline: 35%, 
      radius: 4pt,
      stroke: rgb(stroke_color)+1pt
      )[

      #stack(dir:ltr, spacing: 15pt, 
          image.decode(img, width: 12pt),

          text(
              stroke: rgb(text_color),
              font: "Noto Sans",
              size: 10pt,
              weight: "thin",
              tracking: 1pt,
              baseline: 1pt)[
              #btn_text 
          ],

          if separator == true [
            #box(
                fill: none, 
                height: 0pt,
                inset: 0pt, 
                radius: 0pt)[
                #text(
                    stroke: rgb(stroke_color), 
                    font: "Noto Sans",
                    fill: rgb(text_color),
                    size: 24pt,
                    weight: "thin", 
                    baseline: -2pt)[|]
            ]
          ],
          
          
          text(
            stroke: rgb(stroke_color), 
            fill: rgb(stroke_color),
            size: 12pt,
            weight: "thin", 
            baseline: 0pt)[#dropdown_icon]
      )
  ]
}