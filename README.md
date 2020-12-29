# LayeredLayouts
[![Build Status](https://github.com/oxinabox/LayeredLayouts.jl/workflows/CI/badge.svg)](https://github.com/oxinabox/LayeredLayouts.jl/actions) [![Coverage](https://coveralls.io/repos/github/oxinabox/LayeredLayouts.jl/badge.svg?branch=master)](https://coveralls.io/github/oxinabox/LayeredLayouts.jl?branch=master)


LayeredLayouts is a package for working out how to layout graphs in a layered fashion.
In particular for how to layout directed acyclic graphs (DAGs), including trees, dependency graphs, and sankey diagrams.
It is not a package for actually visualizing graphs, rather it is a suitable helper for those to use.
It is a lot like [NetworkLayout.jl](https://github.com/JuliaGraphs/NetworkLayout.jl).

Presently it has one algorithm:
`Zarate`, based on
[D. C. Zarate, P. L. Bodic, T. Dwyer, G. Gange and P. Stuckey, "Optimal Sankey Diagrams Via Integer Programming," _2018 IEEE Pacific Visualization Symposium (PacificVis)_, Kobe, 2018, pp. 135-139, doi: 10.1109/PacificVis.2018.00025.](https://ialab.it.monash.edu/~dwyer/papers/optimal-sankey-diagrams.pdf).
Which is a Sugiyama style layout algorthm via full mixed integer programming.


### Usage
```julia
julia> using LayeredLayouts, LightGraphs

julia> tiny_depgraph = SimpleDiGraph(Edge.([
           1 => 2;
           2 .=> [4, 5, 6];
           3 .=> [2, 4, 5, 6, 7, 8];
           4 .=> [9, 10, 11];
       ]))
{11, 13} directed simple Int64 graph

julia> xs, ys = solve_positions(Zarate(), tiny_depgraph)
([1.0, 2.0, 1.0, 3.0, 3.0, 3.0, 2.0, 2.0, 4.0, 4.0, 4.0], [-0.500000683006983, -0.9285709647225431, 0.500000681452564, 0.40476260792712027, -0.5952375840605986, -1.5952379163280372, 3.0714291353124143, 2.0714290900138614, 1.404762745121713, 0.4047626078228009, -0.5952375294761111])
```

### Gallery
This plots are from the examples in
[test/examples.jl](test/examples.jl), plotted via script in [test/demos.jl](test/demos.jl).


![cross](./test/references/Zarate/cross.png "cross")

![loop](./test/references/Zarate/loop.png "loop")

![medium_pert](./test/references/Zarate/medium_pert.png "medium_pert")

![sankey_3twos](./test/references/Zarate/sankey_3twos.png "sankey_3twos")

![tiny_depgraph](./test/references/Zarate/tiny_depgraph.png "tiny_depgraph")

![tree](./test/references/Zarate/tree.png "tree")

![two_lines](./test/references/Zarate/two_lines.png "two_lines")

![xcross](./test/references/Zarate/xcross.png "xcross")
