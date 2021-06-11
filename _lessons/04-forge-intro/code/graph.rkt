#lang forge

--option solver MiniSatProver
--option logtranslation 1

sig Vertex {
    edges: set Vertex
}
one sig Boston, Prov, Worc, NYC extends Vertex {}

pred source[v: Vertex] {
    all v2: Vertex | v2 in v.^edges
}

pred someSource {some v : Vertex | source[v]}

pred bostonNeighbours { Boston.edges = Boston + Prov + NYC}

pred bostonConnectedWorc { Worc in Boston.edges }

test expect { mytest : {someSource and bostonNeighbours and bostonConnectedWorc} is sat }

--run {someSource and bostonNeighbours and bostonConnectedWorc}
