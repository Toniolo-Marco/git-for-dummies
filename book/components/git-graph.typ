#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes, draw
#import fletcher.shapes: diamond
#import "multi-label.typ" : multi_label
#import "utils.typ": alignment_to_coordinates, generate_label

#let branch_indicator(name, start, color, remote: none, lbl_stroke: (1pt+white)) = {
    let near = (start.at(0)+0.25,start.at(1))
    if remote == none {
        // Single label node
        node(near, [#name], corner-radius: 2pt, fill: color, stroke: lbl_stroke)
    } else if type(remote) == "string" {
        // Double label node
        node(near,multi_label((name,remote),lbl_stroke).node,inset:0pt, corner-radius:3pt, fill: color, stroke: lbl_stroke)
    } else if type(remote) == array {
        // Multi label node
        remote.insert(0,name)
        node(near,multi_label(remote,lbl_stroke).node,inset:0pt, corner-radius:3pt, fill: color, stroke: lbl_stroke)
    }
}

#let commit_node(position, color, out_radius, inner_radius, name) = {
    node(position, "", name: name, radius: out_radius, stroke: color,extrude: 0, outset: 0.099em)
    node(position, "", name: name, radius: inner_radius, fill: color, stroke: none)
}

#let branch(
    name:"",
    remote: none,
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
        branch_indicator(name, indicator-xy, color,remote: remote)
    } else {
        branch_indicator(name, start, color, remote: remote)
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
                commit_node((x,start.at(1)),color,nodes_out_radius,nodes_out_radius,lbl)
            } else {
                commit_node((x,start.at(1)),color,nodes_out_radius,nodes_inner_radius,lbl)
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

#let connect_nodes(start, end, edge_stroke, bend: -20deg) = {
    if type(edge_stroke) == color {
        edge(start, end, stroke: 2pt+edge_stroke, bend: bend)
    }
    else if type(edge_stroke) == stroke {
        edge(start, end, edge_stroke,bend: bend)
    }
}