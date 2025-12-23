using Distributed, LightGraphs, CSV, DataFrames
using LinearAlgebra

@everywhere function compute_pagerank(g::SimpleGraph, damping_factor::Float64=0.85, max_iter::Int=100, tol::Float64=1e-6)
    num_nodes = nv(g)
    ranks = fill(1.0 / num_nodes, num_nodes)
    for _ in 1:max_iter
        prev_ranks = copy(ranks)
        for v in vertices(g)
            ranks[v] = (1 - damping_factor) / num_nodes + damping_factor * sum(prev_ranks[w] / outdegree(g, w) for w in neighbors(g, v))
        end
        if norm(ranks - prev_ranks) < tol
            break
        end
    end
    return ranks
end

function distributed_pagerank(data_dir::String)
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    ranks = compute_pagerank(g)
    return ranks
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    ranks = distributed_pagerank(data_dir)
    println("PageRank computed successfully.")
end

main()
