#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes
#import fletcher.shapes: diamond

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

#let generate_label(branch:"",commit-number:0) = {
    return label(branch + "_" + str(commit-number))
}

#let branch_indicator(name, start, color) = {
    let near = (start.at(0)+0.25,start.at(1))
    node(near, [#name], corner-radius: 2pt, fill: color, stroke: none)
}

#let double_node(position, color, out_radius, inner_radius, name) = {
    node(position, "", name: name, radius: out_radius, stroke: color,extrude: 0, outset: 0.099em)
    node(position, "", name: name, radius: inner_radius, fill: color, stroke: none)
}

#let branch(
    name:"",
    indicator-xy:none,
    color:black,
    start:(0,1),
    length:1,
    nodes_out_radius:1.5em,
    nodes_inner_radius: 1em,
    head:none,
    alignment:top, 
    angle: 90deg,
    commits: none) = {

    // branch indicator
    if indicator-xy != none {
        branch_indicator(name, indicator-xy, color)
    } else {
        branch_indicator(name, start, color)
    }

    let x = start.at(0) + 1 // x node coordinate
    let i = 0 // position index
    
    // default branch
    if commits == none {
        // makes an array of commits with no message
        commits = range(length).map(_ => "")
    }

    for c in commits {
        if c != none { //if there is a commit
            // generate node label
            let lbl = generate_label(branch:name,commit-number:i)
            
            // draw the node
            if(head != none and i == head) {
                double_node((x,start.at(1)),color,nodes_out_radius,nodes_out_radius,lbl)
            } else {
                double_node((x,start.at(1)),color,nodes_out_radius,nodes_inner_radius,lbl)
            }

            // make the message
            if type(c) == "string" and c.len() > 0 {
                let lbl =  generate_label(branch:name,commit-number: i)
                node(
                    (rel: alignment_to_coordinates(alignment), to: lbl),
                    [#rotate(angle,[#c])], 
                    stroke: 0pt,
                    inset:0pt,
                    outset: 0pt
                )
            }
        }

        // draw edge between nodes
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
    