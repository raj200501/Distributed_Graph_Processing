using GraphPlot, LightGraphs, GraphRecipes, Plots
using CSV, DataFrames

function plot_graph(nodes, edges)
    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end
    graphplot(g)
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    plot_graph(nodes, edges)
    println("Graph plotted successfully.")
end

main()
