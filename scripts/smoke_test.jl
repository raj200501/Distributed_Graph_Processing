using CSV, DataFrames, LightGraphs

include("../utils/data_loading.jl")
include("../graph_algorithms/distributed_pagerank.jl")
include("../graph_algorithms/distributed_node2vec.jl")
include("../graph_algorithms/distributed_community_detection.jl")
include("../model_training/model_aggregation.jl")

function smoke_test(data_dir::String)
    nodes, edges = load_graph_data(data_dir)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    ranks = compute_pagerank(g)
    @assert length(ranks) == nrow(nodes)

    walks = distributed_node2vec(g, 1, 10, 1.0, 1.0)
    @assert !isempty(walks)

    communities = louvain_method(g)
    @assert length(communities) >= 1

    aggregated = model_aggregation([rand(5), rand(5)])
    @assert size(aggregated, 2) == 5

    println("Smoke test passed.")
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    ispath(data_dir) || mkpath(data_dir)
    if !(isfile(joinpath(data_dir, "nodes.csv")) && isfile(joinpath(data_dir, "edges.csv")))
        include("../graph_data/generate_graph_data.jl")
    end
    smoke_test(data_dir)
end

main()
