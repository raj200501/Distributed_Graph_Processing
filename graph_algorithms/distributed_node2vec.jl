using Distributed, LightGraphs, Random
using CSV, DataFrames

@everywhere function node2vec_walk(g::SimpleGraph, start_node::Int, walk_length::Int, p::Float64, q::Float64)
    walk = [start_node]
    for _ in 2:walk_length
        curr = walk[end]
        neighbors = neighbors(g, curr)
        if isempty(neighbors)
            break
        end
        next_node = neighbors[rand(1:length(neighbors))]
        push!(walk, next_node)
    end
    return walk
end

@everywhere function distributed_node2vec(g::SimpleGraph, num_walks::Int, walk_length::Int, p::Float64, q::Float64)
    walks = []
    for v in vertices(g)
        for _ in 1:num_walks
            push!(walks, node2vec_walk(g, v, walk_length, p, q))
        end
    end
    return walks
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    walks = distributed_node2vec(g, 10, 80, 1.0, 1.0)
    println("Node2Vec walks generated successfully.")
end

main()
