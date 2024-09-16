#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond

#let branch_indicator(name, start, end, color) = {
    let near = (start.at(0)+0.25,start.at(1))
    node(near, [#name], corner-radius: 2pt, fill: color, stroke: none)
}

#let double_node(position, color, out_radius, inner_radius) = {
    node(position, "", radius: out_radius, stroke: color,extrude: 0, outset: 0.099em)
    node(position, "", radius: inner_radius, fill: color, stroke: none)
}

#let branch(name,color,start,length,nodes_out_radius,nodes_inner_radius, ..positions) = {
    branch_indicator(name, start, (start.at(0) + 1,start.at(1)), color)

    let x = start.at(0) + 1 // x node coordinate
    let i = 0

    let pos = positions.pos()
    if pos.len() == 0 {
        pos = range(0,length)
    }
    
    while i < length {
        if pos.contains(i) {
            double_node((x,start.at(1)),color,nodes_out_radius,nodes_inner_radius)
        }

        if i < length - 1 {
            edge((x,start.at(1)), (x+1,start.at(1)), stroke: 2pt+color)
        }


        i = i + 1
        x = x + 1
    }
}

#let connect_nodes(start, end, color) = {
    edge(start, end, stroke: 2pt+color, bend: -20deg)   
}