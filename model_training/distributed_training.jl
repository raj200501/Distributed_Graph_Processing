using Distributed, LightGraphs
using LinearAlgebra
using CSV, DataFrames

function local_pagerank(g::SimpleGraph, damping_factor::Float64=0.85, max_iter::Int=100, tol::Float64=1e-6)
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

function distributed_training(data_dir::String; num_workers::Int=1)
    if nprocs() < num_workers + 1
        addprocs(num_workers)
    end

    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    @sync @distributed for p in 1:nprocs()
        ranks = local_pagerank(g)
        println("PageRank from process $p is $ranks")
    end
end

function distributed_training(data_dir::String)
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    @distributed for _ in 1:procs()
        ranks = distributed_pagerank(data_dir)
        println("PageRank from process $p is $ranks")
    end
end

function distributed_training(data_dir::String)
    return distributed_training(data_dir; num_workers=1)
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    distributed_training(data_dir)
end

main()
