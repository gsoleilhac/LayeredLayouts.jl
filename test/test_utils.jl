"Returns a directory in <Pkg>/test/references/<filename>/<fn>.png"
macro ref_str(fn)
    all_references_dir = joinpath(@__DIR__, "references")
    quote
        filename = splitext(basename(string($(QuoteNode(__source__)).file)))[1]
        file_reference_dir = mkpath(joinpath($all_references_dir, filename))
        joinpath(file_reference_dir, string($fn, ".png"))
    end |> esc
end

function quick_plot(graph, xs, ys)
    nv(graph)==length(xs) == length(ys) || error("need 1 position per vertex")
    scatter(xs, ys; markeralpha=0, text=string.(vertices(graph)))

    # now draw connections
    lxs = Float64[]
    lys = Float64[]
    for edge in edges(graph)
        append!(lxs, [xs[edge.src], xs[edge.dst], NaN])
        append!(lys, [ys[edge.src], ys[edge.dst], NaN])
    end
    plot!(lxs, lys; legend=false)
end

quick_plot_solve(layout, graph) = quick_plot(graph, solve_positions(layout, graph)...) 

@testset "test_utils.jl" begin
    @testset "quick_plot" begin
        @plottest quick_plot(SimpleDiGraph(Edge.([1=>2, 2=>3])), [1,2,5], [1,2,3]) ref"quick_plot"
    end
end